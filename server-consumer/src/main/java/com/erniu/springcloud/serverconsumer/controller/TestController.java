package com.erniu.springcloud.serverconsumer.controller;

import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

/**
 * @author wangerniu
 * @date 2020/9/29 14:57
 */
@RestController
@Slf4j
public class TestController {

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
