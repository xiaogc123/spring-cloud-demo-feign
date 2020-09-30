package com.erniu.springcloud.serverconsumer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.UUID;

/**
 * @author wangerniu
 * @date 2020/9/29 14:27
 */
@Data
@AllArgsConstructor
public class User {
    String name;
    String identity;

    public User(String name) {
        this.name = name;
        this.identity = UUID.randomUUID().toString();
    }
}
