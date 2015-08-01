#OCELOT.DS  
OcelotDS : Ocelot DataServices is a framework for simplify communication between java and javascript.  

##ocelot-demo

These are docker images for testing ocelotds framework

[Site](http://hhdevelopment.github.io/ocelot/)   
[Github](https://github.com/hhdevelopment/ocelot)

Glassfish : [hhfrancois/ocelot-demo:glassfish](https://github.com/hhdevelopment/ocelot-demo/blob/glassfish/Dockerfile)    
Wildfly : [hhfrancois/ocelot-demo:wildfly](https://github.com/hhdevelopment/ocelot-demo/blob/wildfly/Dockerfile)    
Tomee : [hhfrancois/ocelot-demo:tomcat](https://github.com/hhdevelopment/ocelot-demo/blob/tomcat/Dockerfile)    

```
docker run -d -p 82:8080 hhfrancois/ocelot-demo:$VERSION
```

You can test with different containers
Download it and launch it or test directly on my containers

## In glassfish 4.1 :
[Demo](http://demo.ocelotdes.org/ocelot-test/)

## In wildfly 9 :
[Demo](http://demo.hhdev.fr:81/ocelot-test/)

## In tomcat  8 :
[Demo](http://demo.hhdev.fr:82/ocelot-test/)







