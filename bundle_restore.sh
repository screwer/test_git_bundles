#!/bin/bash

name="restored-repo.git"

rm -rf "./$name"
#git clone --mirror r1-r2-r3.bundle $name
git clone -b master r1-r2-r3.bundle $name --bare
#git update-ref HEAD master

cd $name
git log
echo "-----------------------------------------------"
#git bundle list-heads ../r4.bundle
#echo "+++++++++++++++++++++++++++++++++++++++++++++++"
git bundle verify ../r4.bundle
echo "-----------------------------------------------"

git fetch ../r4.bundle 'refs/tags/*:refs/tags/*'
git fetch ../r5.bundle 'refs/tags/*:refs/tags/*'
git update-ref HEAD release-5

cd ../copied-repo.git
git fetch ../r4.bundle 'refs/tags/*:refs/tags/*'
git fetch ../r5.bundle 'refs/tags/*:refs/tags/*'
git update-ref HEAD release-5


#git bundle unbundle ../r4.bundle
#git pull ../r4.bundle
#git merge
#git update-ref "release-4" "d13255eb5b3f03c932b791c46b13d3d3ff6f99b0"

#git fetch ../r4.bundle +refs/heads/*:refs/heads/* --prune
#git fetch ../r4.bundle +refs/heads/*:refs/heads/*

#git remote set-url origin /home/da/work/git_test/
#mv /home/da/work/git_test/r4.bundle /home/da/work/git_test/r1-r2-r3.bundle
#git pull
#git fetch
#git push origin



#cd ..
#rm -rf "./restored-repo"
#git clone "./$name"
#cd "./restored-repo"
#git pull ../r4.bundle release-4

#git update-ref "release-4" "af9a1f55b6c9e921672e242bc336f897af6b62aa"
#git fetch ../r4.bundle --prune


