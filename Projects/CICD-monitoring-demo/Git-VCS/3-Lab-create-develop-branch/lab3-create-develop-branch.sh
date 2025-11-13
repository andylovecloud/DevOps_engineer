#Create develop branch from master branch of newly checked out repository.
git checkout -b develop
#Create/edit some files eg: index.html, README.md
#Add files to staging area.
git add .
#Commit files to develop branch.
git commit -m "Add index.html and modify README.md"
#Push develop branch to Github repository.
git push origin develop