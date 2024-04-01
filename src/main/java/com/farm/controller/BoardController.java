package com.farm.controller;

import com.farm.domain.Board;
import com.farm.domain.Story;
import com.farm.repository.BoardRepository;
import com.farm.service.BoardService;
import com.farm.service.CommonService;
import com.farm.service.ListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {
    @Autowired
    BoardService boardService;

    @Autowired
    CommonService commonService;

    @GetMapping("/board")
    public String boardlist(@RequestParam(value="page", defaultValue="1") int page , Model model) {
        commonService.listAll(page, model, Board.class);
        return "board";
    }

    @GetMapping("/boardSearch")
    public String boardSearch(@RequestParam(value="page", defaultValue="1") int page , @RequestParam(value="type") String type , @RequestParam(value="keyword") String keyword , Model model) {
        commonService.searchList(page ,type , keyword , model, Board.class);
        return "board";
    }

    @GetMapping("/boardDetail")
    public String boardDetail(@RequestParam(value="bno") Long bno, Model model) {
        model.addAttribute("board", boardService.detail(bno).get());
        return "boardDetail";
    }

}
