package com.erniu.springcloud.serverconsumer.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author wangerniu
 * @date 2020/9/30 14:17
 */
@FeignClient(name = "server-provider")
public interface FeignDemoClient {

    @RequestMapping(value = "/user/test", method = RequestMethod.GET)
    String getIdentity();

}
