#!/bin/bash 
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
echo " "
printf "${RED}What is the product you want to search? Possible values are listed bellow:${NC}\n"
printf "${RED}NOTE: You can also use "*" character as a wildcard (example: "sles*" will perform a search on all sles products). The search is case insensitive${NC}\n"
echo " "
ls $HOME/Documents/www.suse.com/documentation
echo " "
echo "Product:" ; read product

echo " "
printf "${RED}What are you searching for?${NC}\n"
echo "Search:" ; read search

echo " "
printf "${RED}RESULTS:${NC}\n"
grep -ril --include \*.html "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
urlnumber=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)

grep -ric --include \*.html "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |grep -v 0 > $HOME/Documents/www.suse.com/docu-search-urls-matches
urlnumbermatches=$(grep -rio --include \*.html "$search" $HOME/Documents/www.suse.com/docu-search-urls-matches |wc -l)

grep --color=always -ri --include \*.html "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |sed -e 's/<[^>]*>//g'|tee $HOME/Documents/www.suse.com/docu-search-results |less -R -F -X 
#grep --color=always -ri --include \*.html "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |grep -v "<[^>]*>" |tee $HOME/Documents/www.suse.com/docu-search-results |less -R -F -X 

echo " "
printf "${RED}REPORT:${NC}\n"
echo "The term '"$search"' was found on $urlnumber file(s):"
cat $HOME/Documents/www.suse.com/docu-search-urls-matches
echo " "
echo "The search results were saved to $HOME/Documents/www.suse.com/docu-search-results"

