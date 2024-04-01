<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<div class="join-wrap">
  <div class="join-form">
    <form action="memInsert" onsubmit="validateForm()" method="post" id="joinForm" enctype="multipart/form-data">
      <ul style="list-style-type: none">
        <li>
          <h3>회원가입</h3>
        </li>
        <li class="join-input-box">
          <p>아이디</p>
          <input name="memid" id="memid" placeholder="영어 소문자+숫자 조합 13자 이하">
          <div id="checkIdResult" style="font-size:0.8em; display:none;"></div>
        </li>
        <li class="join-input-box">
          <p>비밀번호</p>
          <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력해주세요">
        </li>
        <li class="join-input-box">
          <p>비밀번호 확인</p>
          <input type="password" name="repass" id="repass" placeholder="비밀번호를 한 번 더 입력해주세요">
          <div id="checkRePassResult" style="font-size:0.8em; display:none;"></div>
        </li>
        <li class="join-input-box">
          <p>이름</p>
          <input name="name" id="name" placeholder="한글만 입력해주세요">
          <div id="checkNameResult" style="font-size:0.8em; display:none;"></div>
        </li>
        <li class="join-input-box">
          <p>생년월일</p>
          <input name="birth" id="birth" placeholder="예시) 240131">
          <div id="checkBirthResult" style="font-size:0.8em; display:none;"></div>
        </li>
        <li class="join-input-box">
          <p>휴대전화번호</p>
          <input name="phone" id="phone" placeholder="'-'없이 번호만 입력해주세요">
          <div id="checkPhoneResult" style="font-size:0.8em; display:none;"></div>
        </li>
        <li>
          <div class="email_box">
            <div class="email-input-box">
              <p>이메일</p>
              <input type="text" name="a_email" id="a_email" class="form-control" placeholder="이메일을 입력해주세요"> <b>@</b>
            </div>
            <div class="email-select-box">
              <input type="text" name="b_email" id="b_email" class="form-control" ReadOnly="true"/>
              <select name="emailCheck" id="emailCheck" onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)" class="form-control">
                <option value="">메일 선택</option>
                <option value="etc">직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="daum.net">daum.net</option>
                <option value="nate.com">nate.com</option>
                <option value="gmail.com">gmail.com</option>
              </select>
            </div>
          </div>
          <input type="hidden" name="email" id="email">
        </li>
        <li class="file-top">
          <p>프로필이미지</p>
          <input type="file" name="file" id="file" class="btn-file">
          <span class="modi_img" >
            <img src="" alt="" id="View">
          </span>
        </li>
        <li>
          <input class="btn-join" type="submit" value="회원가입">
        </li>
      </ul>
    </form>
  </div>
</div>
<script>
  $(()=>{
    const $idInput = $("#memid");
    const $passInput = $("#pass");
    const $repassInput = $("#repass");
    const $nameInput = $("#name");
    const $birthInput = $("#birth");
    const $phoneInput = $("#phone");
    const $a_emailInput = $("#a_email");
    const $b_emailInput = $("#b_email");
    const idValidate = /^[a-z\d]{3,11}$/;
    const nameValidate = /^[가-힣]{2,}$/;
    const birthValidate = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;
    const phoneValidate = /^01[0-9]{8,9}$/;

    //$("#joinForm :submit").attr("disabled",true).css("background","#ddd");

    $("#joinForm").submit(function(event){
      if($idInput.val().trim() === ""){
        $idInput.focus().css("background", "#ddd").attr("placeholder", "아이디를 입력해주세요");
        $idInput.on('input', function(){
          $idInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($passInput.val().trim() === ""){
        $passInput.focus().css("background", "#ddd").attr("placeholder", "비밀번호를 입력해주세요");
        $passInput.on('input', function(){
          $passInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($repassInput.val().trim() === ""){
        $repassInput.focus().css("background", "#ddd").attr("placeholder", "비밀번호를 다시 입력해주세요");
        $repassInput.on('input', function(){
          $repassInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($nameInput.val().trim() === ""){
        $nameInput.focus().css("background", "#ddd").attr("placeholder", "이름을 입력해주세요");
        $nameInput.on('input', function(){
          $nameInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($birthInput.val().trim() === ""){
        $birthInput.focus().css("background", "#ddd").attr("placeholder", "생년월일을 입력해주세요");
        $birthInput.on('input', function(){
          $birthInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($phoneInput.val().trim() === ""){
        $phoneInput.focus().css("background", "#ddd").attr("placeholder", "휴대전화번호를 입력해주세요");
        $phoneInput.on('input', function(){
          $phoneInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($a_emailInput.val().trim() === ""){
        $a_emailInput.focus().css("background", "#ddd").attr("placeholder", "이메일을 입력해주세요");
        $a_emailInput.on('input', function(){
          $a_emailInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }else if($b_emailInput.val().trim() === ""){
        $b_emailInput.focus().css("background", "#ddd").attr("placeholder", "이메일을 입력해주세요");
        $b_emailInput.on('input', function(){
          $b_emailInput.css("background", "").attr("placeholder", "");
        });
        event.preventDefault();
        return;
      }
    });

    $idInput.keyup(function(){
      if(idValidate.test($idInput.val())){
        if($idInput.val().length >= 5){
          $.ajax({
            url: "idCheck",
            data : {id: $idInput.val()},
            success:function(result){
              console.log("data"+$idInput.val());
              if(result){
                $("#checkIdResult").show().css("color","red").text("중복된 아이디가 존재합니다");
                $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
              }else{
                $("#checkIdResult").show().css("color","#01b03f").text("사용가능한 아이디 입니다");
                $("#joinForm :submit").attr("disabled", false).css("background","#01b03f");
              }
            },
            error:function(){
              console.log("아이디 중복체크용 ajax 실패");
            }
          })
        }else{
          $("#checkIdResult").show();
          $("#checkIdResult").css("color","#ddd").text("아이디를 5자 이상 입력해주세요");
          $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
        }
      }else{
        $("#checkIdResult").show().css("color","red").text("영어 소문자+숫자로 5~13자로 작성해주세요");
        $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
      }
    });

    $repassInput.keyup(function() {
      if ($passInput.val() !== $repassInput.val()) {
        $("#checkRePassResult").show().css("color", "red").text("비밀번호가 일치하지 않습니다.");
        $("#joinForm :submit").attr("disabled", true).css("background","#ddd");
      } else {
        $("#checkRePassResult").show().css("color", "#01b03f").text("비밀번호가 일치합니다.");
        $("#joinForm :submit").attr("disabled", false).css("background","#01b03f");
      }
    });

    $nameInput.keyup(function(){
      if($nameInput.val().length >= 1){
        if(nameValidate.test($nameInput.val())){
          $("#checkNameResult").show().css("color","#01b03f").text("사용가능한 이름 입니다");
          $("#joinForm :submit").attr("disabled", false).css("background","#01b03f");
        }else{
          $("#checkNameResult").show().css("color","red").text("2글자 이상 한글로 작성해주세요");
          $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
        }
      }
    });

    $birthInput.keyup(function(){
      if($birthInput.val().length >= 6){
        if(birthValidate.test($birthInput.val())){
          $("#checkBirthResult").show().css("color","#01b03f").text("사용가능한 생년월일 입니다");
          $("#joinForm :submit").attr("disabled", false).css("background","#01b03f");
        }else{
          $("#checkBirthResult").show().css("color","red").text("년월일을 6자리를 작성해주세요");
          $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
        }
      }
    });

    $phoneInput.keyup(function(){
      if($phoneInput.val().length >= 10){
        if(phoneValidate.test($phoneInput.val())){
          $("#checkPhoneResult").show().css("color","#01b03f").text("사용가능한 전화번호 입니다");
          $("#joinForm :submit").attr("disabled", false).css("background","#01b03f");
        }else{
          $("#checkPhoneResult").show().css("color","red").text("전화번호를 바르게 입력 해주세요");
          $("#joinForm :submit").attr("disabled",true).css("background","#ddd");
        }
      }
    });
  })

  $(function() {
    $("#file").on('change', function(){
      readURL(this);
    });
  });
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#View').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  /////////////////////이메일
  function SetEmailTail(emailValue) {
    var email = document.all("a_email")    // 사용자 입력
    var emailTail = document.all("b_email") // Select box

    if ( emailValue == "notSelected" )
      return;
    else if ( emailValue == "etc" ) {
      emailTail.readOnly = false;
      emailTail.value = "";
      emailTail.focus();
    } else {
      emailTail.readOnly = true;
      emailTail.value = emailValue;
    }
  }
  function validateForm() { //form에 온서브밋이 있을경우 없으면 버튼 아이디 클릭해서 이용하시길 - onsubmit="return validateForm()"
    var mail1 = $('#a_email').val();
    var mail2 = $('#b_email').val();
    var real_mail = mail1 +'@' + mail2;
    $("#email").val(real_mail);
    return false;
  }
</script>


<%@include file="../include/footer.jsp" %>