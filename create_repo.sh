#!/bin/bash

name=repo

path=$name.git

rm -rf "./$name"
rm -rf "./$path"

mkdir $path
cd $path
git init --bare
cd ..
git clone $path
cd "./$name"

function add_hist {
    echo $1 >> "history.txt"
}

function do_rel {
    add_hist $1
    git commit -am "commit-$1"
    git push
    git tag $1
    git push --tags origin
}


#
# init
#
add_hist "init"
git add "history.txt"
git commit -am "init"
git push

#
# release-1
#
do_rel release-1

add_hist "immediate commit r1->r2"

#
# release-2
#
echo "r2r2r2r2r2" > "file_r2.bin"
git add "file_r2.bin"
do_rel release-2

#
# release-3
#
echo "r3r3r3r3r3" > "file_r3.bin"
git add "file_r3.bin"
do_rel release-3

add_hist "immediate commit r3->r4"

#
# Hold current state
#
git bundle create ../r1-r2-r3.bundle --all 
path_cp=../copied-repo.git
rm -rf $path_cp
mkdir $path_cp
cp -r ../$path/* $path_cp

#
# release-4
#
echo "r4r4r4r4r4" > "file_r4.bin"
git add "file_r4.bin"
do_rel release-4

add_hist "immediate commit r4->r5 (a)"
add_hist "immediate commit r4->r5 (b)"

#
# release-5
#
git bundle create ../r4.bundle release-3..release-4
git rm "file_r2.bin"
do_rel release-5

git bundle create ../r5.bundle release-4..release-5
git bundle create ../all.bundle --all