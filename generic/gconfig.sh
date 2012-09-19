confirm="n"
while [ $confirm != "y" ]; do
    read -p "Input git username: " username 
    read -p "Input git email: " email
    read -p "confirm (y/n)?" confirm
done

git config --global user.name "$username"
git config --global user.email "$email"
git config -l   
