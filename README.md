# Spring Cloud Eureka服务注册测试demo

测试使用的是SpringBoot项目。可以使用[Spring官方文档](https://start.spring.io/) 提供的页面直接下载。

## 1. 创建Eureka服务注册中心

### 1.1.maven配置

```xml

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>

<dependencies>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-dependencies</artifactId>
        <version>${spring-cloud.version}</version>
        <type>pom</type>
        <scope>import</scope>
    </dependency>
</dependencies>
```

### 1.2.配置文件

```
#服务端口
server.port=8080
#服务名称
spring.application.name=eureka-server
#服务地址
eureka.instance.hostname=localhost
#禁止自己当做服务注册
eureka.client.register-with-eureka=false
#屏蔽注册信息
eureka.client.fetch-registry=false
```

### 1.3.开启Eureka功能

使用`@EnableEurekaServer`注解
```Java
@SpringBootApplication
@EnableEurekaServer
public class EurekaServerApplication {
	public static void main(String[] args) {
		SpringApplication.run(EurekaServerApplication.class, args);
	}
}
```

### 1.4.启动服务
打开http://localhost:8080/，进入eureka管理页面，此时在`Instances currently registered with Eureka`一栏可以看到，还没有服务注册进来。


## 2.创建provider，注册登记到服务中心

### 2.1.maven配置

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### 2.2.配置文件

```
#服务端口
server.port=8090
#服务名称
spring.application.name=server-provider
#服务地址
eureka.instance.hostname=localhost
#注册中心路径，表示我们向这个注册中心注册服务，如果向多个注册中心注册，用“，”进行分隔
eureka.client.serviceUrl.defaultZone=http://localhost:8080/eureka
```

### 2.3.开启自动注册功能
`@EnableEurekaClient`注解，注意跟server不一样

```java
@SpringBootApplication
@EnableEurekaClient
public class ServerProviderApplication {
	public static void main(String[] args) {
		SpringApplication.run(ServerProviderApplication.class, args);
	}
}
```

2.4.写测试用例，对外提供服务的接口
```java
@RestController
public class UserController {

    @GetMapping("/user/{name}")
    public String getUser(@PathVariable String name) {
        return new User(name).getIdentity();
    }
    
}
```



## 3.创建consumer，调用provider的接口

### 3.1.maven配置
跟2.1配置一样

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### 3.2.配置文件
跟2.2.几乎一样，注意服务端口/名称可能不一致

```
#服务端口
server.port=8091
#服务名称
spring.application.name=server-consumer
#服务地址
eureka.instance.hostname=localhost
#注册中心路径，表示我们向这个注册中心注册服务，如果向多个注册中心注册，用“，”进行分隔
eureka.client.serviceUrl.defaultZone=http://localhost:8080/eureka
```

### 3.3.开启自动注册功能
`@EnableEurekaClient`注解
```java
@SpringBootApplication
@EnableEurekaClient
public class ServerProviderApplication {
	public static void main(String[] args) {
		SpringApplication.run(ServerProviderApplication.class, args);
	}
}
```


### 3.4.使用RestTemplate调用服务
```Java
@Configuration
public class RestConfig {

    @Bean
    @LoadBalanced //负载均衡
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

### 3.5.写测试用例

```java
@RestController
@Slf4j
public class TestController {
    
    # 注册在服务中心的服务名
    private String providerServerName = "server-provider";

    private final RestTemplate restTemplate;

    public TestController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/test")
    public String getUserIdentity() {
        val identity = restTemplate.getForEntity(String.format("http://%s/user/test", providerServerName), String.class).getBody();
        return identity;
    }

}
```

## 4.测试
启动三个服务，调用consumer的/test方法，查看范围结果。
