#! /bin/bash

echo "testing" > profiles/repo_name
repoman manifest
emerge --regen
emerge --metadata
repoman --digest=y -d full
egencache --jobs=2 --update --repo local
