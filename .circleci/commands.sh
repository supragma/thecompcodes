cd comp.code
git stash
git pull origin $1
git checkout $1

cp .env.template .env
DB_HOST=$(gcloud secrets versions access "latest" --secret="DB_HOST")
DB_NAME=$(gcloud secrets versions access "latest" --secret="DB_NAME")
DB_USERNAME=$(gcloud secrets versions access "latest" --secret="DB_USERNAME")
DB_PASSWORD=$(gcloud secrets versions access "latest" --secret="DB_PASSWORD")
sed -i '/^DB_HOST/s/=.*/='$DB_HOST'/' .env
sed -i '/^DB_NAME/s/=.*/='$DB_NAME'/' .env
sed -i '/^DB_USERNAME/s/=.*/='$DB_USERNAME'/' .env
sed -i '/^DB_PASSWORD/s/=.*/='$DB_PASSWORD'/' .env

sed -i '/^POSTGRES_USER/s/=.*/='$DB_USERNAME'/' .env
sed -i '/^POSTGRES_PASSWORD/s/=.*/='$DB_PASSWORD'/' .env
sed -i '/^POSTGRES_DB/s/=.*/='$DB_NAME'/' .env



cp terraform.tfvars.template terraform.tfvars
sed -i "s/{user}/$(whoami)/" terraform.tfvars
sed -i '/^POSTGRES_DB/s/=.*/="'$DB_NAME'"/' terraform.tfvars
sed -i '/^POSTGRES_USER/s/=.*/="'$DB_USERNAME'"/' terraform.tfvars
sed -i '/^POSTGRES_PASSWORD/s/=.*/="'$DB_PASSWORD'"/' terraform.tfvars

sudo docker build . -t comp_code
sudo terraform init
sudo terraform apply --auto-approve

rm .env
rm terraform.tfvars
