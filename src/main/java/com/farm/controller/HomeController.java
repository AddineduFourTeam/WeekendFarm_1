package com.farm.controller;

import com.farm.domain.Member;
import com.farm.domain.Story;
import com.farm.service.BoardService;
import com.farm.service.MemberService;
import com.farm.service.StoryService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
@Slf4j
@Controller
@SessionAttributes({"loginUser"})
public class HomeController {
    @Autowired
    StoryService storyService;

    @Autowired
    PasswordEncoder pEncoder;

    @RequestMapping("/")
    public String root(Model model) throws Exception {
        storyService.listAll(model);
        return "index";
    }

    @GetMapping("/image/{id}/{num}")
    public ResponseEntity<byte[]> getImage(@PathVariable Long id , @PathVariable int num) {
        // 데이터베이스에서 이미지 BLOB 데이터를 찾는 로직
        byte[] imageData = storyService.getImg(id, num); // BLOB 데이터를 byte[]로 변환
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); // 적절한 Content-Type 설정
        //System.out.println(new ResponseEntity<>(imageData, headers, HttpStatus.OK));
        //log.warn("img========================");
        return new ResponseEntity<>(imageData, headers, HttpStatus.OK);
    }

}
