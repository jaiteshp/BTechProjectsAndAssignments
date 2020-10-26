from scapy.all import * 
import string

interface = "enp0s3"
filter_bpf = "tcp and port 5021 and ip src 10.0.2.15"

ip = IP(src = "10.0.2.4", dst = "10.0.2.15")
SYN = TCP(sport = 1042, dport = 5021, flags = 'S', seq = 12345)

N = 125
dataString = ''.join('CS17B021'
	for i in range(N))

packet1 = ip/SYN

SYNACK = sr1(packet1)

print(SYNACK.summary())

packet2 = ip/TCP(sport = 1042,
 dport = 5021, 
 flags = 'A',
  seq = SYNACK.ack,
   ack = SYNACK.seq + 1)
send(packet2)
print('Sent ack after SA')
print(packet2.summary())

#three way hand shake done

time.sleep(0.5)

dataPacket1 = ip/TCP(sport = 1042,
 dport = 5021, 
 flags = 'PA',
 seq = SYNACK.ack,
 ack = SYNACK.seq + 1)/dataString

print('received dataAck1')



dataAck1 = sr1(dataPacket1)

print('Sent dataPacket1')
print('received dataAck1')
print(dataAck1.summary())

dataPacket2 = ip/TCP(sport = 1042,
 dport = 5021, 
 flags = 'PA',
 seq = dataAck1[TCP].ack,
 ack = dataAck1[TCP].seq)/dataString

print('now sending dataPacket2')

time.sleep(0.5)
dataAck2 = sr1(dataPacket2)

print('received dataAck2')
print(dataAck2.summary())

finPacket1 = ip/TCP(sport = 1042,
	dport = 5021,
	flags = 'FA',
	seq = dataAck2[TCP].ack,
	ack = dataAck2[TCP].seq)

time.sleep(0.5)
print('sending finPacket1 now')
finAck1 = sr1(finPacket1)

print('received finAck1')
print(finAck1.summary())

def finServer(x):
	global ip
	tcp = x[TCP]

	print('received FA packet from server')
	print(x.summary())

	seq = tcp.ack
	ack = tcp.seq + 1

	ACK2 = TCP(sport = 1042, dport = tcp.sport, flags = 'A', seq = seq , ack = ack)
	Ack2 = ip/ACK2

	time.sleep(0.5)
	send(Ack2)
	print('sent Ack2')

	return

sniff(iface = interface, filter = filter_bpf, prn = finServer, count = 1)


