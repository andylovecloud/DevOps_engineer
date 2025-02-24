#After the Java lab, if you restart Jenkins and encounter an error that Jenkins cannot be started, try the following steps:
#1. Check Jenkins log
sudo systemctl status jenkins

#2. Check Jenkins log
sudo cat /var/log/jenkins/jenkins.log

#3. Check the Java version that is set by default with the following command:
sudo update-alternatives --config java
#The returned result will show the Java versions, for example below:
There are 2 choices for the alternative java (providing /usr/bin/java).

Selection Path Priority Status
---------------------------------------------------------
* 0 /usr/lib/jvm/java-19-openjdk-amd64/bin/java 1911 auto mode
1 /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1711 manual mode
2 /usr/lib/jvm/java-19-openjdk-amd64/bin/java 1911 manual mode
Press <enter> to keep the current choice[*], or type selection number:

#In this case my Java is pointing to version 19 (the * position), and Jenkins requires version 17,
#so I will select version 17 by typing number 1 and pressing enter.

#check again:
sudo update-alternatives --config java
#result (The * sign points to number 1)
There are 2 choices for the alternative java (providing /usr/bin/java).

 Selection Path Priority Status
--------------------------------------------------------------
 0 /usr/lib/jvm/java-19-openjdk-amd64/bin/java 1911 auto mode
* 1 /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1711 manual mode
 2 /usr/lib/jvm/java-19-openjdk-amd64/bin/java 1911 manual mode

Press <enter> to keep the current choice[*], or type selection number: #Press Enter to skip.

#Run command to restart jenkins:
sudo systemctl restart jenkins
#Test access on normal browser.

================================================================================

# TROUBLESHOOT JENKINS LOADING LONG WHEN ACCESSING
    
# Because EC2 Public IP in case you do not use Elastic IP for Jenkins server will also be automatically changed when stopping/starting the server, this affects the frontend of Jenkins cannot load the necessary Javascript/css leading to the homepage loading very long (from 1-2 minutes). To fix it, do the following:

# Step 1. Access the Jenkins management interface (Manage Jenkins).

# Step 2. Find the System section, scroll down to Jenkins Location

# Step 3. Replace Jenkins URL with public IP of EC2 Instance, for example: http://13.251.189.181:8080

# Step 4. Test Jenkins access again, if it does not take long to load, it is OK.