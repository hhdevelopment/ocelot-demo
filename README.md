#Ocelot.DS  
OcelotDS : Ocelot DataServices is a framework for simplify communication between java and javascript.  

##ocelot-demo

These are docker images for testing ocelotds framework

[Site](http://hhdevelopment.github.io/ocelot/)   
[Github](https://github.com/hhdevelopment/ocelot)

Glassfish 4.1 : [hhfrancois/ocelot-demo:glassfish](https://github.com/hhdevelopment/ocelot-demo/blob/glassfish/Dockerfile)    
Wildfly 9 : [hhfrancois/ocelot-demo:wildfly](https://github.com/hhdevelopment/ocelot-demo/blob/wildfly/Dockerfile)    
Tomcat 8 : [hhfrancois/ocelot-demo:tomcat](https://github.com/hhdevelopment/ocelot-demo/blob/tomcat/Dockerfile)    

```
docker run -d -p 82:8080 hhfrancois/ocelot-demo:$VERSION
```

You can test with different containers
Download it and launch it or test directly on my containers

### In glassfish 4.1 :
[Demo](http://demo.ocelotds.org/ocelot-test/)

### In wildfly 9 :
[Demo](http://demo.ocelotds.org:81/ocelot-test/)

### In tomcat  8 :
[Demo](http://demo.ocelotds.org:82/ocelot-test/)







