#Create a repo on Github (private repository).
#Create an SSH key following Github's guide. *Google keyword: “github create ssh key”
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows

#Create an ssh key on your local machine. Open Gitbash and run the following command. Replace email with your email.
ssh-keygen -t ed25519 -C "your_email@example.com"
#Choose where to save the key: the default will be c:\Users\YOU\.ssh\id_ed25519. Enter if you don't want to change.

#Enter Passphrase: Enter if you don't want to change.

#Configure the private key on your local machine.
##Open Powershell as admin. Windows -> Search -> Type Powershell -> Right click -> Run as administrator.
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
#Run without errors is OK.

#Add private key to ssh-agent. (Replace admin = your user name)
ssh-add "C:\Users\admin\.ssh\id_ed25519"
#Confirm again = the following command, if the ssh key list appears, it is OK.
ssh-add -L

#Add public key to Github account setting.
##Copy the content of the id_ed25519.pub file.
##On Github Avatar on the right corner: Settings -> SSH and GPG keys -> New SSH key -> Paste the content of the id_ed25519.pub file -> Add SSH key.

#Try checkout a repo using SSH key. Replace the repo URL with your repo.
git clone git@github.com:andylovecloud/Test-private-repo.git

