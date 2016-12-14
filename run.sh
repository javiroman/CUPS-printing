#
#
# src
# ├── main
# │   ├── java
# │   │   └── cupsTPV
# │   │       ├── CupsTest.java
# │   │       ├── Ping.java
# │   │       ├── Print.java -> more complete example 
# │   │       ├── HelloPrinter.java
# │   │       └── PrintTextFile.java

# 1. Cups4j package:
#    Running with the whole JAR with all dependencies donwloaded from cups4j site.
java -cp "third-party/cups4j.runnable-0.6.4.jar:target/cupstest-1.0-SNAPSHOT.jar" \
	-Djava.net.preferIPv4Stack=true cupsTPV.CupsTest

# 2. JDK Print Service API (Package javax.print)
# java -cp target/classes/. HelloPrinter
# java -cp target/classes/. PrintTextFile 
# java -cp target/classes/. Print -i /tmp/foo.txt -p Cups-PDF 


