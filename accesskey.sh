#!/bin/bash
echo "enter your github personal token access"
read token

cat ~/.ssh/id_rsa.pub

if [ $? eq 0 ]
then
echo "SSH keys are already present"
else
echo "SSH keys are not present..., Create the SSH keys using key-gen command"
ssh-keygen -t rsa
echo "SSH keys are succesfully generated"
fi

sshkey=`cat ~/.ssh/id_rsa.pub

if [ $? -eq 0 ]
then
echo "Copying key to the github account"
curl -X POST -H "content-type: application/json" -d "{\"title\": \"SSHKEY\",\"key\": \"$sshkey\"}" "https://api.github.com/user/key?/access_token=$token"
if [ $? -eq 0 ]
then 
echo "Successfully copied the token to github"
exit 0
else 
echo "Failed"
exit 1
fi
else
echo "Failure in generating the key"
exit 1
fi
