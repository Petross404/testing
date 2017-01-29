#! /bin/bash

echo "masters = gentoo" > ./metadata/layout.conf && echo "cache-formats = md5-dict" >> ./metadata/layout.conf || exit -2;
touch ./profiles/repo_name && echo "testing" > ./profiles/repo_name || exit -3;
repoman manifest && emerge --regen 
emerge --metadata
repoman --digest=y -d full 
egencache --jobs=2 --update --repo local
