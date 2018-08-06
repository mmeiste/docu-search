#!/bin/bash
# declare variables and set parameters
RED='\033[0;31m' # Red color
NC='\033[0m' # No Color
DATE=$(date +"%d-%m-%Y-%H-%M-%S")
CASE=
WIZARD=yes

while [ "$1" != "" ]; do
    case $1 in
        -p | --product )        shift
                                WIZARD= ; PRODUCT=$1 ; FILE=html
                                shift
                                ;;
        -s | --search )         shift
                                WIZARD= ; SEARCH=$1 ; FILE=html
                                shift
                                ;;
        -w | --wizard )         shift
                                WIZARD=yes
                                ;;
        -i | --case-insensitive ) shift
                                WIZARD= ; CASE=-i ; FINDCASE=i
                                ;;
        -I | --image )          shift
                                WIZARD= ; FILE=png
                                ;;
        -l | --list )           shift
                                WIZARD= ; LIST=yes
                                ;;
        -h | --help )           shift
                                WIZARD= ; HELP=yes
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
done

## WIZARD START ##
# get product and search variables
if [ "$WIZARD" = "yes" ]; then
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
    grep -rc $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v \:0 |sed -e 's/html\:/html \:/ g' > $HOME/Documents/www.suse.com/docu-search-urls-match
    grep -rl $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
   # URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)
# perform search and pipe it to less
    grep --color=always -r $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v '<.*>\|^--.*' |sed "s|$HOME\/Documents\/||g" |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
# show report
    echo " "
    printf "${RED}REPORT:${NC}\n"
    echo "The term '"$SEARCH"' was found on $URLNUMBER file(s):"
    cat $HOME/Documents/www.suse.com/docu-search-urls-match
    echo " "
    echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"
fi
## WIZARD END ##

## HTML SEARCH START ##
# save url list
if [ "$WIZARD" = "" ] && [ "$FILE" = "html" ]; then
    grep -rc $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v \:0 |sed -e 's/html\:/html \: /g' > $HOME/Documents/www.suse.com/docu-search-urls-match
    grep -rl $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ > $HOME/Documents/www.suse.com/docu-search-urls
    URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)
    #TEXTCONVERT=$(cat $HOME/Documents/www.suse.com/docu-search-urls |xargs -L 1 w3m -dump "$1" 2> /dev/null >> $HOME/Documents/www.suse.com/docu-search-urls-text.txt)
# perform search and pipe it to less
    #grep --color=always $CASE "$SEARCH" $HOME/Documents/www.suse.com/docu-search-urls-text.txt |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
    grep --color=always -r $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v '<.*>\|^--.*' |sed "s|$HOME\/Documents\/||g" |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
# show report
    echo " "
    printf "${RED}REPORT:${NC}\n"
    echo "The term '"$SEARCH"' was found on $URLNUMBER file(s):"
    cat $HOME/Documents/www.suse.com/docu-search-urls-match
    echo " "
    echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"
fi
## HTML SEARCH END ##

## PNG SEARCH START ##
if [ "$WIZARD" = "" ] && [ "$FILE" = "png" ]; then
# save url list
    grep -rc $CASE --include \*.$FILE "$SEARCH" $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ |grep -v \:0 |sed -e 's/html\:/html \: /g' > $HOME/Documents/www.suse.com/docu-search-urls-match
    find $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ -type f -"$FINDCASE"name *"$SEARCH"*.png > $HOME/Documents/www.suse.com/docu-search-urls
    URLNUMBER=$(cat $HOME/Documents/www.suse.com/docu-search-urls |wc -l)
# perform search and pipe it to les
    find $HOME/Documents/www.suse.com/documentation/$PRODUCT/singlehtml/ -type f -"$FINDCASE"name *"$SEARCH"*.png |sed "s|$HOME\/Documents\/||g" |tee $HOME/Documents/www.suse.com/docu-search-results-$DATE |less -R -F -X -I
# show report
    echo " "
    printf "${RED}REPORT:${NC}\n"
    echo "The term '"$SEARCH"' was found on $URLNUMBER file(s):"
    cat $HOME/Documents/www.suse.com/docu-search-urls
    echo " "
    echo "The search results were saved to $(ls -t $HOME/Documents/www.suse.com/docu-search-results*| head -1)"
fi

## PNG SEARCH STOP ##

## HELP START ##
if [ "$HELP" = "yes" ]; then
    printf "Usage: docu-search -h or -l OR docu-search -p <product> -s <search string> (options: -i -I)"
    echo "-w, --wizard = Run docu-search in interactive mode. You will be prompted to select the product and search string"
    echo "-p, --product = Product that you want to search"
    echo "-s, --search = Search string. If you are searching for more then one word, put all into quotes ("")"
    echo "-i, --case-insensitive = Searches are case insensitive."
    echo "-I, --image = Search for png files only"
    echo "-l, --list = Display a list of products that you can select"
    echo "-h, --help = Display a list of options to chose from"
fi
## HELP STOP ##

## LIST START ##
if [ "$LIST" = "yes" ]; then
    printf "${RED}What is the product you want to search? Possible values are listed bellow:${NC}\n"
    printf "${RED}NOTE: You can also use "*" character as a wildcard (example: "sles*")${NC}\n"
    ls $HOME/Documents/www.suse.com/documentation
fi
## LIST STOP ##
