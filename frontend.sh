source common.sh

print_head "installing nginx"
yum install nginx -y &>>${log_file}
status_check $?

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

print_head "downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
status_check $?


print_head "extracting the downloaded content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

print_head "copying the nginx conf for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
status_check $?

print_head "enabling the nginx"
systemctl enable nginx &>>${log_file}
status_check $?

print_head "starting the nginx"
systemctl restart nginx &>>${log_file}
status_check $?

##  if any command failed we need to stop the script there itself