# JSEnum
Find Secrets and leaks in JavaScript files

Bash Script to Enumerate JavaScript Files of a target and its Subdomains.

Finding Endpoints & Secrets in JS Files. Check [Features](https://github.com/utkarsh24122/JSEnum/blob/main/README.md#features)

Finding Potential DOM based XSS & Reflected XSS
```
        _______ _______   ____  ____  ___
       / / ___// ____/ | / / / / /  |/  /
  __  / /\__ \/ __/ /  |/ / / / / /|_/ / 
 / /_/ /___/ / /___/ /|  / /_/ / /  / /  
 \____//____/_____/_/ |_/\____/_/  /_/   
```

# Features
- Gathering JavaScript Files from the Target & its Subdomains
- Finding Endpoints Using Javascript Files
- Finding Sensitive Keywords & Secrets (such as API Keys)
- Checks For Potential DOM based XSS
- Scans Variables/parameters for Potential XSS

# Installation 
```
$ git clone https://github.com/utkarsh24122/JSEnum
$ cd JSEnum
$ chmod +x jsenum.sh
```
# Requirements
- [Required tools](https://github.com/utkarsh24122/JSEnum/blob/main/required_tools.md)
- PS: Working on script to install all tools at once!!

# Usage 
```
$ ./jsenum.sh list_of_domains.txt
$ ./jsenum.sh list_of_subdomains.txt
```
