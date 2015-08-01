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

ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PATH $PATH:$GLASSFISH_HOME/bin

RUN apt-get update && apt-get install -y curl unzip zip inotify-tools && rm -rf /var/lib/apt/lists/* \
  && curl -L -o /tmp/glassfish-4.1.zip http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip \
  && unzip /tmp/glassfish-4.1.zip -d /usr/local \
  && rm -f /tmp/glassfish-4.1.zip \
  && mv /tmp/ocelot-test.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy 

EXPOSE 8080 4848 8181

WORKDIR $GLASSFISH_HOME

# verbose mode for foreground mode
CMD asadmin start-domain --verbose domain1
