source common.sh

print_head "configure the nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
echo $?

print_head "installing nodejs service"
yum install nodejs -y &>>${log_file}
echo $?

print_head "create roboshop user"
id roboshop &>>${log_file}
if [ $? -ne 0 ]; then
 useradd roboshop &>>${log_file}
fi
echo $?

print_head "creating the app directory"
if [ ! -d /app ]; then
 mkdir /app &>>${log_file}
fi
echo $?

print_head "delete old content"
rm -rf /app/* &>>${log_file}
echo $?

print_head "downloading the app content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log_file}
cd /app
echo $?

print_head "extracting the downloaded content"
unzip /tmp/user.zip &>>${log_file}
echo $?

print_head "installing nodejs dependencies"
npm install &>>${log_file}
echo $?

print_head "copying the systemd service file"
cp ${code_dir}/configs/user.service /etc/systemd/system/user.service &>>${log_file}
echo $?

print_head "reload systemd"
systemctl daemon-reload &>>${log_file}
echo $?

print_head "enabling user service"
systemctl enable user &>>${log_file}
echo $?

print_head "starting the user service"
systemctl restart user &>>${log_file}
echo $?

print_head "copying the mongodb repo file"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
echo $?

print_head "install mongodb client"
yum install mongodb-org-shell -y &>>${log_file}
echo $?

print_head "load schema"
mongo --host mongodb.devopsb71.site </app/schema/user.js &>>${log_file}
echo $?
