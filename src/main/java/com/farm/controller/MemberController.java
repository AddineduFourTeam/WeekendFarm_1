package com.farm.controller;

import com.farm.domain.Member;
import com.farm.service.CommonService;
import com.farm.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@SessionAttributes({"loginUser"})
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    CommonService commonService;

    @Autowired
    PasswordEncoder pEncoder;

    /*
     * 회원가입
     * join : 회원가입 form 페이지로 이동
     * idCheck : 회원가입시 아이디 중복 체크
     * memInsert : 가입 정보 insert
     *             가입시 프로필 이미지도 함께 삽입
     *             회원가입 성공시 insertComplete:true값과 함께 login페이지로 redirect
     */

    @GetMapping("/join")
    public String memInsertForm(){
        return "/join";
    }

    @GetMapping("/idCheck")
    @ResponseBody
    public boolean checkId(@RequestParam("id") String memid){
        //System.out.println("idCheck 메서드 호출됨, memid: " + memid);

        return memberService.idCheck(memid);
    }


    @PostMapping("/memInsert")
    public String memInsert(Member member,
                            @RequestParam("file") MultipartFile file,
                            RedirectAttributes redirectAttributes) throws Exception {

        member.setPass(pEncoder.encode(member.getPass()));

        Long memIdx = member.getMemIdx();

        if(!file.isEmpty()){
          String filename =  commonService.uploadImage(file, memIdx);
          member.setMemImg(filename);
        }

        memberService.memInsert(member, file);

        redirectAttributes.addFlashAttribute("insertComplete", true);

        return "redirect:/login";
  
    }

    /*
     * 로그인 / 로그아웃
     * login : 로그인 페이지 이동
     * loginForm : 로그인 정보(id, pass)확인해서 탈퇴한 사용자, 비밀번호 일치 확인 후 로그인 진행
     * logout : 사용자 로그아웃
     */
    @GetMapping("/login")
    public String loginForm(){
        return "login";
    }

    @PostMapping("/loginForm")
    public String login(Member member, Model model, HttpSession session){
        //System.out.println("id : " + member.getMemid() ); // memid 값 확인
        Member loginUser = memberService.login(member.getMemid());
        //System.out.println("loginUser = " + loginUser); // loginUser값 확인

        if(loginUser != null){
            // 탈퇴한 사용자 체크
            if(loginUser.getIsOut().equals("Y")){
                model.addAttribute("isOutUser",true);
                return "login";

            // 탈퇴하지 않은 사용자 비밀번호 일치 확인    
            }else if(pEncoder.matches(member.getPass(),loginUser.getPass())){
                model.addAttribute("loginUser",loginUser);
                session.setAttribute("loginUser",loginUser);
                return "redirect:/";
                
            // 탈퇴하지 않은 사용자 비밀번호 일치하지 않는 경우    
            }else{
                model.addAttribute("loginFail", true);
                return "login";

            }
        }else{
            // 사용자 정보가 없는 경우
            model.addAttribute("loginFail", true);
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(SessionStatus status){
        if(!status.isComplete()){
            status.setComplete();
        }
        return "redirect:/";
    }

    /*
     * 잃어버린 비밀번호 재설정(로그인 없음)
     * forgotPass : 비밀번호 재설정 정보 확인 페이지로 이동
     * forgotPassCheck : 비밀번호 재설정을 위한 정보 확인 실행
     *                   memid, email, phone 데이터 받아서 DB값과 일치하는지 확인 후, 일치하면 pass 재설정
     */
    @GetMapping("/forgotPass")
    public String forgotPass(){
        return "forgotPassForm";
    }

    @PostMapping("/forgotPassCheck")
    @ResponseBody
    public Map<String, Object> forgotPassCheck(@ModelAttribute("infoCheck") Member infoCheck) {
        Map<String, Object> response = new HashMap<>();

        Optional<Member> opMember = memberService.getMemberById(infoCheck.getMemid());

        if (opMember.isPresent()) {
            Member dbMember = opMember.get();
            if (infoCheck.getMemid().equals(dbMember.getMemid()) &&
                    infoCheck.getEmail().equals(dbMember.getEmail()) &&
                    infoCheck.getPhone().equals(dbMember.getPhone())) {
                response.put("ChangePass", true);
            } else {
                response.put("ChangePass", false);
            }
        } else {
            response.put("ChangePass", false);
        }

        return response;
    }

    @PostMapping("/forgotPass")
    public String forgotPass(@RequestParam("memid") String memid,
                             @RequestParam("pass") String newPass){
        String pass = pEncoder.encode(newPass);
        memberService.updatePass(memid,pass);

        return "completePass"; // 비밀번호 변경완료 페이지
    }

}
