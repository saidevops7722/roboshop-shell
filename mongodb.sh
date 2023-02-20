source common.sh

print-head "copying the mongodb repo files"
cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print-head "installing mongodb"
yum install mongodb-org -y &>>${log_file}

print-head "enabling mongodb"
systemctl enable mongod &>>${log_file}

print-head "starting mongodb service"
systemctl start mongod &>>${log_file}

#update the /etc/mongod.conf from 127.0.0.1 with 0.0.0.0


