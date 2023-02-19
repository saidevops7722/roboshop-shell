code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "/e[35m$1/e[0m"
  }

print_head "installing nginx"
yum install nginx -y &>>${log_file}

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}

print_head "downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

print_head "extracting the downloaded content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}

print_head "copying the nginx conf for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

print_head "enabling the nginx"
systemctl enable nginx &>>${log_file}

print_head "restarting the nginx"
systemctl restart nginx &>>${log_file}

## roboshop configs are not copied yet
##  if any command failed we need to stop the script there itself