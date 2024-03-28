package com.farm.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.sql.Blob;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Story {
    @Id
    @GeneratedValue(generator="myBoardSEQ")
    private Long storyIdx;

    @Column(name="STORY_MEM_IDX")
    private Long storyMemIdx;
    private String storyMemName;
    private String storyMemImg;
    private String storyMemId;
    private Long storyWfIdx;
    private String storySubject;
    private String storyContent;
    private int storyCount;
    private int storyLikeCount;
    private String storyTag;
    @CreatedDate
    @Column(name = "STORY_DATE")
    private LocalDateTime storyDate;
    @LastModifiedDate
    @Column(name = "STORY_UPDATE_DATE")
    private LocalDateTime storyUpdateDate;
    @Lob
    private byte[] storyImg1;
    @Lob
    private byte[] storyImg2;
    @Lob
    private byte[] storyImg3;

    /*@ManyToOne
    @JoinColumn(name = "STORY_MEM_IDX", insertable = false, updatable = false)
    private Member member;*/
}
