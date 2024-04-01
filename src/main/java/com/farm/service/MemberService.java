package com.farm.service;

import com.farm.domain.Member;
import com.farm.domain.Reservation;
import com.farm.domain.Review;
import com.farm.domain.Story;
import com.farm.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    StoryRepository storyRepository;

    @Autowired
    ReservationRepository reservationRepository;

    @Autowired
    ReviewRepository reviewRepository;

    @Autowired
    FarmRepository farmRepository;


    /*프로필추가설정*/
    @Value("${upload.directory}")
    private String uploadDirectory;

    public void memInsert(Member member, MultipartFile file) throws Exception{
        memberRepository.save(member);
    }

    public Member login(String id) {
            Optional<Member> loginUser = memberRepository.findByMemid(id);

            if(loginUser.isPresent()){
                return loginUser.get();
            }else{
                return null;
            }
    }

    public boolean idCheck(String memid) {
        return memberRepository.existsByMemid(memid);

    }

    public Optional<Member> getMemberById(String memid) {
        Optional<Member> opMember = memberRepository.findByMemid(memid);
        return opMember;
    }

    public void updatePass(String memid, String pass) {
        Optional<Member> opMember = memberRepository.findByMemid(memid);
        opMember.ifPresent(member -> {
            member.setPass(pass);
            memberRepository.save(member);
        });
    }

    public void cancelAccount(String memid) {
        Optional<Member> opMember = memberRepository.findByMemid(memid);
        opMember.ifPresent(
                member->{
                    member.setIsOut("Y");
                    member.setOutdate(LocalDateTime.now());
                    member.setMemImg(null);
                    memberRepository.save(member);
                }
        );
    }

    public Member updateMyInfo(Member iMyInfo, String memid) {
        Optional<Member> opMember = memberRepository.findByMemid(memid);
        Member updatedMember = null;
        if(opMember.isPresent()){
            Member member = opMember.get();
            member.setName(iMyInfo.getName());
            member.setBirth(iMyInfo.getBirth());
            member.setPhone(iMyInfo.getPhone());
            member.setEmail(iMyInfo.getEmail());
            member.setMemImg(iMyInfo.getMemImg());

            updatedMember = memberRepository.save(member);
        }
        return updatedMember;
    }

    public Member getLoginUser(String memid) {
        return memberRepository.findByMemid(memid).orElse(null);
    }

    public Member findByMemid(String memid) {
        return memberRepository.findByMemid(memid).orElse(null);
    }

    public void getMypgList(Model model, Long memIdx) {
        model.addAttribute("stories",storyRepository.findTop3ByStoryMemIdxOrderByStoryDateDesc(memIdx));
        model.addAttribute("reservations",reservationRepository.findTop5ByRvMemIdxOrderByRvDateDesc(memIdx));
        model.addAttribute("reviews",reviewRepository.findTop5ByReviewMemIdxOrderByReviewDateDesc(memIdx));

        model.addAttribute("wfSubjectlist",reservationRepository.findWfSubjectByMemIdx(memIdx));
        model.addAttribute("reviewWfSubjectlist",reviewRepository.findWfSubjectByMemIdx(memIdx));

    }

    public void reviewWrite(Long rno,Long id,Model model) {
        Long wrfidx = reservationRepository.findById(rno).orElseGet(null).getRvFarmIdx();
        model.addAttribute("reviewReservation",reservationRepository.findById(rno).orElseGet(null));
        model.addAttribute("reviewFarm",farmRepository.findById(wrfidx).orElseGet(null));
        if(id > 0) {
            model.addAttribute("review",reviewRepository.findById(id).orElseGet(null));
        }
    }

    public Review reviewForm(Review review,Long rno) {
        review.setReviewWfIdx(reservationRepository.findById(rno).orElseGet(null).getRvFarmIdx());
        return reviewRepository.save(review);
    }

    public Review reviewUpdate(Review review, Long id) {
        Review orginalreview = reviewRepository.findById(id).orElseGet(null);
        if(review.getReviewImg1() != null && !review.getReviewImg1().isEmpty()) {
            orginalreview.setReviewImg1(review.getReviewImg1());
        }
        if(review.getReviewImg2() != null && !review.getReviewImg2().isEmpty()) {
            orginalreview.setReviewImg2(review.getReviewImg2());
        }
        if(review.getReviewImg3() != null && !review.getReviewImg3().isEmpty()) {
            orginalreview.setReviewImg3(review.getReviewImg3());
        }
        /*orginalreview.setReviewImg1(review.getReviewImg1());
        orginalreview.setReviewImg2(review.getReviewImg2());
        orginalreview.setReviewImg3(review.getReviewImg3());*/
        orginalreview.setReviewContent(review.getReviewContent().replaceAll("\r\n","<br>"));
        orginalreview.setReviewCount(review.getReviewCount());
        /*orginalreview.setReviewContent(review.getReviewContent());*/
        orginalreview.setReviewSubject(review.getReviewSubject());
        return reviewRepository.save(orginalreview);
    }

    public void reviewDelete(Long id) {
        reviewRepository.deleteById(id);
    }

    public Boolean hasReview(Long id) {
        System.out.println("reviewRepository.findByReviewRvIdx(id) = " + reviewRepository.findByReviewRvIdx(id));
        return reviewRepository.findByReviewRvIdx(id).isPresent();
    }

    public Member findById(Long id) {
        return memberRepository.findById(id).orElseGet(null);
    }
}
