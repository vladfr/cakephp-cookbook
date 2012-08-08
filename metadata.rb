maintainer       "Jason Ardell"
maintainer_email "ardell@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures CakePHP"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
depends          "php"
depends          "apache2"
depends          "mysql"
depends          "openssl"

recipe "cakephp", "Installs and configures CakePHP LAMP stack on a single system"

%w{ debian ubuntu }.each do |os|
  supports os
end

attribute "cakephp/install_method",
  :display_name => "CakePHP install version"
  :description => "Values: url, source, package"
  :default => "url"

attribute "cakephp/install_url",
  :display_name => "CakePHP installation download URL",
  :description => "Location to get CakePHP from, when installing via URL, %s is a placeholder for version",
  :default => "http://github.com/cakephp/cakephp/tarball/"

attribute "cakephp/version",
  :display_name => "CakePHP version",
  :description => "Version of CakePHP to download from the CakePHP site.",
  :default => "2.2.1"

attribute "cakephp/dir",
  :display_name => "CakePHP installation directory",
  :description => "Location to place CakePHP files.",
  :default => "/var/www"

attribute "cakephp/config/debug",
  :display_name => "Debug value",
  :description => "Cake debugger. 0 for disabled, 1 for enabled, 2 for enabled with traces",
  :default => "0"

attribute "cakephp/config/salt",
  :display_name => "Salt value",
  :description => "A random string used in security hashing methods.",
  :default => "DYhG93b0qyJfIxfs2guVoUubWwvniR2G0FgaC9mi"

attribute "cakephp/config/seed",
  :display_name => "Seed value",
  :description => "A random numeric string (digits only) used to encrypt/decrypt strings.",
  :default => "76859309657453542496749683645"

attribute "cakephp/config/security_level",
  :display_name => "Security level",
  :description => "A random numeric string (digits only) used to encrypt/decrypt strings.",
  :default => "medium"

attribute "cakephp/db/host",
  :display_name => "CakePHP DB host",
  :description => "CakePHP will use this URL as a db host machine.",
  :default => "localhost"

attribute "cakephp/db/database",
  :display_name => "CakePHP DB database",
  :description => "CakePHP will use this database to store its data.",
  :default => "cakephpdb"

attribute "cakephp/db/user",
  :display_name => "CakePHP DB user",
  :description => "CakePHP will connect to the database using this user.",
  :default => "cakephpuser"

attribute "cakephp/db/password",
  :display_name => "CakePHP DB password",
  :description => "Password for the CakePHP database user.",
  :default => "randomly generated"
