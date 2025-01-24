#!/bin/sh
while /bin/true
do
  aws sts get-caller-identity
  export AWS_REGION="$(TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -sH "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')"
  export PGPASSWORD="$(aws rds generate-db-auth-token --hostname ${RDS_HOST} --port ${RDS_PORT} --region ${AWS_REGION} --username ${RDS_USER})" && \
    echo "\"${RDS_USER}\" \"${PGPASSWORD}\" " > /tmp/userlist.txt
  cat /etc/pgbouncer/userlist.txt >> /tmp/userlist.txt
  touch /tmp/initial_setup_complete
  sleep 300
done &
# Let's wait until the previous script finishes
while /bin/true
do 
  if [[ -e /tmp/initial_setup_complete ]] 
  then 
    break
  else 
    sleep 1
  fi
done
/usr/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini
