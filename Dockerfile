FROM hhfrancois/ocelot-demo:base

MAINTAINER Francois Achache <francois.achache@gmail.com>

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PATH $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin
ENV DEMO_VERSION 2.0.0-SNAPSHOT

RUN apt-get update && apt-get install -y curl unzip zip inotify-tools && rm -rf /var/lib/apt/lists/* \
  && curl -L -o /tmp/glassfish-4.1.zip http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip \
  && unzip /tmp/glassfish-4.1.zip -d /usr/local \
  && rm -f /tmp/glassfish-4.1.zip \
  && asadmin start-domain domain1 \
  && asadmin deploy /tmp/ocelot-test.war \
  && asadmin stop-domain domain1
  
EXPOSE 8080 4848 8181

WORKDIR /usr/local/glassfish4

// verbose mode for foreground mode
CMD asadmin start-domain --verbose domain1
