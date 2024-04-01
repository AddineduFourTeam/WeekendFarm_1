package com.farm.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Reservation {
    @Id
    @SequenceGenerator(
            name="myBoardSEQ",
            sequenceName="myBoardSEQ",
            allocationSize = 1
    )
    @GeneratedValue(generator="myBoardSEQ" , strategy = GenerationType.AUTO)
    private Long rvIdx; // 컨텐츠 번호
    private Long rvMemIdx; // 사용자 고유 식별자
    private Long rvFarmIdx; // 농장 고유 식별자
    private Integer rvUseDate  = 0; // 예약 기간
    private String rvUseYearDate; // 예약 기간(년)
    private char status = 'N'; // 예약 상태(확정 y, 취소 n)
    private Integer rvPrice = 0; // 예약 가격
    private Integer rvFeet = 0; // 평 수
    private char rvOptionSeeding = 'N'; // 모종 제공
    private char rvOptionPlow = 'N'; // 밭갈기
    private char rvOptionWatering = 'N'; // 물주기
    private char rvOptionCompost = 'N'; // 퇴비뿌리기

    @CreatedDate
    private String rvDate; // 예약 날짜

}