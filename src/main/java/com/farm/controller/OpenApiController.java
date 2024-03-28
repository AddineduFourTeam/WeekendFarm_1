package com.farm.controller;

import com.farm.service.OpenApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
@Controller
public class OpenApiController {
    @Autowired
    private final OpenApiService openApiService;

    public OpenApiController(OpenApiService openApiService) {
        this.openApiService = openApiService;
    }

    @GetMapping("/FarmApi")
    public ResponseEntity<?> getHolidayController() throws IOException { // 공유일 가져오기
        return ResponseEntity.ok(openApiService.getFarmService());
    }
}
