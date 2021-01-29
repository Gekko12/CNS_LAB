#a3.awk
#plotting congestion window for different source/destination

BEGIN {
}
{
    if ($6 == "cwnd_")
    {
	if ($2== 0    &&    $4==5)
	    printf("%4.2f\t%4.2f\n", $1, $7);

	#if ($2==2   $$    $4==6)
	#     print("4.2f\t4.2f\n", $1, $7);
    }
}
END {
    puts " DONE !!!! "
}
