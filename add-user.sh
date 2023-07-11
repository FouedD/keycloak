#!/bin/bash


keycloakU=$2
admin=$4
adminP=$6
realm=$8

authUrl="$keycloakU/auth/realms/master/protocol/openid-connect/token";
data="grant_type=password&username=$admin&password=$adminP";
token=$(curl -s -k -X 'POST' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Basic YWRtaW4tY2xpOg==' --data-binary "$data" "$authUrl" | jq -r '.access_token');

addUserUrl="$keycloakU/auth/admin/realms/$realm/users"
autHeader="Authorization: Bearer $token"

file=${10}
enc=$(file -i "$file" |cut -d "=" -f2)
iconv -f $enc -t UTF-8//TRANSLIT $file -o txtxtx.txt

sleep 1

input="txtxtx.txt"
i=1

while IFS= read -r line
do
	echo "Treating line $i"
	user=$(echo $line | cut -d ";" -f1 | tr -d " ")
	password=$(echo $line | cut -d ";" -f2 | tr -d " ")
	name=$(echo $line | cut -d ";" -f3 | tr -d " ")
	firstN=$(echo $line | cut -d ";" -f4 | tr -d " ")
	body=$( jq -nc --arg username "$user" --arg first "$firstN" --arg lastN "$name" --arg passwd "$password" '{"username": $username, "firstName": $first, "lastName": $lastN, "enabled": "true", "credentials": [{"type": "password", "temporary": "false", "value": $passwd}]}' )
	req=$(curl -i -s -k -X 'POST' -H 'Content-Type: application/json' -H "$autHeader"  -d "$body" "$addUserUrl")
	i=$((i + 1))
	sleep 1
done < "$input"
rm txtxtx.txt
