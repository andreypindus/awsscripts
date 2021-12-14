#! /bin/bash
adminpass=$1

export SPLUNK_USER=splunk
export SPLUNK_HOME=/opt/splunk

#Install splunk
wget "https://apindus-test.s3.eu-west-2.amazonaws.com/splunk-8.2.3-cd0848707637-linux-2.6-x86_64.rpm"
rpm -ivh splunk-8.2.3-cd0848707637-linux-2.6-x86_64.rpm
cat > $SPLUNK_HOME/etc/system/local/user-seed.conf <<EOF
[user_info]
USERNAME = admin
PASSWORD = $adminpass
EOF
useradd $SPLUNK_USER
groupadd $SPLUNK_USER
chown -R splunk:splunk $SPLUNK_HOME
sudo -u $SPLUNK_USER $SPLUNK_HOME/bin/splunk start --accept-license
sudo -u $SPLUNK_USER $SPLUNK_HOME/bin/splunk stop
$SPLUNK_HOME/bin/splunk enable boot-start -user $SPLUNK_USER
chown -R splunk:splunk $SPLUNK_HOME
sudo -u $SPLUNK_USER $SPLUNK_HOME/bin/splunk start
