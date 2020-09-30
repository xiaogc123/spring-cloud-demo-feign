package com.erniu.springcloud.serverconsumer.controller;

import com.erniu.springcloud.serverconsumer.client.FeignDemoClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

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
