package com.farm.repository;

import com.farm.domain.Farm;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface FarmRepository extends JpaRepository<Farm, Long> {

    //Page<Farm> findAllOrderByWfIdxDesc(Pageable pageable);
    Page<Farm> findByWfAddrContaining(String keyword, Pageable pageable);

    Page<Farm> findByWfSubjectContaining(String keyword, Pageable pageable);

    Page<Farm> findByWfThemeContaining(String keyword, Pageable pageable);

    Page<Farm> findByWfAddrLike(String local, Pageable pageable);

    @Query("SELECT e FROM Farm e WHERE e.wfAddr LIKE :keyword1% OR e.wfAddr LIKE :keyword2%")
    Page<Farm> findByWfAddrLikeKeywords(@Param("keyword1") String keyword1, @Param("keyword2") String keyword2, Pageable pageable);
    @Query("SELECT e FROM Farm e WHERE e.wfAddr LIKE :keyword1% OR e.wfAddr LIKE :keyword2% OR e.wfAddr LIKE :keyword3%")
    Page<Farm> findByWfAddrLikeKeywords(@Param("keyword1") String keyword1, @Param("keyword2") String keyword2, @Param("keyword3") String keyword3, Pageable pageable);

}