import java.util.*;
import java.net.*;

    
class UDPClient
{
    void display(DatagramPacket pkt)
    {
	byte[] p = pkt.getData();
	for(int i=0; i<pkt.getLength(); i++)
	    System.out.print((char)p[i]);
	System.out.println();
    }
    
    void client() throws Exception
    {
	DatagramSocket sock = new DatagramSocket();
	DatagramPacket pkt;
	pkt = new DatagramPacket(new byte[1024], 1024, InetAddress.getByName("localhost"), 3333);

	sock.send(pkt);
	pkt = new DatagramPacket(new byte[1024], 1024);
	do{
	    sock.receive(pkt);
	    display(pkt);
	}while(Boolean.TRUE);

	sock.close();
    }

    public static void main(String[] args) throws Exception
    {
	UDPClient c = new UDPClient();
	c.client();
    }
}
	
	
