package com.farm.controller;

import com.farm.domain.Farm;
import com.farm.domain.Member;
import com.farm.domain.Reservation;
import com.farm.domain.Review;
import com.farm.dto.MemberReviewDto;
import com.farm.service.CommonService;
import com.farm.service.ListService;
import com.farm.service.MemberService;
import com.farm.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class FarmController {
    private static final int PAGE_SIZE = 12;
    private static final int PAGE_PER_BLOCK = 5;

    @Autowired
    ListService listService;
    @Autowired
    MemberService memberService;
    @Autowired
    ReservationService reservationService;
    @Autowired
    CommonService commonService;
    private Pageable createPageable(int page){
        return PageRequest.of(page -1, PAGE_SIZE, Sort.by("wfIdx").descending());
    }

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model,@RequestParam(value = "local", defaultValue = "전체") String local) {
        // 페이지 관련 처리
        Pageable pageable = createPageable(page);
        Page<Farm> result = listService.localList(local,model,pageable);
        //Page<Farm> result = listService.findAll(pageable);
        model.addAllAttributes(listService.getPagingData(result, page,PAGE_PER_BLOCK));
        return "list";
    }

    @GetMapping("/listDetail")
    public String listDetail(@RequestParam(value = "id") Long id, Model model){
        model.addAttribute("listDetail", listService.detail(id));
        List<Review> reviewList = commonService.reviewList(id);
        List<MemberReviewDto> memberReviewDtoList = new ArrayList<>();
        for(Review review : reviewList){
            Member member = memberService.findById(review.getReviewMemIdx());
            MemberReviewDto memberReviewDto = new MemberReviewDto(member, review);
            memberReviewDtoList.add(memberReviewDto);
        }
        model.addAttribute("listReview", memberReviewDtoList);
        return "listDetail";
    }

    @GetMapping("/search")
    public String search(@RequestParam(value ="keyword") String keyword, @RequestParam("select") String select, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        // 페이지 관련 처리
        Pageable pageable = createPageable(page);
        Page<Farm> result = listService.search(pageable, keyword, select);
        model.addAllAttributes(listService.getPagingData(result, page,PAGE_PER_BLOCK));
        return "list";
    }
    @GetMapping("/reservation")
    public String reservation(@RequestParam(value = "id") Long id, Model model){
        model.addAttribute("farm", listService.detail(id));
        return "reservation";
    }
    @PostMapping("/reservationSave")
    public String reservationSave(Reservation reservation){
        listService.save(reservation);
        return "list";
    }

    @PostMapping("/reservationUpdate")
    public String reservationUpdate(Reservation reservation , @RequestParam("rvIdx") Long rvIdx){
        reservationService.updateReservation(reservation , rvIdx);
        return "mypageReservation";
    }
    @PostMapping("/storyLocal")
    public ResponseEntity<?> storyLocal(@RequestParam(value="local") String local, Model model) {
        Pageable pageable = PageRequest.of(0, Integer.MAX_VALUE, Sort.by("wfIdx").descending());
        //List<Farm> localList = listService.localList(local);
        return ResponseEntity.ok(listService.localList(local,model,pageable).getContent());
    }
}