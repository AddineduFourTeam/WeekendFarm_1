package com.farm.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Farm {
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    //@Column(name = "wf_idx")
    private int wfIdx; // 컨텐츠 번호
    private String wfSubject; // 제목
    private String wfAddr; // 소재지
    private String wfTheme; // 주제
    private int wfYear; // 지정연도
    private String wfUrl; // 홈페이지 주소
    private String wfTel; // 연락처
    private String wfCrtfcYearInfo; // 품질인증연도
    @Column(length = 10000)
    private String wfContent; // 내용
    private String wfImgUrl1; // 이미지 주소1
    private String wfImgUrl2; // 이미지 주소2
    private String wfImgUrl3; // 이미지 주소3
    @Column(columnDefinition = "NUMBER(10,0) DEFAULT 0")
    private Integer wfRating; // 별점
    @Column(columnDefinition = "NUMBER(10,0) DEFAULT 0 NOT NULL")
    private Integer wfPrice; // 가격
    @Column(columnDefinition = "NUMBER(10,0) DEFAULT 0")
    private Integer wfOptionPrice; // 옵션 가격

    @CreatedDate
    @Column(name = "created_date")
    private LocalDateTime createdDate;

    @Column(name = "longitude")
    private String longitude; // 경도

    @Column(name = "latitude")
    private String latitude; // 위도


}
