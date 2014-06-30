#!/bin/sh
echo "create database if not exists $1; use $1;" | cat - /vagrant/data/localdb.sql > /vagrant/data/tmp && mv /vagrant/data/tmp /vagrant/data/tmp.sql
mysql -u$2 -p$3 < /vagrant/data/tmp.sql
