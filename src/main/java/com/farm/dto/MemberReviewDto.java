package com.farm.dto;

import com.farm.domain.Farm;
import com.farm.domain.Member;
import com.farm.domain.Review;
import lombok.Data;

@Data
public class MemberReviewDto {
    private Member member;
    private Review review;

    public MemberReviewDto(Member member, Review review) {
        this.member = member;
        this.review = review;
    }

}
