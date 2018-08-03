#!/bin/bash 
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
echo " "
printf "${RED}What is the product you want to search? Possible values are listed bellow.:${NC}\n"
printf "${RED}NOTE: You can also use "*" character as a wildcard (example: "sles*" will perform a search on all sles products)${NC}\n"
echo " "
ls $HOME/Documents/www.suse.com/documentation
echo " "
echo "Product:" ; read product

echo " "
printf "${RED}What are you searching for?${NC}\n"
echo "Search:" ; read search

echo " "
echo "RESULTS:"
grep -ril "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
grep --color=always -ri "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |grep -v "<[^>]*>" |less -R -F -X

echo " "
echo "REPORT: The terms you searched were found on:"
less -F -X -n $HOME/Documents/www.suse.com/docu-search-urls
