cp configs/mongodb.repo /etc/yum.repos.d/mongod.repo
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod
systemctl restart mongod
#update the /etc/mongod.conf from 127.0.0.1 to 0.0.0.0