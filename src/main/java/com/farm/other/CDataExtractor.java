package com.farm.other;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CDataExtractor {
    public static void main(String[] args) {
        String xmlString = "<![CDATA[ 2020 ]]>";

        int extractedNumber = extractNumberFromCData(xmlString);

        System.out.println("Extracted number: " + extractedNumber);
    }

    public static int extractNumberFromCData(String cdata) {
        //System.out.println(cdata);
        if(cdata.isEmpty()) {
            return 0;
        }
        // 정규 표현식을 사용하여 숫자 추출
        Pattern pattern = Pattern.compile("\\s*<!\\[CDATA\\[(\\d+)\\]\\]>\\s*");
        Matcher matcher = pattern.matcher(cdata);

        // 매칭된 숫자가 있는 경우 추출
        if (matcher.matches()) {

        } else {
            // 매칭된 숫자가 없는 경우 예외처리 또는 기본값 설정
            throw new IllegalArgumentException("No number found in CDATA");
        }
        return Integer.parseInt(matcher.group(1));
    }

    public static String extractStringFromCData(String cdata) {
        //System.out.println(cdata);
        if(cdata.isEmpty()) {
            return "";
        }
        // 정규 표현식을 사용하여 숫자 추출
        Pattern pattern = Pattern.compile("\\s*<!\\[CDATA\\[(.*?)\\]\\]>\\s*");
        Matcher matcher = pattern.matcher(cdata);

        // 매칭된 문자열이 있는 경우 추출
        if (matcher.matches()) {

        } else {
            // 매칭된 문자열이 없는 경우 예외처리 또는 기본값 설정
            throw new IllegalArgumentException("No string found in CDATA");
        }
        System.out.println("matcher.group(1)"+matcher.group());
        return matcher.group(1).trim();
    }
}

