# keycloak

The script add-user adds users to a realm in Keycloak. Users are originally in a file. Each line is as follows:
username:password:name:first Name
So each user has 4 attributes : username and password which will allow him to connect to Keycloak and the realm's clients; and 2 more 
attributes: the user's name and first name.

The script is executed in this way: 
  bash add-user.sh -u Keycloak-URL -m admin-username -p admin-password -r realm -f filename
  where: 
  * Keycloak-URL is the main Keycloak URL. example: https://keycloak.example.com
  * admin-username is the admin's username of the realm master
  * admin-password is the admin's password
  * realm is the realm where we will add users
  * filename is the file that contains the users.
  
 P.S : the script deals with french characters. The directory where it we be executed must be writable by the user who executes the script.
 
 The script delete-user deletes users from a realm based on a file that contains a list of usernames. Each username occupies a line.
 To execute it, run : bash delete-user.sh -u Keycloak-URL -m admin-username -p admin-password -r realm -f filename
 
 The arguments are the same as the previous script. 
 
 !! Keep the order of the arguments.
