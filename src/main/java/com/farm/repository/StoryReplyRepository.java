package com.farm.repository;

import com.farm.domain.StoryReply;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Dictionary;
import java.util.List;

public interface StoryReplyRepository extends JpaRepository<StoryReply, Long> {
    //Page<StoryReply> findBySrStoryIdx(Long id, Pageable pageable);
    Page<StoryReply> findBySrStoryIdxAndSrDepth(Long srStoryIdx, int srDepth, Pageable pageable);

    List<StoryReply> findBySrStoryIdxAndSrDepthAndSrReplyIdx(Long srStoryIdx, int srDepth, Long rIdx);

    Page<StoryReply> findBySrStoryIdx(Long id, Pageable pageable);

    //Page<StoryReply> findBySrStoryIdx(Long id, Pageable pageable);
}
