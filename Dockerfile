FROM hhfrancois/ocelot-demo:base

MAINTAINER Francois Achache <francois.achache@gmail.com>

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
