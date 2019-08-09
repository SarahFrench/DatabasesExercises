# Database exercises for Corndel Apprenticeship

## Docker container

I'm running MySQL server in a Docker container:

Pull an image of MySQL server via Docker:

`docker pull mysql/mysql-server`

Set up the image with a container name and root password* :

`docker run --name=mysql -e MYSQL_ROOT_PASSWORD=password -d mysql/mysql-server:latest`

Copy the schema for the database and all employment tables into the container:

`docker cp ./corndel-database-schema.sql mysql:/tmp`

Use a bash command line within the container:

`docker exec -it mysql bash`

Once you're in the container, load the schema you copied in into MySQL:

`mysql -u root -p < /tmp/corndel-database-schema.sql`

And go into MySQL's command line interface:

`mysql -u root -p`

And from here you start querying, e.g. :

`use employment_db;`

`show tables;`

`select * from employees;`
