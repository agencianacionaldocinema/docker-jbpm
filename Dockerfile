FROM jboss/wildfly:10.1.0.Final

ENV KIE_VERSION 7.3.0.Final
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV JAVA_OPTS -Xms256m -Xmx512m -Djava.net.preferIPv4Stack=true

RUN  curl -o $HOME/jbpm-console.war $KIE_REPOSITORY/org/kie/kie-wb/$KIE_VERSION/kie-wb-$KIE_VERSION-wildfly10.war \
  && unzip -q $HOME/jbpm-console.war -d $JBOSS_HOME/standalone/deployments/jbpm-console.war \
  && touch $JBOSS_HOME/standalone/deployments/jbpm-console.war.dodeploy \ 
  && rm -rf $HOME/jbpm-console.war


USER root
RUN  chown jboss:jboss $JBOSS_HOME/standalone/deployments/* 

USER jboss
EXPOSE 8001

WORKDIR /opt/jboss
CMD ["/opt/jboss/wildfly/bin/standalone.sh","-b","0.0.0.0","-bmanagement","0.0.0.0"]

