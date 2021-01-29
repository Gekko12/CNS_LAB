import java.util.*;
import java.net.*;
import java.io.*;

class TCPClient
{
    void client() throws Exception
    {
	Socket sock = new Socket("localhost", 3333);

	DataInputStream din = new DataInputStream(sock.getInputStream());
	DataOutputStream dout = new DataOutputStream(sock.getOutputStream());
	Scanner sc = new Scanner(System.in);
	
	System.out.println("Enter file name:");
	String fileName = sc.next();

	dout.writeUTF(fileName);
	String msg;
	
	do{
	    msg = din.readUTF();
	    System.out.println(msg);
	}while(!msg.equals("stop"));
	       
	sc.close();
	din.close();
	dout.close();
	sock.close();
    }

    public static void main(String args[]) throws Exception
    {
	TCPClient c = new TCPClient();
	c.client();
    }
}

