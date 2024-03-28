package com.farm.service;

import com.farm.domain.Board;
import com.farm.domain.Farm;
import com.farm.domain.Reservation;
import com.farm.domain.Story;
import com.farm.repository.BoardRepository;
import com.farm.repository.FarmRepository;
import com.farm.repository.ReservationRepository;
import com.farm.repository.StoryRepository;
import jakarta.persistence.Id;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.ObjectInputStream;
import java.nio.ByteBuffer;
import java.util.*;

import java.net.ContentHandler;
import java.util.List;

@Service
@Slf4j
public class ListService {


    @Autowired
    FarmRepository farmRepository;
    @Autowired
    ReservationRepository reservationRepository;

    public Page<Farm> findAll(Pageable pageable) {
        return farmRepository.findAll(pageable);
    }

    public Page<Farm> search(Pageable pageable, String keyword, String select) {
        if (select.equals("location")) {
            return farmRepository.findByWfAddrContaining(keyword, pageable);
        } else if (select.equals("title")) {
            return farmRepository.findByWfSubjectContaining(keyword, pageable);
        } else if (select.equals("theme")) {
            return farmRepository.findByWfThemeContaining(keyword, pageable);
        } else {
            return null;
        }
    }

    public Map<String, Object> getPagingData(Page<Farm> page, int currentPage, int pagePerBlock) {
        Map<String, Object> pagingData = new HashMap<>();

        // 페이지네이션 관련 변수 계산
        int totalPages = page.getTotalPages(); // 전체 페이지 수
        int pageNumber = page.getNumber() + 1; // 현재 페이지 번호

        // 페이지네이션 시작 및 끝 페이지 계산
        int startPage = ((currentPage - 1) / pagePerBlock) * pagePerBlock + 1;
        int endPage = Math.min(startPage + pagePerBlock - 1, totalPages);

        // 뷰에 데이터 전달
        pagingData.put("nowPage", currentPage - 1);
        pagingData.put("totalPages", totalPages);
        pagingData.put("pageNumber", pageNumber);
        pagingData.put("startPage", startPage);
        pagingData.put("endPage", endPage);
        pagingData.put("farms", page.getContent());
        return pagingData;
    }

    public Object detail(Long id) {
        System.out.println(farmRepository.findById(id).get());
        return farmRepository.findById(id).get();
    }

    public Page<Farm> localList(String local,Model model,Pageable pageable) {

        Page<Farm> result = null;
        String[] farmlocal = {"전체","서울","경기","인천","강원","제주","대전","충북","충남/세종","부산","울산","경남","대구","경북","광주","전남","전주/전북"};
        for(int i = 0; i < farmlocal.length; i++){
            if(local.equals(farmlocal[i])){
                if(i == 0) {
                    result = farmRepository.findAll(pageable);
                    break;
                }else {
                    result = farmRepository.findByWfAddrLike(local + "%",pageable);
                    break;
                }
            }
        }
        //System.out.println(local);
        if(local.equals("충북")) {
            result = farmRepository.findByWfAddrLikeKeywords("충청북도","충북",pageable);
        }
        if(local.equals("경남")) {
            result = farmRepository.findByWfAddrLikeKeywords("경상남도","경남",pageable);
        }
        if(local.equals("경북")) {
            result = farmRepository.findByWfAddrLikeKeywords("경상북도","경북",pageable);
        }
        if(local.equals("충남/세종")) {
            result = farmRepository.findByWfAddrLikeKeywords("충청남도","세종","충남",pageable);
        }
        if(local.equals("전남")) {
            result = farmRepository.findByWfAddrLikeKeywords("전라남도","전남",pageable);
        }
        if(local.equals("전주/전북")) {
            result = farmRepository.findByWfAddrLikeKeywords("전라북도","전북","전주",pageable);
        }
        return result;
    }


    public void save(Reservation reservation) {
        reservationRepository.save(reservation);
    }

    public List<Reservation> mypageReservation(Long id) {
        return reservationRepository.findAllByRvMemIdxOrderByRvDateDesc(id);
    }

    public List<String> reservationFarm (Long id) {
        return reservationRepository.findWfSubjectByMemIdx(id);
    }

}