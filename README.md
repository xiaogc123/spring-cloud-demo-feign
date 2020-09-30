# Spring Cloud Feign 测试demo

测试使用的是之前测试Spring Cloud Eureka服务注册的demo项目。参考[Spring Cloud Eureka demo](https://www.jianshu.com/p/706ea9ff3e8b)

测试目标：consumer访问provider提供的服务使用spring cloud feign访问。

## 1. maven配置

```xml
<!-- Feign -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

## 2.开启Feign功能

使用`@EnableFeignClients`注解
```Java
@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients
public class ServerConsumerApplication {
	public static void main(String[] args) {
		SpringApplication.run(ServerConsumerApplication.class, args);
	}
}
```

## 3.封装Feign客户端
```Java
/**
 * @author wangerniu
 * @date 2020/9/30 14:17
 */
@FeignClient(name = "server-provider")
public interface FeignDemoClient {
    
    @RequestMapping(value = "/user/test", method = RequestMethod.GET)
    String getIdentity();
    
}
```

### 4.测试用例

```Java
/**
 * @author wangerniu
 * @date 2020/9/29 14:57
 */
@RestController
@Slf4j
public class TestController {

    private final FeignDemoClient feignDemoClient;

    public TestController(FeignDemoClient feignDemoClient) {
        this.feignDemoClient = feignDemoClient;
    }

    @GetMapping("/test")
    public String getUserIdentity() {
        return feignDemoClient.getIdentity();
    }

}

```
### 5.测试
启动所有服务，访问`http://127.0.0.1:8091/test` ，成功返回结果，测试成功

完整代码参考：https://github.com/Grrui/spring-cloud-demo-feign