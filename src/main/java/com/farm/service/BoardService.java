package com.farm.service;

import com.farm.domain.Board;
import com.farm.domain.Farm;
import com.farm.domain.Story;
import com.farm.repository.BoardRepository;
import com.farm.repository.FarmRepository;
import com.farm.repository.MemberRepository;
import com.farm.repository.StoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

import java.util.Optional;

@Service
public class BoardService {
    @Autowired
    BoardRepository boardRepository;

    public Optional<Board> detail(Long bno) {
        Board board = boardRepository.findById(bno).orElseGet(null);
        board.setBoardCount(board.getBoardCount() + 1);
        boardRepository.save(board);
        return boardRepository.findById(bno);
    }

}

