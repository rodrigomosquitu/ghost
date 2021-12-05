#!/bin/bash -x

# Send the output to the console logs and at /var/log/user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

    # Update package lists
    sudo apt-get update -y

    # Update installed packages
    sudo apt-get upgrade -y

    # Install NGINX
    sudo apt-get install nginx -y
    sudo ufw allow 'Nginx Full'

    # Add the NodeSource APT repository for Node 14
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash
    
    # Install Node.js
    sudo apt-get install -y nodejs
    npm install npm@latest -g
    
    sudo npm install ghost-cli@latest -g
    
    # Create directory: Change `sitename` to whatever you like
    sudo mkdir -p /var/www/blog
    
    # Set directory owner: Replace <user> with the name of your user
    sudo chown ubuntu:ubuntu /var/www/blog
    
    # Set the correct permissions
    sudo chmod 775 /var/www/blog
    
    # Then navigate into it
    cd /var/www/blog

    # Install Ghost, cannot be run via root (user data default)
    sudo -u ubuntu ghost install \
        --url "${url}" \
        --db "mysql" \
        --dbhost "${endpoint}" \
        --dbuser "${username}" \
        --dbpass "${password}" \
        --dbname "${database}" \
        --process systemd \
        --no-prompt \
        --no-setup-ssl
    
    # Wait until Nginx file exists 
    until [ -f /etc/nginx/sites-available/www.rodmosq.link.conf ]
    do
         sleep 5
    done

    # Tells nginx to pass (header when proxying request) name of the upstream server instead of Load balancer
    sudo cat <<-EOF > /etc/nginx/sites-available/www.rodmosq.link.conf
   server {
   listen 80;
   listen [::]:80;

   server_name www.rodmosq.link;
   root /var/www/blog/system/nginx-root;

   location / {
   proxy_set_header X-Real-IP \$remote_addr;
   proxy_set_header Host \$http_host;
   proxy_pass http://127.0.0.1:2368;
   proxy_set_header X-NginX-Proxy true;
   proxy_redirect off;
   }

   location ~ /.well-known {
   allow all;
   }

   client_max_body_size 50m;
}
EOF

    # remove default nginx site
    sudo rm /etc/nginx/sites-enabled/default
    
    #sudo service nginx restart
    sudo nginx -s reload