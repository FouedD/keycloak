#!/bin/bash

keycloakU=$2
admin=$4
adminP=$6
realm=$8

authUrl="$keycloakU/auth/realms/master/protocol/openid-connect/token";
data="grant_type=password&username=$admin&password=$adminP";
token=$(curl -s -k -X 'POST' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Basic YWRtaW4tY2xpOg==' --data-binary "$data" "$authUrl" | jq -r '.access_token');

listUsersUrl="$keycloakU/auth/admin/realms/$realm/users"
autHeader="Authorization: Bearer $token"

file=${10}

i=0

while IFS= read -r line
do
	i=$((i + 1))
	echo -e "\n"
        echo "Treating line $i"
        username=$(echo $line | tr -d " ")
	[ -z "$username" ] && echo "ligne vide" && continue

	userID=$(curl -s -k -X 'GET' -H "$autHeader" "$listUsersUrl?username=$username" | jq -r '.[].id')
	[ -z "$userID" ] && echo "User $username Not found" && sleep 1 && continue

	delURL="${listUsersUrl}/${userID}"
	echo "Deleting user : $username  -- id : $userID"
	req=$(curl -i -s -k -X 'DELETE' -H "$autHeader"  "$delURL")
        sleep 1
done < "$file"
