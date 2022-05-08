FROM jboss/wildfly

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

#RUN /opt/jboss/wildfly/bin/add-user.sh -g admin -p admin -u admin
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

ENTRYPOINT ["/docker-entrypoint.sh"]