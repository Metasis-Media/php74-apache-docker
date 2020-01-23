FROM php:7.4-apache

COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf

