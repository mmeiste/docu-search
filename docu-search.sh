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
printf "${RED}RESULTS:${NC}\n"
grep -ril "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
grep --color=always -ri "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |grep -v "<[^>]*>" |less -R -F -X |tee $HOME/Documents/www.suse.com/docu-search-results

echo " "
printf "${RED}REPORT: The terms you searched were found on:${NC}\n"
less -F -X -n $HOME/Documents/www.suse.com/docu-search-urls
echo " "
printf "${RED}The search results were saved to $HOME/Documents/www.suse.com/docu-search-results${NC}\n"

