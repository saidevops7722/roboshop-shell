source common.sh

print_head "configure the nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "installing nodejs service"
yum install nodejs -y &>>${log_file}

print_head "create roboshop user"
useradd roboshop &>>${log_file}

print_head "creating the app directory"
mkdir /app &>>${log_file}

print_head "delete old content"
rm -rf /app/* &>>${log_file}

print_head "downloading the app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app

print_head "extracting the downloaded content"
unzip /tmp/catalogue.zip &>>${log_file}

print_head "installing nodejs dependencies"
npm install &>>${log_file}

print_head "copying the systemd service file"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "reload systemd"
systemctl daemon-reload &>>${log_file}

print_head "enabling catalogue service"
systemctl enable catalogue &>>${log_file}

print_head "starting the catalogue service"
systemctl restart catalogue &>>${log_file}

print_head "copying the mongodb repo file"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head "install mongodb client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "load schema"
mongo --host mongodb.devopsb71.site </app/schema/catalogue.js &>>${log_file}




