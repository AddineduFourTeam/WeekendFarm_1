package com.farm.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class StoryReply {
    @Id
    @GeneratedValue(generator="myBoardSEQ")
    private Long srIdx;
    private Long srMemIdx;
    private Long srStoryIdx;
    private Long srReplyIdx;
    private String srContent;
    @CreatedDate
    @Column(name = "SR_DATE")
    private LocalDateTime srDate;
    @LastModifiedDate
    @Column(name = "SR_UPDATE_DATE")
    private LocalDateTime srUpdateDate;
    private int srDepth;
    private int srLike = 0;
}
