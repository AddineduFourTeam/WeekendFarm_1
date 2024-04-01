package com.farm.repository;

import com.farm.domain.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findTop5ByReviewMemIdxOrderByReviewDateDesc(Long memIdx);

    Page<?> findByReviewMemIdxOrderByReviewDateDesc(Long idx, Pageable pageable);

    @Query("select fm.wfSubject from Farm fm " +
            "join Review rv on rv.reviewWfIdx = fm.wfIdx " +
            "where rv.reviewMemIdx = :memIdx order by rv.reviewDate desc")
    List<String> findWfSubjectByMemIdx(Long memIdx);

    Optional<Review> findByReviewRvIdx(Long id);
    List<Review> findByReviewWfIdx(Long id);
}
