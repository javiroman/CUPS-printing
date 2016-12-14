package cupsTPV;

import java.util.Date;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.nio.channels.SocketChannel ;
import java.io.IOException;

public class Ping {
	public static void ping(String ip){
		try{
			InetAddress address = InetAddress.getByName(ip);
			boolean reachable = address.isReachable(10000);

			System.out.println("host on: " + reachable);

		} catch (Exception e){
			e.printStackTrace();

		}

	}

	/**
	 * Connect using layer4 (sockets)
	 * 
	 * @param
	 * @return delay if the specified host responded, -1 if failed
	 */
	static long ping2(String hostAddress, int port) {
		InetAddress inetAddress = null;
		InetSocketAddress socketAddress = null;
		SocketChannel sc = null;
		long timeToRespond = -1;
		Date start, stop;

		try {
			inetAddress = InetAddress.getByName(hostAddress);
		} catch (UnknownHostException e) {
			System.out.println("Problem, unknown host:");
			e.printStackTrace();
		}

		try {
			socketAddress = new InetSocketAddress(inetAddress, port);
		} catch (IllegalArgumentException e) {
			System.out.println("Problem, port may be invalid:");
			e.printStackTrace();
		}

		// Open the channel, set it to non-blocking, initiate connect
		try {
			sc = SocketChannel.open();
			sc.configureBlocking(true);
			start = new Date();
			if (sc.connect(socketAddress)) {
				stop = new Date();
				timeToRespond = (stop.getTime() - start.getTime());
			}
		} catch (IOException e) {
			System.out.println("Problem, connection could not be made:");
			timeToRespond = 0;
		}

		try {
			sc.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// return 0 value if error
		return timeToRespond;
	}
}
