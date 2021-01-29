BEGIN {
    count = 0;
}
{
    if ($1 == "d" )
	count ++;
}
END {
    printf("Number of packets dropped due to congestion : %d \n", count);
}
s
