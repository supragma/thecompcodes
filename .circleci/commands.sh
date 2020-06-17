cd comp.code
git stash
git pull origin $1
git checkout $1

cp .env.template .env
cp terraform.tfvars.template terraform.tfvars
if [[ $1 == "master" ]]
then
	sed -i '/^RAILS_ENV/s/=.*/="production"/' terraform.tfvars
elif [[ $1 == "stage" ]]
then
	sed -i '/^RAILS_ENV/s/=.*/="stage"/' terraform.tfvars
else
	sed -i '/^RAILS_ENV/s/=.*/="development"/' terraform.tfvars
fi

SECRET_KEY_BASE=$(gcloud secrets versions access "latest" --secret="DEPLOY_SECRET")
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


sed -i "s/{user}/$(whoami)/" terraform.tfvars
sed -i '/^SECRET_KEY_BASE/s/=.*/="'$SECRET_KEY_BASE'"/' terraform.tfvars
sed -i '/^POSTGRES_HOST/s/=.*/="'$DB_HOST'"/' terraform.tfvars
sed -i '/^POSTGRES_DB/s/=.*/="'$DB_NAME'"/' terraform.tfvars
sed -i '/^POSTGRES_USER/s/=.*/="'$DB_USERNAME'"/' terraform.tfvars
sed -i '/^POSTGRES_PASSWORD/s/=.*/="'$DB_PASSWORD'"/' terraform.tfvars

sudo docker build . -t comp_code
sudo terraform init
sudo terraform apply --auto-approve

rm .env
rm terraform.tfvars
