#!/bin/bash 
# declare variables and set parameters
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
DATE=$(date +"%d-%m-%Y-%H-%M-%S")

CASE=
WIZARD=
FILENAME=

while [ "$1" != "" ]; do
    case $1 in
        -p | --product )           shift
                                PRODUCT=$1
                                ;;
        -s | --search )           shift
                                SEARCH=$1
                                ;;
        -w | --wizard )    WIZARD=1
                                ;;
        -i | --case-insensitive )    CASE=-i
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

## WIZARD START ##
# get product and search variables
if [ "$WIZARD" = "1" ]; then
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
# save url list
    grep -rc $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v \:0 |sed -e 's/html\:/html \:/ g' > $HOME/Documents/www.suse.com/docu-search-urls-match 
    grep -rl $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
    URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)
# perform search and pipe it to less
    grep --color=always -r $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |sed -e 's/html\:/html \:/g' |sed -e 's/<[^>]*>//g' |sed "s|$HOME\/Documents\/||g" |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
# show report
    echo " "
    printf "${RED}REPORT:${NC}\n"
    echo "The term '"$SEARCH"' was found on $URLNUMBER file(s):"
    cat $HOME/Documents/www.suse.com/docu-search-urls-match
    echo " "
    echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"
fi
## WIZARD END ##

## FLAG START ##
# save url listh
if [ "$WIZARD" = "" ]; then
    grep -rc $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v \:0 |sed -e 's/html\:/html \: /g' > $HOME/Documents/www.suse.com/docu-search-urls-match
    grep -rl $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
    URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)
# perform search and pipe it to less
    grep --color=always -r $CASE --include \*.html "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |sed -e 's/html\:/html \:/g' |sed -e 's/<[^>]*>//g' |sed "s|$HOME\/Documents\/||g" |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
# show report
    echo " "
    printf "${RED}REPORT:${NC}\n"
    echo "The term '"$SEARCH"' was found on $URLNUMBER file(s):"
    cat $HOME/Documents/www.suse.com/docu-search-urls-match
    echo " "
    echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"
fi
## FLAG END ##
