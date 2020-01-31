---
layout: post
title:  "Create WebDav Server with Spring-Boot and Milton"
tags: [ Tips ]
featured_image_thumbnail:
featured_image: assets/images/posts/2018/12.jpg
---
Web Distributed Authoring and Versioning (WebDAV) is an extension of the Hypertext Transfer Protocol (HTTP) that allows clients to perform remote Web content authoring operations. The WebDAV protocol provides a framework for users to create, change and move documents on a server. [(Wikipedia)](https://en.wikipedia.org/wiki/WebDAV)

[Milton](http://milton.io/) is one of the major implementation of WebDAV server in java with commercial(open source) and enterprise version. In this post I am going to integrate Milton with Spring-Boot to create sample WebDAV server.

First of all, create Maven project and add Milton and spring-boot-starter-web dependencies. Because of Milton dependency is not available in Maven global repository, We have to add Milton repository in pom file too.

```
<repositories>
    <repository>
        <id>milton-repo</id>
        <url>http://dl.bintray.com/milton/Milton</url>
    </repository>
</repositories>
<dependencies>
    <dependency>
        <groupId>io.milton</groupId>
        <artifactId>milton-server-ce</artifactId>
        <version>2.7.2.4</version>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```

In Spring-Boot we can use classic XML or Annotation model to configure are Beans. In this project I used Annotation, so add SpringBeanConfig.java as below to configure Milton.

```java
@Configuration
public class SpringBeanConfig {
 
    @Bean
    public FilterRegistrationBean someFilterRegistration() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(getMiltonFilter());
        registration.setName("MiltonFilter");
        registration.addUrlPatterns("/*");
        registration.addInitParameter("resource.factory.class",
                "io.milton.http.annotated.AnnotationResourceFactory");
        registration.addInitParameter("controllerPackagesToScan",
                "com.hfakhraei.samples.springboot.milton.controllers");
        registration.addInitParameter("milton.configurator",
        registration.setOrder(1);
        return registration;
    }
 
    public Filter getMiltonFilter() {
        return new MiltonFilter();
    }
}
```

As you see in this code, Two parameters have to be configured in Milton.  First on is “resource.factory.class”, that set to “AnnotationResourceFactory”. This parameter tells Milton that we want to use Annotation configuration. Second one is “controllerPackagesToScan”, that define package that Milton have to search to find Controller classes.

Now project structure is ready and we have to add one Controller class to accept and process requests, so add “HelloWorldController.java” to the project.

```java
public class HelloWorldController {
    private static Logger logger = LoggerFactory.getLogger(HelloWorldController.class);
    private static HashMap&lt;String, WebDavFile> webDavFiles = new HashMap&lt;>();
 
    static {
        try {
            byte[] bytes  = "Hello World".getBytes("UTF-8");
            webDavFiles.put("file1.txt", new WebDavFile("file1.txt", bytes));
            webDavFiles.put("file2.txt", new WebDavFile("file2.txt", bytes));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
    }
 
    @Root
    public HelloWorldController getRoot() {
        return this;
    }
 
    @ChildrenOf
    public List&lt;WebDavFolder> getWebDavFolders(HelloWorldController root) {
        List&lt;WebDavFolder> webDavFolders = new ArrayList&lt;WebDavFolder>();
        webDavFolders.add(new WebDavFolder("folder1"));
        webDavFolders.add(new WebDavFolder("folder2"));
        return webDavFolders;
    }
 
    @ChildrenOf
    public Collection&lt;WebDavFile> getWebDavFiles(WebDavFolder webDavFolder) {
        return webDavFiles.values();
    }
 
    @Get
    public InputStream getChild(WebDavFile webDavFile) {
        return new ByteArrayInputStream(webDavFiles.get(webDavFile.getName()).getBytes());
    }
 
    @PutChild
    public void putChild(WebDavFile parent, String name, byte[] bytes) {
        if(name!=null) {
            webDavFiles.put(name, new WebDavFile(name, bytes));
        } else {
            parent.setBytes(bytes);
            webDavFiles.put(parent.getName(), parent);
        }
    }
 
    @Delete
    public void delete(WebDavFile webDavFile) {
        webDavFiles.remove(webDavFile.getName());
    }
 
    @Name
    public String getWebDavFile(WebDavFile webDavFile) {
        return webDavFile.getName();
    }
 
    @DisplayName
    public String getDisplayName(WebDavFile webDavFile) {
        return webDavFile.getName();
    }
 
    @UniqueId
    public String getUniqueId(WebDavFile webDavFile) {
        return webDavFile.getName();
    }
 
    @ModifiedDate
    public Date getModifiedDate(WebDavFile webDavFile) {
        return webDavFile.getModifiedDate();
    }
 
    @CreatedDate
    public Date getCreatedDate(WebDavFile webDavFile) {
        return webDavFile.getCreatedDate();
    }
 
}
```

In this class, with Milton Annotation, I defined some of main functionality of WebDav server, such as, Fetch list of file and folders, Fetch content of file, Change content of file.

To see the result of this project, In Windows Explorer type address below.

```
\\127.0.0.1@8084\DavWWWRoot
```

Complete source of this project available in [gitHub](https://github.com/HFakhraei/spring-boot-samples/tree/master/spring-boot-milton).