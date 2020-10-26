Execute the following command as root at BOTH PS1 and PS2 (for Bonus part too) to avoid TCP connection reset (This command drops the TCP RST Packets)

   'sudo iptables -A OUTPUT -p tcp --tcp-flags RST RST -j DROP'