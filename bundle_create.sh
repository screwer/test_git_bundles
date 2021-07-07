#!/bin/bash

cd repo.git
git bundle create ../all.bundle master HEAD
git bundle create ../r1-r2-r3.bundle master release-1 release-2 release-3
cd ..
git clone --mirror r1-r2-r3.bundle $name
