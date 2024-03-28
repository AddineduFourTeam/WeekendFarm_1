package com.farm.controller;

import com.farm.domain.Member;
import com.farm.domain.Story;
import com.farm.domain.StoryReply;
import com.farm.dto.MemInfoDto;
import com.farm.service.CommonService;
import com.farm.service.StoryService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;


@Slf4j
@Controller
public class StoryController {
    @Autowired
    StoryService storyService;

    @Autowired
    CommonService commonService;


    @GetMapping("/story")
    public String storyList(@RequestParam(value="page", defaultValue="1") int page , Model model) {
        commonService.listAll(page, model, Story.class);
        return "story";
    }


    @GetMapping("/storySearch")
    public String storySearch(@RequestParam(value="page", defaultValue="1") int page , @RequestParam(value="type") String type , @RequestParam(value="keyword") String keyword , Model model) {
        commonService.searchList(page ,type , keyword , model, Story.class);
        return "story";
    }

    @GetMapping("/storyDetail")
    public String storydetail(@RequestParam(value="id") Long id,@RequestParam(value="page", defaultValue="1") int page , Model model) {
        model.addAttribute("story", storyService.storydetail(id));
        commonService.replyDetail(id,page,model,StoryReply.class);
        //commonService.reReplyDetail(id,srDepth,rIdx,page,model,StoryReply.class);
        return "storyDetail";
    }
    @PostMapping("/storyReplyList")
    public List<StoryReply> storyReplyList(@RequestParam("id") Long id, @RequestParam("srIdx") Long srIdx, Model model) {
        return commonService.storyReplyList(id,srIdx,model);
    }

    @GetMapping("/storyDelete")
    public String storyDelete(@RequestParam(value="id") Long id) {
        storyService.storyDelete(id);
        return "redirect:/story";
    }

    @GetMapping("/storyWrite")
    public String storywrite(Model model,@RequestParam(value="sno", required = false) Long sno) {
        if (sno != null && sno > 0) {
            model.addAttribute("story", storyService.storyWrite(sno));
        }

        return "storyWrite";
    }
    @PostMapping("/storyForm")
    public String storyForm(Story story , HttpSession session , @RequestParam(value="file1" , required = false) MultipartFile file1 , @RequestParam(value="file2" , required = false) MultipartFile file2 , @RequestParam(value="file3" , required = false) MultipartFile file3) {
        //System.out.println("loginUser = " + loginUser);
        story.setStoryMemIdx(((Member)session.getAttribute("loginUser")).getMemIdx());
        story.setStoryMemName(((Member)session.getAttribute("loginUser")).getName());
        story.setStoryMemImg(((Member)session.getAttribute("loginUser")).getMemImg());
        story.setStoryMemId(((Member)session.getAttribute("loginUser")).getMemid());

        try {
            storyService.storyForm(story,file1,file2,file3);
        }catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/story";
    }
    @PostMapping("/storyUpdate")
    public String storyUpdate(Story story , @RequestParam("storyIdx") Long sno , HttpSession session , @RequestParam(value="file1" , required = false) MultipartFile file1 , @RequestParam(value="file2" , required = false) MultipartFile file2 , @RequestParam(value="file3" , required = false) MultipartFile file3) {
        //System.out.println("loginUser = " + loginUser);
        story.setStoryMemIdx(((Member)session.getAttribute("loginUser")).getMemIdx());
        story.setStoryMemName(((Member)session.getAttribute("loginUser")).getName());
        story.setStoryMemImg(((Member)session.getAttribute("loginUser")).getMemImg());
        story.setStoryMemId(((Member)session.getAttribute("loginUser")).getMemid());

        try {
            System.out.println("통과");
            storyService.storyUpdate(story,sno,file1,file2,file3);
        }catch (Exception e) {
            System.out.println("불통");
            e.printStackTrace();
        }

        return "redirect:/story";
    }

    @PostMapping("/storyReplySave")
    @ResponseBody
    public MemInfoDto storyReplySave(StoryReply storyReply,@RequestParam("id") Long id) {
        //System.out.println("storyReply = " + storyReply);
        storyReply.setSrStoryIdx(id);
        MemInfoDto sr = (MemInfoDto)commonService.replySave(storyReply);
        //System.out.println("sr = " + sr);
        //System.out.println("storyReply = " + storyReply);
        return sr;
    }

    @PostMapping("/likeUp")
    @ResponseBody
    public int likeUp(@RequestParam("id") Long id) {
        return commonService.likeUp(id);
    }
    @PostMapping("/likeDown")
    @ResponseBody
    public int likeDown(@RequestParam("id") Long id) {
        return commonService.likeDown(id);
    }

    @PostMapping("/replyUpdate")
    @ResponseBody
    public String replyUpdate(@RequestParam("id") Long id, @RequestParam("txt") String txt) {
        return commonService.replyUpdate(id,txt);
    }
    @PostMapping("/replyDelete")
    @ResponseBody
    public String replyDelete(@RequestParam("id") Long id,HttpSession session) {
        commonService.replyDelete(id,StoryReply.class,session);
        return "storyDetail";
    }
    @PostMapping("/storyDelete")
    @ResponseBody
    public String storyDelete(@RequestParam("id") Long id,HttpSession session) {
        commonService.replyDelete(id,Story.class,session);
        return "storyDetail";
    }
}
