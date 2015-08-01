FROM hhfrancois/ocelot-demo:base

# Set the WILDFLY_VERSION env variable
ENV TOMEE_VERSION 1.7.2
ENV TOMEE_HOME /usr/local/apache-tomee-$TOMEE_VERSION
ENV PATH $PATH:$TOMEE_HOME/bin


# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN curl -O http://www.apache.org/dyn/closer.cgi/tomee/tomee-$TOMEE_VERSION/apache-tomee-$TOMEE_VERSION-webprofile.tar.gz \
    && tar xf apache-tomee-$TOMEE_VERSION-webprofile.tar.gz -C /usr/local \
    && mv /tmp/ocelot-test.war $TOMEE_HOME/webapps \
    && rm apache-tomee-$TOMEE_VERSION-webprofile.tar.gz

# Expose the ports we're interested in
EXPOSE 8080

WORKDIR $TOMEE_HOME

CMD ['startup.sh']
