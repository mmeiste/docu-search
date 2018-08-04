#!/bin/bash 
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
DATE=$(date +"%d%m%Y%H%M%S")

echo " "
printf "${RED}What is the product you want to search? Possible values are listed bellow:${NC}\n"
printf "${RED}NOTE: You can also use "*" character as a wildcard (example: "sles*" will perform a search on all sles products). The search is case insensitive${NC}\n"
echo " "
ls $HOME/Documents/www.suse.com/documentation
echo " "
echo "Product:" ; read PRODUCT

echo " "
printf "${RED}What are you searching for?${NC}\n"
echo "Search:" ; read SEARCH

echo " "
printf "${RED}RESULTS:${NC}\n"
grep --color=always -ril --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)

grep --color=always -ric --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v ^0 > $HOME/Documents/www.suse.com/docu-search-urls-matches

grep --color=always -ri --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |sed -e 's/<[^>]*>//g' |sed "s|$HOME\/Documents\/||g" |sed 's/html\:/html \:/g' |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I

#grep --color=always -ri --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v "<[^>]*>" |tee $HOME/Documents/www.suse.com/docu-SEARCH-results |less -R -F -X -I 

echo " "
printf "${RED}REPORT:${NC}\n"
echo "The term '"$SEARCH"' was found on $ULRNUMBER file(s):"
cat $HOME/Documents/www.suse.com/docu-search-urls-matches
echo " "

echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"


