FROM phusion/baseimage:0.9.16

ADD testecho.sh /etc/service/testecho/run
RUN chmod +x /etc/service/testecho/run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
