#! /bin/bash

echo "masters = gentoo" > /var/lib/layman/testing/metadata/layout.conf && echo "cache-formats = md5-dict" >> /var/lib/layman/testing/metadata/layout.conf || exit -2;
touch /var/lib/layman/testing/profiles/repo_name && echo "testing" > /var/lib/layman/testing/profiles/repo_name || exit -3;
repoman manifest && emerge --regen 
emerge --metadata
repoman --digest=y -d full 
egencache --jobs=2 --update --repo testing
