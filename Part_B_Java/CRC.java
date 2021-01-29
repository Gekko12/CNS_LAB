import java.util.*;

class CRC
{
    int W;
    String message, chksum, P;

    CRC()
    {
	W = 16;
	P = "10001000000100001";
    }

    void algo()
    {
	String msg = message + "0000000000000000";
	char[] rem = new char[P.length()];

	for(int i=0; i<msg.length(); i++)
	    {
		rem[W] = msg.charAt(i);
		boolean xor = (rem[0] == '1');

		for(int j=1; j<= W; j++)
		    {
			if(xor)
			    rem[j] = (rem[j] == P.charAt(j)? '0':'1');
			rem[j-1] = rem[j];
		    }
	    }
	chksum = String.valueOf(rem).substring(0, W);
	System.out.println("CheckSum : "+chksum);
    }

    void input()
    {
	
	Scanner sc = new Scanner(System.in);

	System.out.println("Enter message : ");
	message = sc.next();

	sc.close();

    }
	
    public static void main(String[] args)
    {
	CRC c = new CRC();
	c.input();
	c.algo();
    }
}
	
	
	
