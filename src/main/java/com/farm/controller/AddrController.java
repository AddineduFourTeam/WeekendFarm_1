package com.farm.controller;

import com.farm.domain.Farm;
import com.farm.service.KakaoApiExplorer;
import com.farm.repository.FarmRepository;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class AddrController {

    @Autowired
    private KakaoApiExplorer kakaoApiExplorer;
    @Autowired
    private FarmRepository farmRepository;

    @GetMapping("/coordinates")
    public ResponseEntity<?> getCoordinates(Farm farm , @RequestParam(value = "address") String address) throws IOException {
        // 좌표를 저장할 맵 생성
        Map<String, Object> coordinates = new HashMap<>();
        // 파라미터로 받은 주소를 사용하여 좌표 정보 조회
        JSONObject response = kakaoApiExplorer.getAddressInfo(address);
        System.out.println("response = " + response);
        if (response.has("documents")) {
            JSONObject document = response.getJSONArray("documents").getJSONObject(0);
            String x = document.getString("x"); // 경도
            String y = document.getString("y"); // 위도
            coordinates.put("x", x);
            coordinates.put("y", y);
            //System.out.println("sdfsdsfdf");
            farm.setLongitude(x);
            farm.setLatitude(y);
        }

        //System.out.println("x"+coordinates.get("x"));
            return ResponseEntity.ok(coordinates);
    }
}