# Configuration ; 
Path_to_Linkfinder="/home/morty/Tools/LinkFinder/linkfinder.py"
Path_to_Secretfinder="/home/morty/Tools/secretfinder/SecretFinder.py"
Path_to_Findomxss="findomxss.sh"
Path_to_JSVar="jsvar.sh"
echo "        _______ _______   ____  ____  ___"
echo "       / / ___// ____/ | / / / / /  |/  /"
echo "  __  / /\__ \/ __/ /  |/ / / / / /|_/ / "
echo " / /_/ /___/ / /___/ /|  / /_/ / /  / /  "
echo " \____//____/_____/_/ |_/\____/_/  /_/   "

echo ""
echo "--------------------------------------------------------------"
echo ""
echo "		Features:"
echo ""
echo "1.	Gathering JavaScript Files from the Target & its Subdomains"
echo "2.	Finding Endpoints Using Javascript Files"
echo "3.	Finding Sensitive Keywords & Secrets (such as API Keys)"
echo ""
echo "4.	Checks For Potential DOM based XSS"
echo ""
echo "5.	Scans Variables/parameters for Potential XSS"
echo ""
echo "--------------------------------------------------------------"
echo ""
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Fetching JavaScript Files for $1 \e[0m\n"
mkdir $1JSfiles.txt
cat $1 | cut -d '/' -f3 >> ./$1JSfiles.txt/work.txt
cd $1JSfiles.txt
cat work.txt | gau >> all_GAU_output.txt
cat all_GAU_output.txt | grep .js >> temp.txt
cat work.txt | httprobe -prefer-https >> probed.txt
gospider -S probed.txt -c 10 -d 1 -t 20 --other-source >> gospider_all.txt
cat gospider_all.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | grep .js >> temp.txt
mv temp.txt temp2.txt ; cat temp2.txt | sort -u >> temp.txt ; rm temp2.txt
subjs -i probed.txt -c 40 >> temp2.txt
cat all_GAU_output.txt | subjs >> temp2.txt
mv temp2.txt temp3.txt ; cat temp3.txt | sort -u >> temp2.txt ; rm temp3.txt;
cat temp2.txt >> temp.txt ; cat temp.txt | sort -u >> JSfiles.txt ; rm temp.txt temp2.txt
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m JS Files found using gau , Gospider & Subjs \e[0m\n"
cat JSfiles.txt | httprobe -prefer-https >> alive_JSfiles.txt
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Finding Endpoints \e[0m\n"
python3 $Path_to_Linkfinder -d -i alive_JSfiles.txt -o cli >> All_Endpoints.txt  -v 
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Finding Secrets \e[0m\n"
python3 $Path_to_Secretfinder -d -i alive_JSfiles.txt -o cli >> All_Secrets.txt 
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Testing for Potential DOM based xss \e[0m\n"
bash $Path_to_Findomxss alive_JSfiles.txt 
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Scanning for Variables/parameters for Potential XSS \e[0m\n"
cat alive_JSfiles.txt | while read url ; do bash $Path_to_JSVar $url | tee -a js_var.txt ; done


