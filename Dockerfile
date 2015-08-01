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


ENV TOMCAT_VERSION 8
ENV TOMCAT_RELEASE 8.0.24
ENV TOMCAT_HOME /usr/local/apache-tomcat-$TOMCAT_RELEASE
ENV PATH $PATH:$TOMCAT_HOME/bin


# Add the Tomcat distribution to /usr/local
RUN curl -O http://www.webhostingjams.com/mirror/apache/tomcat/tomcat-$TOMCAT_VERSION/v$TOMCAT_RELEASE/bin/apache-tomcat-$TOMCAT_RELEASE.tar.gz \
    && tar xf apache-tomcat-$TOMCAT_RELEASE.tar.gz -C /usr/local \
    && mv /tmp/ocelot-test.war $TOMCAT_HOME/webapps \
    && rm apache-tomcat-$TOMCAT_RELEASE.tar.gz

# Expose the ports we're interested in
EXPOSE 8080

WORKDIR $TOMCAT_HOME

CMD ["catalina.sh", "run"]
