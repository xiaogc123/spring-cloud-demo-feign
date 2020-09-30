package com.erniu.springcloud.serverprovider.controller;

import com.erniu.springcloud.serverprovider.domain.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wangerniu
 * @date 2020/9/29 14:26
 */
@RestController
public class UserController {

    @GetMapping("/user/{name}")
    public String getUser(@PathVariable String name) {
        return new User(name).getIdentity();
    }

}
