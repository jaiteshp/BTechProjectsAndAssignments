from scapy.all import *

def custom_ICMP_reply(x):
	send(IP(dst = x[IP].src)/ICMP(type="echo-reply")/"CS17B021(1) CS17B021(2)", count = 1)
	return

sniff(iface="enp0s3", filter = "icmp and ip src 10.0.2.15", prn = custom_ICMP_reply, count = 5)

