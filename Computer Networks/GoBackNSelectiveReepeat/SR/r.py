import socket
import time
import threading
import sys
import random
import getopt

UDP_IP = "127.0.0.40"
UDP_PORT_C = 5004
UDP_PORT_S = 5005
debug = False

WINDOW_SIZE = 3
MAX_PACKETS = 10000
tr = [0] * (MAX_PACKETS+1)
successfulPackets = 0
RANDOM_DROP_PROB = 0.1
sw = 0
start_time = 0

rcv = [False] * (MAX_PACKETS+1)

def getNum(s1):
	x = str(s1).split("~")
	num = int(x[0])
	return num

def retStr(sno):
	return (str(sno)+"~")


options, remainder = getopt.getopt(sys.argv[1:], 'ds:p:N:n:W:B:e:') 

for opt, arg in options:
	if opt == '-d':
		debug = True
	elif opt == '-p':
		UDP_PORT_S = int(arg)
	elif opt == '-N':
		MAX_PACKETS = int(arg)
	elif opt == '-W':
		WINDOW_SIZE = int(arg)
	elif opt == '-B':
		MAX_BUFFER_SIZE = int(arg)
	elif opt == '-n':
		Sequence_Field_Length = int(arg)
	elif opt == '-e':
		RANDOM_DROP_PROB = float(arg)


start_time = time.time()
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

s.bind((UDP_IP, UDP_PORT_S))

while (successfulPackets < MAX_PACKETS):	
	data, addr = s.recvfrom(1024)
	n5 = getNum(data)
	if(n5==-10):
		print "The transmission is stopped due to no of transmissions exceeding 10"
		exit()
	x = random.random()
	if(x < RANDOM_DROP_PROB):
		continue
	# print "Server recieved: ", data, "from addr: ", addr, ", sw: ", sw, sw+WINDOW_SIZE
	# for i in range(sw, min((sw + WINDOW_SIZE), MAX_PACKETS)):
	# 	print rcv[i]

	n1 = getNum(data)
	if((n1 >= sw) and (n1 < (sw + WINDOW_SIZE))):
		rcv[n1] = True
		tr[n1] = (time.time()-start_time)
		s.sendto(data, addr)
		# successfulPackets += 1

	count = 0

	for i in range(sw, sw + WINDOW_SIZE):
		if(i > MAX_PACKETS-1):
			break
		if(rcv[i]):
			count += 1
		else:
			break

	sw = sw + count
	successfulPackets += count

if(debug):
	for i in range(0,MAX_PACKETS):
		print "Seq#: ", i, "\tTime Received: ", int(tr[i]*1000), ":", int(tr[i]*1000000)%1000
s.close()
