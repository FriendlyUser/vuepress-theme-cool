#!/bin/bash
PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

echo "Updating the version: $PACKAGE_VERSION"



# Implementation of incrementing version numbers
# https://stackoverflow.com/questions/8653126/how-to-increment-version-number-in-a-shell-script
increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
    len=${#part[CNTR]}
    new=$((part[CNTR]+carry))
    [ ${#new} -gt $len ] && carry=1 || carry=0
    [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo -e "${new// /.}"
} 

NEW_PACKAGE_VERSION=$(increment_version $PACKAGE_VERSION)
TAB=$'\t'
sed -i '' -e "s/.*version.*/${TAB}\"version\": \"$NEW_PACKAGE_VERSION\",/g" ./package.json
echo "publishing the new version $NEW_PACKAGE_VERSION"
npm publish