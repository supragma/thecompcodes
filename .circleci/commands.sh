cd comp.code
git stash
git pull origin $1
git checkout $1

cp terraform.tfvars.template terraform.tfvars
if [[ $1 == "master" ]]
then
	sed -i '/^RAILS_ENV/s/=.*/="production"/' terraform.tfvars
else
	sed -i '/^RAILS_ENV/s/=.*/="development"/' terraform.tfvars
fi

SECRET_KEY_BASE=$(gcloud secrets versions access "latest" --secret="DEPLOY_SECRET")
DB_HOST=$(gcloud secrets versions access "latest" --secret="DB_HOST")
DB_NAME=$(gcloud secrets versions access "latest" --secret="DB_NAME")
DB_USERNAME=$(gcloud secrets versions access "latest" --secret="DB_USERNAME")
DB_PASSWORD=$(gcloud secrets versions access "latest" --secret="DB_PASSWORD")
SENDGRID_API_KEY=$(gcloud secrets versions access "latest" --secret="SENDGRID_API_KEY")


sed -i "s/{user}/$(whoami)/" terraform.tfvars
sed -i '/^SECRET_KEY_BASE/s/=.*/="'$SECRET_KEY_BASE'"/' terraform.tfvars
sed -i '/^POSTGRES_HOST/s/=.*/="'$DB_HOST'"/' terraform.tfvars
sed -i '/^POSTGRES_DB/s/=.*/="'$DB_NAME'"/' terraform.tfvars
sed -i '/^POSTGRES_USER/s/=.*/="'$DB_USERNAME'"/' terraform.tfvars
sed -i '/^POSTGRES_PASSWORD/s/=.*/="'$DB_PASSWORD'"/' terraform.tfvars
sed -i '/^SENDGRID_API_KEY/s/=.*/="'$SENDGRID_API_KEY'"/' terraform.tfvars


sudo docker build . -t comp_code
sudo terraform init
sudo terraform apply --auto-approve

rm terraform.tfvars
