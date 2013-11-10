require 'mysql2'

@db_name = "patojimenez_dev"
@db_host = "localhost"
@db_user = "root"
@db_password = "123456a"

@replace_database = 'database_name_here'
@replace_username = 'username_here'
@replace_password = 'password_here'
@replace_host = @db_name.gsub '_dev', '.dev'

client = Mysql2::Client.new(host: @db_host, username: @db_user, password: @db_password)
client.query("DROP DATABASE IF EXISTS #{@db_name}")
client.query("CREATE DATABASE #{@db_name}")

client.close

Dir.chdir "/var/www/"
exec("wget http://wordpress.org/latest.zip && unzip latest.zip && mv wordpress #{@replace_host} && rm latest.zip && cd #{@replace_host} && mv wp-config-sample.php wp-config.php && sed -i 's/#{@replace_database}/#{@db_name}/g' wp-config.php && sed -i 's/#{@replace_username}/#{@db_user}/g' wp-config.php && sed -i 's/#{@replace_password}/#{@db_password}/g' wp-config.php")
