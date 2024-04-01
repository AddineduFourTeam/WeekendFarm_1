package com.farm.repository;

import com.farm.domain.Board;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Long> {
    //Page<Board> findByBoardSubjectLike(String searchString, Pageable pageable);
    Page<Board> findByBoardSubjectContaining(String keyword, Pageable pageable);
    Page<Board> findByBoardContentContaining(String keyword, Pageable pageable);

}