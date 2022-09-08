#!/bin/bash
add_esuser() { cat <<EOF
{  "password" : "$EK_NEWUSER_PWD",  "enabled": true,  "roles" : [ "superuser", "kibana_admin" ],  "full_name" : "Full name",  "email" : "example@mail.com",  "metadata" : {    "intelligence" : 1  }}
EOF
}

status=$(curl -s -o /dev/null -w "%{http_code}" -X GET "elastic:9200/_cluster/health?pretty" -u $ES_USERNAME:$ES_PASSWORD)


date

while [[ status -ne 200 ]]
  do
    status=$(curl -s -o /dev/null -w "%{http_code}" -X GET "elastic:9200/_cluster/health?pretty" -u $ES_USERNAME:$ES_PASSWORD)
    echo status code received: $status
    echo "sleep 2..."
    sleep 2
  done
date
curl -XPOST "http://elastic:9200/_security/user/$EK_NEWUSER_NAME" -H "Content-Type: application/json" -d "$(add_esuser)" -u $ES_USERNAME:$ES_PASSWORD