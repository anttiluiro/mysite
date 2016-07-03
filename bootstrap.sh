
# download the package lists from the repositories
apt-get update

# --- python ---

# set default python version to 3.4
ln -sf /usr/bin/python3.4 /usr/bin/python

# install pip (done later)
# apt-get install -y python3-pip

# Update and upgrade components, install new ones, restart postgresql
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install python3-pip python3-dev libpq-dev postgresql postgresql-contrib
service postgresql restart

# Run db-creation sql
# sudo su - postgres - psql < /vagrant/create_db.sql

APP_DB_USER=anttiladmin
APP_DB_PASS=tianp2e_MYSITE

cat << EOF | su - postgres -c psql
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
CREATE DATABASE mysite;

ALTER ROLE anttiladmin SET client_encoding TO 'utf8';
ALTER ROLE anttiladmin SET default_transaction_isolation TO 'read committed';
ALTER ROLE anttiladmin SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE mysite TO anttiladmin;
EOF

# --- Required python modules ---
pip3 install -r /vagrant/requirements.txt

# tasks
cd /vagrant && python manage.py makemigrations
cd /vagrant && python manage.py migrate

# Run server and static file watcher in screen
su - vagrant -c "cd /vagrant && screen -S server -d -m python manage.py runserver 0.0.0.0:8000"
su - vagrant -c "cd /vagrant && screen -S watcher -d -m python manage.py watchstatic"
