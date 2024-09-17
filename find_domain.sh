#!/bin/bash

read -p "Enter your domain list (separated by spaces): " -a domain_list

for domain in "${domain_list[@]}"; do
    echo "Processing $domain..."
    
    subfinder -d "$domain" --silent --all -o subfinder_list.txt
    
    echo "$domain" | assetfinder --subs-only > assetfinder_list.txt
    
    cat assetfinder_list.txt subfinder_list.txt | anew > final_subdomain.txt
    
    cat final_subdomain.txt | httpx --silent -mc 200 > final_subdomain_live.txt

    echo "Finished processing $domain!"
    echo "--------------------------------------------"
done
