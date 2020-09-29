package com.erniu.eurekademo.serverconsumer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class ServerConsumerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServerConsumerApplication.class, args);
	}

}
