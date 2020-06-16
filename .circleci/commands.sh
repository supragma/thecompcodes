cd comp.code
git stash
git pull origin $1
git checkout $1
sudo docker build . -t comp_code
sudo terraform init
sudo terraform apply --auto-approve
