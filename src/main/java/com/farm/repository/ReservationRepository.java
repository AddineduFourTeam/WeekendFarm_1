package com.farm.repository;

import com.farm.domain.Farm;
import com.farm.domain.Reservation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.net.ContentHandler;
import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findTop5ByRvMemIdxOrderByRvDateDesc(Long memIdx);

    @Query("select fm.wfSubject from Farm fm " +
            "join Reservation rv on rv.rvFarmIdx = fm.wfIdx " +
            "where rv.rvMemIdx = :memIdx order by rv.rvDate desc")
    List<String> findWfSubjectByMemIdx(Long memIdx);
    Page<Reservation> findByRvMemIdxOrderByRvDateDesc(Long idx, Pageable pageable);

//    List<Reservation> findAllByrvMemIdx(Long id);
    List<Reservation> findAllByRvMemIdxOrderByRvDateDesc(Long id);


}

