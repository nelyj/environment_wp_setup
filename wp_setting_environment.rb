@db_name = "patojimenez_dev"


@replace_host = @db_name.gsub '_dev', '.dev'
@dir = "/etc/apache2/sites-available/"
@url = @dir+@replace_host

File.open('/etc/hosts', 'a') { |f| 
  f.puts "127.0.0.1 #{@replace_host}" 
}

File.open( @url , 'w') { |f| 
  f.write("<VirtualHost *:80> \n")
  f.write("\tServerName #{@replace_host} \n")
  f.write("\tServerAlias #{@replace_host} \n\n")
  f.write("\tDocumentRoot /var/www/#{@replace_host} \n\n")
  f.write("\tServerSignature On \n")
  f.write("\tErrorLog /var/log/apache2/#{@replace_host}-error.log\n\n")
  f.write("\tLogLevel warn\n\n")
  f.write("\tCustomLog /var/log/apache2/#{@replace_host}-access.log combined\n\n")
  f.write("\t<Directory '/var/www/#{@replace_host}/'> \n")
  f.write("\tOptions Indexes FollowSymLinks MultiViews ExecCGI \n")
  f.write("\t\tAllowOverride All \n")
  f.write("\t\tOrder allow,deny \n")
  f.write("\t\tAllow from all \n")
  f.write("\t</Directory> \n")
  f.write("</VirtualHost>")
}

Dir.chdir "#{@dir}"

exec("a2ensite #{@replace_host} && invoke-rc.d apache2 restart")