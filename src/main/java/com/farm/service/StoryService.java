package com.farm.service;

import com.farm.domain.Member;
import com.farm.domain.Story;
import com.farm.repository.FarmRepository;
import com.farm.repository.StoryRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Service
public class StoryService {
    @Autowired
    StoryRepository storyRepository;

    @Autowired
    CommonService commonService;

    @Autowired
    MemberService memberService;

    @Autowired
    FarmRepository farmRepository;

    //story detail 불러오기


    public Story storydetail(Long sno) {
        Story story = storyRepository.findById(sno).orElseGet(null);
        //Story.setStoryCount((int)(story.get().getStoryCount() + 1));
        story.setStoryCount(story.getStoryCount() + 1);
        storyRepository.save(story);

        return story;
    }

    public void storyForm(Story story, MultipartFile file1 , MultipartFile file2 , MultipartFile file3) throws Exception {
        story.setStoryImg1(file1.getBytes());
        story.setStoryImg2(file2.getBytes());
        story.setStoryImg3(file3.getBytes());
        storyRepository.save(story);
    }
    public void storyUpdate(Story updatedStory,Long sno, MultipartFile file1 , MultipartFile file2 , MultipartFile file3) throws Exception {
        Story originalStory = storyRepository.findById(sno).orElseGet(null);
       /*System.out.println("originalStory = " + originalStory.getStoryIdx());
        System.out.println("updatedStory = " + updatedStory.getStoryIdx());*/
        updatedStory.setStoryImg1(file1.getBytes());
        updatedStory.setStoryImg2(file2.getBytes());
        updatedStory.setStoryImg3(file3.getBytes());
        updatedStory.setStoryDate(originalStory.getStoryDate());
        updatedStory.setStoryContent(originalStory.getStoryContent().replaceAll("\r\n","<br>"));
        BeanUtils.copyProperties(updatedStory,originalStory);
        //System.out.println("updatedStory = " + updatedStory.getStoryIdx() + " originalStory idx = " + originalStory.getStoryIdx());
        storyRepository.save(updatedStory);
    }

    public byte[] getImg(Long id , int imgNum) {
        if(imgNum == 1) {
            return storyRepository.findById(id).get().getStoryImg1();
        }
        else if(imgNum == 2) {
            return storyRepository.findById(id).get().getStoryImg2();
        }
        else if(imgNum == 3) {
            return storyRepository.findById(id).get().getStoryImg3();
        }else {
            return null;
        }

    }
    public void listAll(Model model) {
        List<Story> content = storyRepository.findStory();
        model.addAttribute("list", content);
    }

    /* 마이페이지 story 가져오기 */
    public String getStoryMemId(String memid) {
        Member member = memberService.findByMemid(memid);
        return member.getMemid();
    }

    public void storyDelete(Long id) {
        storyRepository.deleteById(id);
    }

    public Object storyWrite(Long sno) {
        Story story = storyRepository.findById(sno).orElseGet(null);

        /*Farm farm = farmRepository.findById(story.getStoryWfIdx()).orElseGet(null);
        model.addAttribute("farm", farm);*/

        return story;
    }




   /* public List<byte[]> getImg(Long id) {
        List<byte[]> imgList = storyRepository.findById(id).stream()
                .flatMap(story -> Stream.of(story.getStoryImg1(), story.getStoryImg2(), story.getStoryImg3()))
                .filter(Objects::nonNull)  // 필요에 따라 null 체크를 추가할 수 있습니다.
                .toList();

        //System.out.println("imgList = " + imgList);
        //return storyRepository.findById(id).get().getStoryImg1();
        return imgList;
    }*/
}
