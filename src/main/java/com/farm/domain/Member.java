package com.farm.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity(name="MEMBER")
@EntityListeners(AuditingEntityListener.class)
public class Member {

    @Id
    @GeneratedValue(generator = "myBoardSEQ")
    @Column(name = "MEM_IDX")
    private Long memIdx; // 유저 회원번호(PK)

    private String memid; // 아이디

    private String pass; // 비밀번호

    private String name; // 이름
    
    private String birth; // 생년월일 6자
   
    private String phone; // 전화번호

    private String email; // 이메일
    
    private String memImg; // 프로필 이미지

    @CreatedDate
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime regdate; // 회원 가입 시간

    private LocalDateTime outdate; // 회원 탈퇴 시간

    @Column(columnDefinition="varchar2(10) DEFAULT 'N'")
    private String isOut ="N"; // 회원 탈퇴 여부 - 기본값 N

}
