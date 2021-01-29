import java.util.*;
import java.net.*;
import java.io.*;
import java.nio.file.*;

class TCPServer
{
    void server() throws Exception
    {
	ServerSocket ss = new ServerSocket(3333);
	Socket sock = new Socket();
	sock = ss.accept();

	DataInputStream din = new DataInputStream(sock.getInputStream());
	DataOutputStream dout = new DataOutputStream(sock.getOutputStream());

	String fileName = din.readUTF();
	List<String> lines = Files.readAllLines(Paths.get(fileName));

	for(int i=0; i<lines.size(); i++)
	    {
		System.out.println("Server :"+lines.get(i));
		dout.writeUTF(lines.get(i));
	    }
	ss.close();
	din.close();
	dout.close();
	sock.close();
    }

    public static void main(String args[]) throws Exception
    {
	TCPServer s = new TCPServer();
	s.server();
    }
}

	    
	
