# Hugo Deploy

Is a chef recipe to deploy github rack applications into the cloud.

This is target specifically at the Ubuntu 9.10 AMI ami-1515f67c

## Required Attributes


* hugo:app:name
* hugo:app:branch (optional)
* hugo:app:restart_command (optional)
* hugo:app:migrate (optional)
* hugo:app:migration_command (optional)
* hugo:app:ssl (optional)


database.yml

* database:url
* database:name
* database:user
* database:password

github

* github:url
