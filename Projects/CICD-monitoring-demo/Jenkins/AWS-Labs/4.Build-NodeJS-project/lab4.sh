#Build a Nodejs project
#Preparation:
#Install Nodejs, refer to the guide:
https://joshtronic.com/2022/04/24/how-to-install-nodejs-18-on-ubuntu-2004-lts/

#List of commands:
sudo apt install curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt install nodejs

# If you got error while installing nodejs, you can try to run below queries:
sudo apt-get --purge remove libc6-dev-amd64 
sudo apt-get -f install
sudo apt-get update
sudo apt install nodejs

#check version
node --version
#ket qua:
v18.19.0

#Get a project from github 
https://github.com/andylovecloud/simple-vue-webpack.git

#Create a new job with type "Pipeline" with the following name:
Buildjob4-simple-vue-webpack-project

#Configure pipeline script:
#View lab4.groovy file