FROM java:openjdk-8-jdk

MAINTAINER Francois Achache <francois.achache@gmail.com>

ENV MAVEN_VERSION 3.3.3
# Version of demo inside
ENV DEMO_VERSION 2.0.0-SNAPSHOT

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && curl --silent --location --retry 3 https://github.com/hhdevelopment/ocelot-demo/archive/master.tar.gz | tar xz -C /tmp \
  && cd /tmp/ocelot-demo-master && mvn package && cp /tmp/ocelot-demo-master/target/ocelot*.war /tmp/ocelot-test.war \
  && rm -rf /tmp/ocelot-demo-master && rm -f /usr/bin/mvn && rm -rf /usr/share/maven

WORKDIR /tmp
