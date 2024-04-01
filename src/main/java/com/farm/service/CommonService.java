package com.farm.service;

import com.farm.domain.*;
import com.farm.dto.MemInfoDto;
import com.farm.repository.*;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Slf4j
@Service
public class CommonService {

    @Autowired
    FarmRepository farmRepository;
    @Autowired
    BoardRepository boardRepository;
    @Autowired
    ReservationRepository reservationRepository;
    @Autowired
    StoryRepository storyRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    StoryReplyRepository storyReplyRepository;
    @Autowired
    ReviewRepository reviewRepository;


    public String uploadImage(MultipartFile file, Long memIdx) throws IOException {

        // 1. Null 또는 빈 파일 확인
        if (file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어 있습니다");
        }

        // 2. 파일 유형 확인 (이미지인지)
        if (!file.getContentType().startsWith("image/")) {
            throw new IllegalArgumentException("잘못된 파일 유형입니다. 이미지를 업로드하세요");
        }

        //프로필사진 추가
        String projectPath = System.getProperty("user.dir")
                + "\\src\\main\\resources\\static\\files";

        UUID uuid = UUID.randomUUID();

        // 3. 파일 이름 충돌 처리
        String fileName = uuid+"_"+file.getOriginalFilename();

        // 4. 파일을 저장할 디렉토리 생성
        File saveDirectory = new File(projectPath);
        if (!saveDirectory.exists()) {
            saveDirectory.mkdirs();
        }

        File saveFile = new File(projectPath, fileName);
        file.transferTo(saveFile);

        return "/files/"+fileName;

    }

    //list 뿌리기
    public void listAll(int page , Model model , Class<?> objClass) {
        Pageable pageable = getPageable(page,objClass);
        Page<?> result = null;

        if(objClass.equals(Farm.class)) {
            result = farmRepository.findAll(pageable);
        }
        if(objClass.equals(Board.class)) {
            result = boardRepository.findAll(pageable);
        }
        if(objClass.equals(Story.class)) {
            result = storyRepository.findAll(pageable);
        }

        listPage(model , result,objClass);

    }


    // 검색한 값 리스트 출력
    public void searchList(int page, String type, String search, Model model, Class<?> objClass) {
        //Sort sort = Sort.by(Sort.Order.desc("name"));
        Pageable pageable = getPageable(page,objClass);
        Page<?> result = null;

        /*int nPage = page - 1; // 시작페이지
        Pageable pageable = PageRequest.ofSize(10).withPage(nPage);
        Page<?> result = null;*/


        //농장 리스트 검색
        if(objClass.equals(Farm.class)) {
            if(type.equals("location")) {
                result = farmRepository.findByWfAddrContaining(search, pageable);
            }
            if(type.equals("title")) {
                result = farmRepository.findByWfSubjectContaining(search, pageable);
            }
        }
        //공지사항 리스트 검색
        if(objClass.equals(Board.class)) {
            if(type.equals("title")) {
                result = boardRepository.findByBoardSubjectContaining(search, pageable);
            }
            if(type.equals("content")) {
                result = boardRepository.findByBoardContentContaining(search, pageable);
            }
        }
        //내 스토리 리스트 검색
        if(objClass.equals(Story.class)) {
            if(type.equals("title")) {
                result = storyRepository.findByStorySubjectContaining(search, pageable);
            }
            if(type.equals("content")) {
                result = storyRepository.findByStoryContentContaining(search, pageable);
            }
            if(type.equals("user")) {
                //System.out.println("user");
                result = storyRepository.findByStoryMemNameContaining(search, pageable);
            }
        }


        listPage(model , result, objClass);
    }

    private Pageable getPageable(int page,Class<?> objClass) {
        int nPage = page - 1; // 시작페이지
        Sort sort = null;
        if(objClass.equals(StoryReply.class)) {
            sort = Sort.by(
                    Sort.Order.desc("srLike"),
                    Sort.Order.desc("srDate"),
                    Sort.Order.desc("srIdx")
            );
        }else if(objClass.equals(Story.class)) {
            sort = Sort.by( Sort.Order.desc("storyDate"));
        }else if(objClass.equals(Board.class)) {
            sort = Sort.by( Sort.Order.desc("boardDate"));
        }else if(objClass.equals(Review.class)) {
            sort = Sort.by( Sort.Order.desc("reviewDate"));
        }else if(objClass.equals(Reservation.class)) {
            sort = Sort.by( Sort.Order.desc("rvDate"));
        }
        if(objClass.equals(Reservation.class)){
            return PageRequest.ofSize(1000).withPage(nPage).withSort(sort);
        }else {
            return PageRequest.ofSize(10).withPage(nPage).withSort(sort);
        }

    }


    //model에 result값 담기
    private void listPage(Model model , Page<?> result, Class<?> objClass) {
        List<?> content = result.getContent();
        int totalPages = result.getTotalPages(); // 전제 페이지 수
        int pageNumber = result.getNumber() + 1; // 현재페이지 0부터 시작

        int pageBlock = 5; //블럭의 수 1, 2, 3, 4, 5
        int startBlockPage = ((pageNumber-1)/pageBlock)*pageBlock +1 ; //현재 페이지가 7이라면 1*5+1=6
        int endBlockPage = startBlockPage+pageBlock-1; //6+5-1=10. 6,7,8,9,10해서 10.
        endBlockPage = totalPages<endBlockPage? totalPages:endBlockPage;

        if(objClass.equals(StoryReply.class)) {
            List<MemInfoDto> arr = new ArrayList<>();

            model.addAttribute("Replylist", content);
            model.addAttribute("ReplySize", content.size());
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageNumber", pageNumber);
            model.addAttribute("startBlockPage", startBlockPage);
            model.addAttribute("endBlockPage", endBlockPage);
            for(int i = 0 ; i < content.size() ; i++) {
                StoryReply sr = (StoryReply) content.get(i);
                Member member = memberRepository.findById(sr.getSrMemIdx()).orElseGet(() -> null);
                MemInfoDto memInfoDto = new MemInfoDto(sr, member);
                arr.add(memInfoDto);
            }
            model.addAttribute("memInfoList", arr);

        }else {
            model.addAttribute("list", content);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageNumber", pageNumber);
            model.addAttribute("startBlockPage", startBlockPage);
            model.addAttribute("endBlockPage", endBlockPage);
        }

    }
    //댓글,후기 저장
    public Object replySave(Object object) {
        String className = object.getClass().getSimpleName();
        if (className.equals("StoryReply")) {
            StoryReply sr = (StoryReply)object;
            Member member = memberRepository.findById(sr.getSrMemIdx()).orElseGet(() -> null);
            MemInfoDto memInfoDto = new MemInfoDto(sr,member);
            memInfoDto.setStoryReply(storyReplyRepository.save(sr));

            //System.out.println(memInfoDto);
            return memInfoDto;
        }else {
            return null;
        }
    }

    //댓글,후기 리스트
    public void replyDetail(Long id,int page , Model model,Class<?> objClass) {
        Pageable pageable = getPageable(page,objClass);
        Page<?> result = null;
        if(objClass.equals(StoryReply.class)) {
           result = storyReplyRepository.findBySrStoryIdx(id, pageable);

            listPage(model , result,objClass);
        }

    }

    public int likeUp(Long id) {
        StoryReply sr = storyReplyRepository.findById(id).get();
        int likeNum = sr.getSrLike();
        likeNum++;
        sr.setSrLike(likeNum);
        storyReplyRepository.save(sr);
        return likeNum;
    }
    public int likeDown(Long id) {
        StoryReply sr = storyReplyRepository.findById(id).get();
        int likeNum = sr.getSrLike();
        likeNum--;
        sr.setSrLike(likeNum);
        storyReplyRepository.save(sr);
        return likeNum;
    }

    public String replyUpdate(Long id,String txt) {
        StoryReply sr = storyReplyRepository.findById(id).get();
        sr.setSrContent(txt);
        storyReplyRepository.save(sr);
        return sr.getSrContent();
    }

    public List<StoryReply> storyReplyList(Long id,Long srIdx, Model model) {
        return storyReplyRepository.findBySrStoryIdxAndSrDepthAndSrReplyIdx(id, 2, srIdx);
        //return srList;
    }

    public void replyDelete(Long id, Class<?> objClass , HttpSession session) {
        Long idx = ((Member)session.getAttribute("loginUser")).getMemIdx();
        if(objClass.equals(StoryReply.class)) {
            if(Objects.equals(idx, storyReplyRepository.findById(id).get().getSrMemIdx())) {
                storyReplyRepository.deleteById(id);
            }else {
                log.error("계정 오류");
            }
        }
        if(objClass.equals(Reservation.class)) {
            if(Objects.equals(idx, reservationRepository.findById(id).get().getRvMemIdx())) {
                reservationRepository.deleteById(id);
            }else {
                log.error("계정 오류");
            }
        }
        if(objClass.equals(Story.class)) {
            if(Objects.equals(idx, storyRepository.findById(id).get().getStoryMemIdx())) {
                storyRepository.deleteById(id);
            }else {
                log.error("계정 오류");
            }
        }
    }

    public void myList(Long idx,int page, Class<?> objClass, Model model) {
        Pageable pageable = getPageable(page,objClass);
        Page<?> result = null;

        if(objClass.equals(Story.class)) {
            result = storyRepository.findByStoryMemIdx(idx,pageable);
        }else if(objClass.equals(Reservation.class)) {
            result = reservationRepository.findByRvMemIdxOrderByRvDateDesc(idx,pageable);
        }else if(objClass.equals(Review.class)) {
            result = reviewRepository.findByReviewMemIdxOrderByReviewDateDesc(idx,pageable);
            model.addAttribute("reviewWfSubjectlist",reviewRepository.findWfSubjectByMemIdx(idx));
        }
        listPage(model , result, objClass);
    }

    public List<Review> reviewList(Long id) {
        return reviewRepository.findByReviewWfIdx(id);
    }
}

