source common.sh
 roboshop_app_password=$1

 if [ -z "${roboshop_app_password}" ];then
   echo -e "\e[31m missing rabbitmq app user password argument\e[0m"
   exit 1
   fi

print_head " setup erlang repos "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head " setup rabbitmq repos "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head " install rabbitmq server "
yum install rabbitmq-server -y &>>${log_file}
status_check $?

print_head " enable rabbitmq service "
systemctl enable rabbitmq-server &>>${log_file}
status_check $?

print_head " start rabbitmq service "
systemctl restart rabbitmq-server &>>${log_file}
status_check $?

print_head " add application user "
rabbimqctl list_users | grep roboshop &>>${log_file}
if [ $? -ne 0 ]; then
 rabbitmqctl add_user roboshop ${roboshop_app_password} &>>${log_file}
fi
status_check $?

print_head " configure permissions for app user "
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status_check $?
