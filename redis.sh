source common.sh


print_heaad " installing redis repo files "
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
status_check $?

print_heaad " enable 6.2 redis repo file"
dnf module enable redis:remi-6.2 -y &>>${log_file}
status_check $?

print_heaad " installing redis "
yum install redis -y &>>${log_file}
status_check $?

print_head " update redis listen address "
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/redis.conf /etc/redis/redis.conf &>>${log_file}
status_check $?

print_heaad " enabling redis service "
systemctl enable redis &>>${log_file}
status_check $?

print_heaad " starting the redis service"
systemctl restart redis &>>${log_file}
status_check $?