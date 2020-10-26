from scapy.all import *

interface = "enp0s3"
filter_bpf = "tcp and port 5021 and ip src 10.0.2.4"

ip = IP(src = "10.0.2.15", dst = "10.0.2.4")
ack = 0
seq = 9998

def tcpSynResp_threeWay(x):
	global ip
	global ack
	global seq

	tcp = x[TCP]

	ack = tcp.seq + 1

	print('recieved syn packet')
	print(x.summary())
	
	SYNACK = TCP(sport = 5021, dport = tcp.sport, flags = 'SA', seq = seq, ack = ack)
	seq = seq + 1
	p1 = ip/SYNACK
	
	ackPacket = sr1(p1)
	print('sent SA')
	print(p1.summary())
	print('recieved ackPacket')
	print(ackPacket.summary())

	print('now sniffing for PA packet')
	sniff(iface = interface, filter = filter_bpf, prn = tcpPA1, count = 1)

	return

def tcpPA1(x):
	global ip
	global ack
	global seq
	print('recieved PA1')
	print(x.summary())
	
	tcp = x[TCP]
	
	ack = tcp.seq + 1000

	ACK1 = TCP(sport = 5021, dport = tcp.sport, flags = 'A', seq = seq , ack = ack)
	dataAck1 = ip/ACK1

	time.sleep(0.5)
	send(dataAck1)
	print('sent dataAck1')
	sniff(iface = interface, filter = filter_bpf, prn = tcpPA2, count = 1)
	return

def tcpPA2(x):
	global ip
	global ack
	global seq
	print('recieved PA2')
	print(x.summary())
	
	tcp = x[TCP]
	
	ack = tcp.seq + 1000

	ACK1 = TCP(sport = 5021, dport = tcp.sport, flags = 'A', seq = seq , ack = ack)
	dataAck2 = ip/ACK1

	time.sleep(0.5)
	send(dataAck2)
	print('sent dataAck2')
	sniff(iface = interface, filter = filter_bpf, prn = tcpFA1, count = 1)
	return

def tcpFA1(x):
	global ip
	global ack
	global seq
	print('recieved FA1')
	print(x.summary())
	
	tcp = x[TCP]
	
	ack = tcp.seq + 1

	ACK1 = TCP(sport = 5021, dport = tcp.sport, flags = 'A', seq = seq , ack = ack)
	FinAck1 = ip/ACK1

	time.sleep(0.5)
	send(FinAck1)
	print('sent FinAck1')

	FINACK2 = TCP(sport = 5021, dport = tcp.sport, flags = 'FA', seq = seq , ack = ack)
	FinAck2 = ip/FINACK2

	time.sleep(0.5)
	Ack2 = sr1(FinAck2)
	print('sent FinAck2')

	print('recieved Ack2')
	print(Ack2.summary())

	return

sniff(iface = interface, filter = filter_bpf, prn = tcpSynResp_threeWay, count = 1)


