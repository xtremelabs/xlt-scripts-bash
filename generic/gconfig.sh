confirm="n"
while [ $confirm != "y" ]; do
    read -p "username: " username 
    read -p "email: " email
    read -p "confirm (y/n)?" confirm
done

git config --global user.name "$username"
git config --global user.email "$email"
git config -l   
