
# download the package lists from the repositories
apt-get update

# --- python ---

# set default python version to 3.4
ln -sf /usr/bin/python3.4 /usr/bin/python

# install pip
apt-get install -y python3-pip

# --- Required python modules ---
pip3 install -r /vagrant/requirements.txt
# tasks
cd /vagrant && python manage.py syncdb --noinput
cd /vagrant && python manage.py migrate

# Run server and static file watcher in screen
su - vagrant -c "cd /vagrant && screen -S server -d -m python manage.py runserver 0.0.0.0:8000"
su - vagrant -c "cd /vagrant && screen -S watcher -d -m python manage.py watchstatic"