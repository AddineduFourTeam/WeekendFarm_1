package com.farm.dto;

import com.farm.domain.Farm;
import com.farm.domain.Member;
import com.farm.domain.StoryReply;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class MemInfoDto {
     private StoryReply storyReply;
     //private Member member;
     private Long memIdx;
     private String memid;
     private String name;
     private String memImg;

     private String wfSubject;

     public MemInfoDto(StoryReply storyReply, Member member) {
          this.storyReply = storyReply;
          //this.member = member;
          this.memIdx = member.getMemIdx();
          this.memid = member.getMemid();
          this.name = member.getName();
          this.memImg = member.getMemImg();

          //this.wfSubject = farm.getWfSubject();
     }
}
