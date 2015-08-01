FROM java:openjdk-8-jdk

MAINTAINER Francois Achache <francois.achache@gmail.com>

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
ENV MAVEN_VERSION 3.3.3


RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && curl --silent --location --retry 3 https://github.com/hhdevelopment/ocelot/archive/master.tar.gz | tar xz -C /tmp \
  && cd /tmp/ocelot-master && mvn install -Dgpg.skip=true -DskipTests=true \
  && curl --silent --location --retry 3 https://github.com/hhdevelopment/ocelot-demo/archive/master.tar.gz | tar xz -C /tmp \
  && cd /tmp/ocelot-demo-master && mvn package && cp /tmp/ocelot-demo-master/target/ocelot*.war /tmp/ocelot-test.war \
  && rm -rf /tmp/ocelot-master && rm -rf /tmp/ocelot-demo-master && rm -f /usr/bin/mvn && rm -rf /usr/share/maven && rm -rf ~/.m2

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 9.0.1.Final
ENV WILDFLY_HOME /usr/local/wildfly-$WILDFLY_VERSION
ENV PATH $PATH:$WILDFLY_HOME/bin


# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz -C /usr/local \
    && mv /tmp/ocelot-test.war $WILDFLY_HOME/standalone/deployments \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Expose the ports we're interested in
EXPOSE 8080

WORKDIR $WILDFLY_HOME

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["standalone.sh", "-b", "0.0.0.0"]
