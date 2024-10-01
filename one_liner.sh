#!/bin/bash

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/exposed-panels

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/exposures

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/default-logins

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/vulnerabilities/wordpress

cat final_subdomain_live.txt | nuclei -t ~/nuclei-templates/http/vulnerabilities/
