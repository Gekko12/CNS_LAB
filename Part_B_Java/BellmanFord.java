import java.util.*;

class BellmanFord
{
    int a[][], p[], d[], s, n;
    public final static int INFTY = 999999; 
    
    BellmanFord(int n)
    {
	this.n = n;
	a = new int[n][n];
	p = new int[n];
	d = new int[n];
    }

    void algo()
    {
	for(int i=0; i<n; i++)
	    {
		d[i] = a[s][i];
		p[i] = (a[s][i] == INFTY ? -1:s);
	    }
	p[s] = -1;

	for(int i=0; i<n-1; i++)
	    {
		for(int u=0; u<n; u++)
		    for(int v=0; v<n; v++)
			if(d[v] > d[u]+a[u][v])
			    {
				d[v] = d[u] + a[u][v];
				p[v] = u;
			    }
	    }
    }

    void input(Scanner sc)
    {
	System.out.println("Enter G :");
	for(int i=0;i<n;i++)
	    for(int j=0;j<n;j++)
		{
		    a[i][j] = sc.nextInt();
		    if(i != j  && a[i][j]==0)
			a[i][j] = INFTY;
		}

	System.out.println("Enter Source vertex :");
	s = sc.nextInt();
    }

    void path(int v)
    {
	if(v == -1)
	    return;
	path(p[v]);
	System.out.print("->"+v);
    }

    void output()
    {
	for(int i=0;i<n;i++)
	    {
		System.out.print("d["+s+", "+i+"] ="+d[i]+" :p");
		path(i);
		System.out.println();
	    }
    }

    public static void main(String args[])
    {
	Scanner sc = new Scanner(System.in);
	
	System.out.println("Enter number of vertex :");
	int n = sc.nextInt();

	BellmanFord bf = new BellmanFord(n); 
	bf.input(sc);
	bf.algo();
	bf.output();

	sc.close();
    }
}
	
