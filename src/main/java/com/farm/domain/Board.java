package com.farm.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.Date;

@Entity(name="BOARD")
@Data
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Board {
    @Id
    @SequenceGenerator(
            name="myBoardSEQ",
            sequenceName="myBoardSEQ",
            allocationSize = 1
    )
    @GeneratedValue(generator="myBoardSEQ")
    private Long boardIdx;
    private String boardSubject;
    private String boardContent;

    @Column(insertable=false, columnDefinition="NUMBER DEFAULT 0")
    private Long boardCount;
    private Long boardWfIdx;
    @CreatedDate
    private Date boardDate;
    @LastModifiedDate
    private Date boardUpdateDate;
}
