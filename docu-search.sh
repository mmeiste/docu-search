#!/bin/bash 
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
echo " "
printf "${RED}What is the product you want to search? Possible values are listed bellow.:${NC}\n"
printf "${RED}NOTE: You can also use "*" character as a wildcard (example: "sles*" will perform a search on all sles products)${NC}\n"
echo " "
echo $(ls $HOME/Documents/www.suse.com/documentation)
read product

echo " "
printf "${RED}What are you searching for?${NC}\n"
read search

grep -ril "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ > /tmp/docu-search-urls
grep --color=always -ri "$search" $HOME/Documents/www.suse.com/documentation/$product/singlehtml/ |grep -v "<[^>]*>" |less -R -F -X
