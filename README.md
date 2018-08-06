# docu-search
ABOUT THE PROJECT:<br>
This is a local documentation search engine for SUSE support engineers based on official documentation releases (https://www.suse.com/documentation). <br><br>
The idea is to make a local offline copy of all available documentation and after use grep to search for what you are looking for. The advantage here is that you can search on multiple documentation pages for different products at the same time. Sure, google can also do that for you but the results are normally confusing and disorganized.<br><br>
The docu-update.sh script will take care of downloading the pages for you while docu-search.sh will prompt you with what is needed to perform the search you want. Note that the search is performed only through html files. PDFs and epub formats are not downloaded<br><br>

INSTALLATION AND USAGE:<br>
1 - Download the docu-update.sh and docu-search.sh scripts<br><br>
2 - Set execution permissions to both scripts: "sudo chmod a+x docu-update.sh ; sudo chmod a+x docu-search.sh"<br><br>
3 - Copy the scripts to /usr/bin with: "sudo cp docu-update.sh /usr/bin/docu-update ; sudo cp docu-search.sh /usr/bin/docu-search"<br><br>
4 - Run "docu-update" command first to download the html files from https://www.suse.com/documentation. By default, these files are saved in "$HOME/Documents/". You can change that also by editing the script before the first run. It might be a good idea to set a cronjob to also run the docu-update.sh automatically. The docu-update.sh is set to download new documentation htmls ONLY if a new version is in place on the website. PNG and CSS files are also saved in case you want to browse the documentation offline<br><br>
5 - After the download is done, run docu-search to start searching. The default parameters are described bellow:<br>
-w, --wizard = Run docu-search in interactive mode. You will be prompted to select the product and search string<br>
-p, --product = Product that you want to search"<br>
-s, --search = Search string. If you are searching for more then one word, put all into quotes ("")"<br>
-i, --case-insensitive = Searches are case insensitive."<br>
-I, --image = Search for png files only"<br>
-l, --list = Display a list of products that you can select"<br>
-h, --help = Display a list of options to chose from"<br><br>
6 - A list of html files will be displayed on the left side. Do Ctrl+Clink on the links to open them in your webrowser. Once you find what you need, open the page you downloaded with your browser (i suggest using w3m if you want to open that from the terminal. If you want to display images through w3m, dont forget to install "xv" and "w3m-inline-image" packages)<br>
7 - Do the needful ASAP<br>
