import socket
import time
import threading
import sys
import collections
import getopt

UDP_IP = "127.0.0.40"
UDP_PORT_C = 5004
UDP_PORT_S = 5005
debug = False

Sequence_Field_Length = 2
PACKET_LENGTH = 1600
PACKET_GEN_RATE = 100
MAX_PACKETS = 10000
WINDOW_SIZE = 3
MAX_BUFFER_SIZE = 10
timeout = 0.3
timerFlag = False
start_time = 0

tt = [0] * (MAX_PACKETS+1)
rt = [0] * (MAX_PACKETS+1)
gt = [0] * (MAX_PACKETS+1)
rtt = [0] * (MAX_PACKETS+1)
tno = [0] * (MAX_PACKETS+1)
ack = [False] * MAX_PACKETS
buff = collections.deque([])
window = collections.deque([])
ap = -1
cp = 0
ackCount = 0
trCount = 0
lp = -1

l1 = threading.Lock()

def getNum(s1):
	x = str(s1).split("~")
	num = int(x[0])
	return num

def retStr(sno):
	t = str(sno) + "~"
	for i in range(0,PACKET_LENGTH/8):
		t += "."
	return (t)
def retTime():
	return (time.time())

def gen():
	global MAX_PACKETS
	global PACKET_GEN_RATE
	global MAX_BUFFER_SIZE
	global ap
	global cp
	global buff
	global tt
	while (cp<MAX_PACKETS):
		# print "46, "
		if(len(buff)<MAX_BUFFER_SIZE):
			time.sleep(1/PACKET_GEN_RATE)
			buff.append(retStr(cp))
			# print "48, cp: ", cp
			tt[cp] = time.time()
			gt[cp] = time.time()-start_time
			cp+=1

def timer(s):
	global MAX_PACKETS
	global window
	global ap
	global timeout
	global tt
	global UDP_IP
	global UDP_PORT_S
	global timerFlag
	global tno
	global trCount
	global l1
	global lp

	while (ap<MAX_PACKETS-1):
		# print "74, timerFlag: ", timerFlag
		if(not timerFlag):
			# time.sleep(0.005)
			continue
		# try:
		l1.acquire()
		for i in range(0,len(window)):
			# print "80, window: ", window
			# print "81, lp: ", lp
			num = getNum(window[i])
			if((time.time()-tt[num])>timeout):
				s.sendto(retStr(num), (UDP_IP, UDP_PORT_S))
				tt[num] = time.time()
				tno[num] += 1
				if(tno[n] > 10):
					print "The no of transmissions for the packet: ", n, " have exceeded 10"
					s.sendto(retStr(-10), (UDP_IP, UDP_PORT_S))
					exit()
				trCount += 1 

		l1.release()
		# except:
		# 	continue

if __name__ == "__main__":

	options, remainder = getopt.getopt(sys.argv[1:], 'ds:p:L:R:N:W:B:n:') 

	for opt, arg in options:
		if opt == '-d':
			debug = True
		elif opt == '-s':
			UDP_IP = arg
		elif opt == '-p':
			UDP_PORT_S = int(arg)
		elif opt == '-L':
			PACKET_LENGTH = int(arg)
		elif opt == '-R':
			PACKET_GEN_RATE = int(arg)
		elif opt == '-N':
			MAX_PACKETS = int(arg)
		elif opt == '-W':
			WINDOW_SIZE = int(arg)
		elif opt == '-B':
			MAX_BUFFER_SIZE = int(arg)
		elif opt == '-n':
			Sequence_Field_Length = int(arg)

	start_time = time.time()
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.bind((UDP_IP, UDP_PORT_C))

	gen_thread = threading.Thread(target = gen, args = ())
	timer_thread = threading.Thread(target = timer, args = (s,))

	gen_thread.start()
	timer_thread.start()
	# time.sleep(0.1)

	while (ap<MAX_PACKETS-1):

		# print "104, "

		l1.acquire()
		while(len(window)<WINDOW_SIZE and len(buff)>0):
			# print "108, "
			n = getNum(buff[0])
			buff.popleft()
			window.append(retStr(n))
			s.sendto(retStr(n), (UDP_IP, UDP_PORT_S))
			tt[n] = time.time()
			tno[n] += 1
			if(tno[n] > 10):
				print "The no of transmissions for the packet: ", n, " have exceeded 10"
				s.sendto(retStr(-10), (UDP_IP, UDP_PORT_S))
				exit()
			trCount += 1 
		l1.release()

		timerFlag = True
		data, addr = s.recvfrom(1024)
		timerFlag = False

		# l1.acquire()

		n1 = getNum(data)
		# n0 = getNum(window[0])

		# if(n1 < n0):
		# 	print "124, Some error has occured"

		# print "131, rcvdack: ", n1
		ack[n1] = True
		rt[n1] = time.time()
		rtt[n1] = rt[n1] - tt[n1]
		
		if(debug):
			print "Time Generated: ", int(gt[n1]*1000), ":", int(gt[n1]*1000000)%1000, "\tNumber of Attempts: ", tno[n1], "\tRTT: ", rtt[n1]
		
		ackCount += 1

		if(n1 == 10):
			k = 0
			for j in range(0,10):
				k += rtt[j]
			timeout = 2 * (k/10)

		l1.acquire()
		while(len(window)>0):
			n2 = getNum(window[0])
			if(ack[n2]):
				window.popleft()
				lp = n2
				ap += 1
			else:
				break
		l1.release()


		# count = 0

		# for i in range(0, len(window)):
		# 	print "137, "
		# 	try:
		# 		num = getNum(window[i])
		# 		if(ack[num]):
		# 			# window.popleft()

		# 			count += 1
		# 		else:
		# 			break
		# 	except:
		# 		break
		# 	for j in range(0,count):
		# 		window.popleft()
		# 	ap += 1


		# l1.release()

		# timerFlag = False

	# print "160, "

	gen_thread.join()
	timer_thread.join()

	# print "188, tno: ", tno
	# print "189, rtt: ", rtt

	tottime = 0
	for i in range(0,len(rt)):
		tottime += rtt[i]

	AveRTTFinal = tottime/MAX_PACKETS

	# print "197, AveRTTFinal: ", AveRTTFinal

	RetransmissionRatio = float (trCount/float (ackCount))

	# print "201, RetransmissionRatio: ", RetransmissionRatio, trCount, ackCount

	print "PACKET_GEN_RATE: \t", PACKET_GEN_RATE
	print "PACKET_LENGTH: \t\t", PACKET_LENGTH
	print "RetransmissionRatio: \t", RetransmissionRatio
	print "Average_RTT: \t\t", AveRTTFinal

	s.close()


