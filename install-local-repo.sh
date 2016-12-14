# Install third party JAR file in local repository
mvn install:install-file  \
	-DlocalRepositoryPath=src/main/resources/repo \
	-DcreateChecksum=true \
	-Dpackaging=jar \
	-Dfile=third-party/cups4j-0.6.4.jar \
	-DgroupId=cups4j \
	-DartifactId=cups4j \
	-Dversion=0.6.4

# Check the new local repository
mvn help:effective-pom | grep url

# Create application (JAR)
mvn package

# Check the application
java -cp target/cupstest-1.0-SNAPSHOT.jar cupsTPV.App
