package cupsTPV;

import java.util.List;
import java.net.URL;
import java.io.FileInputStream;

import org.cups4j.CupsClient;
import org.cups4j.CupsPrinter;
import org.cups4j.PrintJob;
import cupsTPV.Ping;

/**
 * Simple CUPS tests
 *
 */
public class CupsTest
{
    public static void main(String[] args)
    {
   	List<CupsPrinter> printers = null;

	try {
		/*
		 * List of availables queues in local CUPS server
		 */
		String hostname = "localhost";
		int port = 631;
		long isUp = 0;
	   
		CupsClient cupsClient = new CupsClient(hostname, port);
		printers = cupsClient.getPrinters();

		for (CupsPrinter p : printers) {
		   System.out.println(p.toString());
		   System.out.print("Description -> ");
		   System.out.println(p.getDescription());
		   System.out.print("URI -> ");
		   System.out.println(p.getPrinterURL());
		}

		/*
		 * Simple printing in real network printer
		 */
		URL url = new URL("http://localhost:631/printers/MER-MPC4502-Sala-RH");
		CupsPrinter cupsPrinter = new CupsPrinter(url, 
				"MER-MPC4502-Sala-RH", 
				false);

		System.out.print("Printing job in: ");
		System.out.println(cupsPrinter.getName());

		FileInputStream fis = new FileInputStream("/tmp/test.pdf");
		PrintJob pj = new PrintJob.Builder(fis).jobName("testJob").build();
		//cupsPrinter.print(pj);

		/*
		 * Printing logic with network printer detecction
		 */
		Ping pin = new Ping();
		// http://bugs.java.com/bugdatabase/view_bug.do?bug_id=4921816
		//pin.ping("127.0.0.1");
		isUp = pin.ping2("127.0.0.1", port);
		if (isUp == 0) {
			System.out.println("printer offline");
		}
		else {
			System.out.println("printer online");
		}
			


      	} catch (Exception e) {
        	e.printStackTrace();
      	}

        System.out.println( "bye." );
    }
}

   
      
