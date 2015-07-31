FROM hhfrancois/ocelot-demo:base

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
