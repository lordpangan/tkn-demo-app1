package com.example.demoapp1;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

  @GetMapping("/")
  public String hello() {
    return "Hello from tkn-demo-app1!";
  }

  @GetMapping("/health")
  public String health() {
    return "OK";
  }
}
