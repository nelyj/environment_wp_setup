@db_name = "patojimenez_dev"
@replace_host = @db_name.gsub '_dev', '.dev'


exec("google-chrome --new-window http://#{@replace_host}")