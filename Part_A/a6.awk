#a5.awk
#performance GSM

BEGIN {
    pkt_sent = 0;
    pkt_ack = 0;
}
{
    if($1=="r" && $5=="tcp")
	pkt_sent++;
    if($1=="r" && $5=="ack")
	pkt_ack++;
}
END {
    printf("Packets sent : %3d \n", pkt_sent);
    printf("Packets ack : %3d \n", pkt_ack);
}
