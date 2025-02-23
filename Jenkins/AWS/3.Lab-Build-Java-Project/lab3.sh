#Configuration Java for Jenkins
#Type the following command to find out where Java is installed:
javac
#Find out where Java is installed
java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' 

#Access Jenkins -> Manage Jenkins -> Tool
#In JDK Installation, select Add JDK, input name và path to JAVA HOME, Ex:
/usr/lib/jvm/java-19-openjdk-amd64

#Configuration Maven for Jenkins
#Access Jenkins -> Manage Jenkins -> Tool
#In Maven Installation, select Add Maven, input name and path to Maven, Ex:
#Select Add installer select "Install from Apache"
#Select version maven, Ex: 3.9.6
#Click Save.

#Create a new job java
Buildjob3-simple-Java-project

#Link git hub repo:
https://github.com/andylovecloud/simple-java-maven-app.git

#Branch:
*/main

#Build steps: add "Invoke top-level Maven targets"
#MavenVersion: select maven version installed
#Goals: 
clean install

#Add more IAM Role for Jenkins, add policy "S3FullAccess"

#Add more step upload to S3


#Install unzip
sudo apt install unzip

#Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


#Shell script
aws s3 cp "${WORKSPACE}/target/my-app-1.0-SNAPSHOT.jar" "s3://udemy-jenkins-andylab3/jenkins/${BUILD_ID}/"