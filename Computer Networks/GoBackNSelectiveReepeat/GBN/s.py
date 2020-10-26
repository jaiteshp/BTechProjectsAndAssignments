import socket
import time
import threading
import sys
import collections
import getopt

UDP_IP = "127.0.0.38"
UDP_PORT_C = 5004
UDP_PORT_S = 5005

PACKET_LENGTH = 16
PACKET_GEN_RATE = 10
MAX_PACKETS = 10000
WINDOW_SIZE = 3
MAX_BUFFER_SIZE = 10
timeout = 0.01
timerFlag = False 
debug = False

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
start_time = 0

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

	while (ap<MAX_PACKETS-1):
		if(not timerFlag):
			continue
		# print "64, "
		try:
			n0 = getNum(window[0])
		except:
			continue
		n1 = n0 + len(window)

		if(len(window) == 0):
			continue
		elif((time.time()-tt[n0])>timeout):
			# print "72, inside timer"
			for i in range(n0,n1):
				s.sendto(retStr(i), (UDP_IP, UDP_PORT_S))
				tt[i] = time.time()
				tno[i] += 1
				if(tno[n] > 5):
					print "The no of transmissions for the packet:", n, " have exceeded 5"
					s.sendto(retStr(-10), (UDP_IP, UDP_PORT_S))
					exit()
				trCount +=1

if __name__ == "__main__":
	start_time = time.time()
	
	options, remainder = getopt.getopt(sys.argv[1:], 'ds:p:l:r:n:w:b:') 

	for opt, arg in options:
		if opt == '-d':
			debug = True
		elif opt == '-s':
			UDP_IP = arg
		elif opt == '-p':
			UDP_PORT_S = int(arg)
		elif opt == '-l':
			PACKET_LENGTH = int(arg)
		elif opt == '-r':
			PACKET_GEN_RATE = int(arg)
		elif opt == '-n':
			MAX_PACKETS = int(arg)
		elif opt == '-w':
			WINDOW_SIZE = int(arg)
		elif opt == '-b':
			MAX_BUFFER_SIZE = int(arg)

	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.bind((UDP_IP, UDP_PORT_C))

	gen_thread = threading.Thread(target = gen, args = ())
	timer_thread = threading.Thread(target = timer, args = (s,))

	gen_thread.start()
	timer_thread.start()
	time.sleep(0.1)
	
	while (ap<MAX_PACKETS-1):
		# print "86, ", window
		while(len(window)<WINDOW_SIZE and len(buff)>0):
			# print "94, "
			n = getNum(buff[0])
			buff.popleft()
			window.append(retStr(n))
			s.sendto(retStr(n), (UDP_IP, UDP_PORT_S))
			# print "99, n: ", n
			tt[n] = time.time()
			tno[n] += 1
			trCount += 1 

		# print "102, "	
		timerFlag = True
		data, addr = s.recvfrom(1024)

		n1 = getNum(data)
		n0 = getNum(window[0])

		# print "109, "

		if(n1==n0):
			ap=n1
			ack[n1] = True
			rt[n1] = time.time()
			rtt[n1] = rt[n1] - tt[n1]
			ackCount += 1
			
			if(n1 == 10):
				k = 0
				for j in range(0,10):
					k += rtt[j]
				timeout = 2 * (k/10)

			window.popleft()
		timerFlag = False

		# print "107, rcvdack: ", n1
		if(debug):
			print "Time Generated: ", int(gt[n1]*1000), ":", int(gt[n1]*1000000)%1000, "\tNumber of Attempts: ", tno[n1], "\tRTT: ", rtt[n1]

	

	gen_thread.join()
	timer_thread.join()

	# print "143, tno: ", tno

	

	# print "149, rtt: ", rtt

	tottime = 0
	for i in range(0,len(rt)):
		tottime += rtt[i]

	AveRTTFinal = tottime/MAX_PACKETS

	# print "153, AveRTTFinal: ", AveRTTFinal

	RetransmissionRatio = float (trCount/float (ackCount))

	# print "163, RetransmissionRatio: ", RetransmissionRatio, trCount, ackCount

	print "PACKET_GEN_RATE: \t", PACKET_GEN_RATE
	print "PACKET_LENGTH: \t\t", PACKET_LENGTH
	print "RetransmissionRatio: \t", RetransmissionRatio
	print "Average_RTT: \t\t", AveRTTFinal


	s.close()

		

