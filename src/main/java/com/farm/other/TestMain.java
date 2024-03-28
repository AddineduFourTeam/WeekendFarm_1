package com.farm.other;
public class TestMain {

    public static void main(String[] args) {

        String xmlString = "<![CDATA[ 2020 ]]>";
        String extractedNumber = CDataExtractor.extractStringFromCData(xmlString);
        System.out.println("Extracted number:" + extractedNumber);
    }
}
