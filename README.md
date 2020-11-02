# Docker HuMo-Gen

### Summary

This code base is used to build a Docker image with HuMo Genealogy and MySQL

---

### Docker Variables

| Variable | Description |
|----------|-------------|
|DBHOST    | The Address of the MySQL Database Host   |
|DBNAME    | The name of the HuMo-Gen Database to be used  |
|DBUSERNAME   | MySQL Username for the DBNAME  |
|DBPASS   | The Password for the DBNAME  |

---

### Volumes:

| Folder     |  Path |
|-----------|------------------|
| HuMo-Gen  | /var/www/html/   |
| MySQL     | /var/lib/mysql/  |

---

### Docker Examples

One time run

`docker run --net=bridge --name=humogen -p 80:80 -p 443:443 -e DBHOST="localhost" -e DBUSERNAME="myuser" -e DBPASS="mypw" -e DBNAME="humo_gen" humo-gen:5.6`

Create Container

`docker create --net=bridge --name=humogen -p 80:80 -p 443:443 -e DBHOST="localhost" -e DBUSERNAME="myuser" -e DBPASS="mypw" -e DBNAME="humo_gen" -v /path/to/humogen/mysql:/var/lib/mysql -v /path/to/humogen/apache:/var/www/html humo-gen:5.6`

`docker start humogen`
