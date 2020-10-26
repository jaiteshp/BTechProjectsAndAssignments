import socket
import time
import threading
import sys
import random
import getopt

UDP_IP = "127.0.0.38"
UDP_PORT_C = 5004
UDP_PORT_S = 5005
oldData = "-1~"
RANDOM_DROP_PROB = 0.1
start_time = 0
debug = False

PACKET_LENGTH = 64
MAX_PACKETS = 10000
successfulPackets = 0
reqSeqNum = 0


def getSeqNum(pkt):
	x = pkt.split('~')
	num = int(x[0])
	return num

options, remainder = getopt.getopt(sys.argv[1:], 'ds:p:n:e:') 

for opt, arg in options:
	if opt == '-d':
		debug = True
	elif opt == '-p':
		UDP_PORT_S = int(arg)
	elif opt == '-n':
		MAX_PACKETS = int(arg)
	elif opt == '-e':
		RANDOM_DROP_PROB = float(arg)

start_time = time.time()
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

s.bind((UDP_IP, UDP_PORT_S))

while (successfulPackets < MAX_PACKETS):	
	data, addr = s.recvfrom(1024)
	n5 = getSeqNum(data)
	if(n5==-10):
		print "The transmission is stopped due to no of transmissions exceeding 5"
		exit()
	x = random.random()
	if(x < RANDOM_DROP_PROB):
		num1 = getSeqNum(data)
		t1 = time.time()
		if(debug):
			print "Seq#: ", num1, " \tTime Recieved: ", int(1000 * (t1-start_time)), ":", int(1000000 * (t1-start_time)) % 1000, " \tPacket dropped: True"
		continue
	# print "Server recieved: ", data, "from addr: ", addr, " reqs: ", reqSeqNum

	if(getSeqNum(data) == reqSeqNum):
		s.sendto(data, addr)
		oldData = data
		successfulPackets+=1
		reqSeqNum+=1
		num1 = getSeqNum(data)
		t1 = time.time()
		if(debug):
			print "Seq#: ", num1, " \tTime Recieved: ", int(1000 * (t1-start_time)), ":", int(1000000 * (t1-start_time)) % 1000, " \tPacket dropped: False"

s.close() 