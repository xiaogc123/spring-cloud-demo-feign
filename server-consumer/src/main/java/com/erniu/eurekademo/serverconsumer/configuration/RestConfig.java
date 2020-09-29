package com.erniu.eurekademo.serverconsumer.configuration;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
 * @author wangerniu
 * @date 2020/9/29 15:06
 */
@Configuration
public class RestConfig {

    @Bean
    @LoadBalanced //负载均衡
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
