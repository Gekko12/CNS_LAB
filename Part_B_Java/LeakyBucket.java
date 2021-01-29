//implementing leaky bucket algorithm

import java.util.*;

class LeakyBucket
{
    int burst, size, rate;
    int incoming, outgoing, pending, overflow;

    LeakyBucket(int burst, int rate, int size)
    {
	incoming = outgoing= pending = overflow = 0;
	this.burst = burst;
	this.rate = rate;
	this.size = size;
    }

    void  algo()
    {
	System.out.println("Time  Incoming  Pending  Overflow  Outgoing");
	int time = 0;
	Random r = new Random();
	while(time < 8)
	    {
		incoming = r.nextInt(burst);
		if((incoming+pending) > size)
		    {
			pending = size;
			overflow = (incoming+pending) -size;
		    }
		else
		    {
			pending += incoming;
			overflow = 0;
		    }
		output(time, incoming, pending, overflow, outgoing);
		outgoing = Math.min(rate, pending);
		pending -= outgoing;
		time ++;
	    }
    }

    void output(int t, int inc, int pen, int overf, int out)
    {
	System.out.printf(" %d\t  %d\t   %d\t   %d\t   %d \n", t, inc, pen, overf, out);
    }

    public static void main(String[] args)
    {
		Scanner sc = new Scanner(System.in);

	System.out.println("Enter burst size:");
	int burst = sc.nextInt();

	System.out.println("Enter bucket size:");
	int size = sc.nextInt();

	System.out.println("Enter outgoing rate:");
	int rate = sc.nextInt();
	
	LeakyBucket lb = new LeakyBucket(burst, rate, size);
	
	lb.algo();

	sc.close();
    }
}

	  
	









