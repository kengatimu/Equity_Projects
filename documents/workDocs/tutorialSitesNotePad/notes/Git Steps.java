
Git Steps

$ git init

$ git remote add origin https://kengatimu@bitbucket.org/javaessentials/payments_filereadingandprocessing.git

$ git status

$ git add .

$ git status

$ git commit -m 'initial commit' or git commit -am 'Commit Message' //for adding and commting all change.

$ git status

$ git push origin master

$ git checkout -b dev

$ git pull origin master

$ git push origin dev

$ git status

$ git checkout -b feature

$ git pull origin master

$ git push origin feature

$ git status


git checkout remote:
git fetch && git checkout develop


Other commands
$ git log //for checking the number of commits, who did, time etc

$ git reset --hard <commit> //where <commit> is the commit hash you want to go back to. You can get it from git log 
$ git reset --hard origin/master

