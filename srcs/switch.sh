cp ~/../etc/nginx/sites-available/default ~/../etc/nginx/sites-available/tmp
cp ~/../etc/nginx/sites-available/option ~/../etc/nginx/sites-available/default
cp ~/../etc/nginx/sites-available/tmp ~/../etc/nginx/sites-available/option
rm -rf ~/../etc/nginx/sites-available/tmp 
service nginx restart