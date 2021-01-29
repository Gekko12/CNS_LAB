//implementing RSA(Rivert, Shamir and Aldeman) algorithm

import java.util.*;

class RSA
{
    int x, y , n, a, b;
    String msg;
    
    int gcd(int m, int n)
    {
	if(n == 0)
	    return m;
	return gcd(n, m%n);
    }

    // (a^b)%c
    int pow(int a, int b, int c)
    {
	int r = 1;
	while(b-- != 0)
	    r = (r*a) %c;
	return r;
    }
	
    void rsa()
    {
	a = 11;
	b = 13;
	n = a*b;
	
	int z = (a-1)*(b-1);

	for(x=2; gcd(x,z) != 1; x++)
	    ;

	for(y=2; (x*y)%z != 1; y++)
	    ;

	System.out.println("Public Key, S = ("+x+", "+n+") ");
	System.out.println("Private Key, P = ("+y+", "+n+") ");
    }

    void cipher(char[] C, int a, int b)
    {
	for(int i=0; i < C.length ; i++)
	    C[i] = (char) pow(C[i], a, b);

	System.out.println("C : "+String.valueOf(C));
    }

    void input()
    {
	Scanner sc = new Scanner(System.in);
	System.out.println("Enter the message :");
	msg = sc.next();
	sc.close();
    }

    void output()
    {
	char[] M = msg.toCharArray();
	System.out.print("Encoded message ");
	cipher(M, x, n);
	System.out.print("Decoded message ");
	cipher(M, y, n);
    }

    public static void main(String[] args)
    {
	RSA r = new RSA();
	r.input();
	r.rsa();
	r.output();
    }
}
	
