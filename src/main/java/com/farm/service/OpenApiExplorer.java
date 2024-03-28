package com.farm.service;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Service
public class OpenApiExplorer {

    public JSONObject getFarmExplorer(String cntntsNo) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.nongsaro.go.kr/service/fmlgEdcFarmm/fmlgEdcFarmmDtl"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("apiKey", "UTF-8") + "=20240117NMZCW3BXNJ6J5U6HMW37W"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("cntntsNo", "UTF-8") + "=" + URLEncoder.encode(cntntsNo, "UTF-8"));
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder xmlSb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            xmlSb.append(line);
        }
        rd.close();
        conn.disconnect();
        JSONObject jsonSb = XML.toJSONObject(xmlSb.toString());
        return jsonSb;
    }
}
