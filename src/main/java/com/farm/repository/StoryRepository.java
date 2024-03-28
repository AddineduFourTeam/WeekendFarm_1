package com.farm.repository;

import com.farm.domain.Board;
import com.farm.domain.Member;
import com.farm.domain.Story;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StoryRepository extends JpaRepository<Story, Long> {

    //List<Story> findAll();
    @Query("select s from Story s order by s.storyCount limit 5")
    List<Story> findStory();
    Page<Story> findByStorySubjectContaining(String keyword, Pageable pageable);
    Page<Story> findByStoryContentContaining(String keyword, Pageable pageable);

    Page<Story> findByStoryMemNameContaining(String keyword, Pageable pageable);

    //Page<Story> findBySrStoryIdx(Long sno, Pageable pageable);

    //@Query("select s from Story s where s.storyMemIdx = :memIdx order by s.storyDate desc limit 5")
    List<Story> findTop3ByStoryMemIdxOrderByStoryDateDesc(Long memIdx);

    Page<Story> findByStoryMemIdx(Long idx, Pageable pageable);
}
