# docker-partkeepr
A docker to run partkeepr 

## install

You need docker-compose to install docker-partkeepr.

You will also need to install some bash features:

```
git clone https://github.com/turdusmerula/bash-getopt.git
cd bash-getopt
sudo make install
```

Then run:

```
./compose build
./compose run
```

## setup

Once the docker is running you'll have to setup partkeepr, open on your browser ```http://http://localhost:8080/setup```.

Follow the steps, you'll be asked a authkey, it will be generated inside ```/opt/partkeepr/authkey.php```, just open the file and copy it.

## backup

You should be aware that your database will be destroyed if you destroy the containers so do not forget to backup it.

Docker-partkeepr comes with a mechanism to help you in this task, just do:

```
./compose backup /path/to/my/backup
```

## restore

If you restart from a fres setup your can restore your database, just do

```
./compose restore /path/to/my/backup
```
