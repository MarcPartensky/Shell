master=$1 || "master"
branch=$(git branch --show-current)
echo "Master:" $master "and branch:" $branch
echo -e "\e[1mCheckout master\e[0m"
git checkout $master
echo -e "\e[1mPulling master\e[0m"
git pull
echo -e "\e[1mCheckout $branch\e[0m"
git checkout $branch
echo -e "\e[1mMerging with $master\e[0m"
git merge $master
echo -e "\e[1mPushing\e[0m"
git push
echo Refreshed with $master"
