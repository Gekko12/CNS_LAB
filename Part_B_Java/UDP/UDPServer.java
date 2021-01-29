import java.util.*;
import java.net.*;

    
class UDPServer
{
    void server() throws Exception
    {
	DatagramSocket sock = new DatagramSocket(3333);
	DatagramPacket pkt = new DatagramPacket(new byte[1024], 1024);

	sock.receive(pkt);
	InetAddress adr = pkt.getAddress();
	int port = pkt.getPort();

	System.out.println("Server side typed -");
	Scanner sc = new Scanner(System.in);
	String msg;

	do{
	    msg = sc.nextLine();
	    pkt = new DatagramPacket(msg.getBytes(), msg.length(), adr, port);
	    sock.send(pkt);
	}while(Boolean.TRUE);

	sock.close();
	sc.close();
    }

    public static void main(String[] args) throws Exception
    {
	UDPServer s = new UDPServer();
	s.server();
    }
}
	
	
