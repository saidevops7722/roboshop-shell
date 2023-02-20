source common.sh

print_head "copying the mongodb repo files"
cp ${code_dir} configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "installing mongodb"
yum install mongodb-org -y &>>${log_file}

print_head "enabling mongodb"
systemctl enable mongod &>>${log_file}

print_head "starting mongodb service"
systemctl start mongod &>>${log_file}

#update the /etc/mongod.conf from 127.0.0.1 with 0.0.0.0


