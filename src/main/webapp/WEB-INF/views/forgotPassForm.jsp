
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="con login-wrap">
    <div class="forgot-pass-form">
        <div id="forgot">
            <div class="forgot-h">
                <h3>비밀번호 재설정</h3>
                <h4>(회원 정보 확인)</h4>
            </div>
            <form action="forgotPassCheck" method="post" modelAttribute="infoCheck">
                <%--${ChangePass == false}--%>
                <p class="fail_check" style="display: none;">입력정보와 일치하는 회원이 존재하지 않습니다</p>
                <ul>
                    <li class="forgot-input-box">
                        <p>아이디</p>
                        <input name="memid" id="memid" placeholder="아이디를 입력해주세요">
                    </li>
                    <li class="forgot-input-box">
                        <p>휴대전화번호</p>
                        <input name="phone" id="phone" placeholder="'-'없이 번호만 입력해주세요">
                    </li>
                    <li class="forgot-input-box">
                        <p>이메일</p>
                        <input type="email" name="email" id="email" placeholder="이메일을 입력해주세요">
                    </li>
                    <li>
                        <input type="submit" class="btn-login" value="회원 정보 확인">
                    </li>
                </ul>
            </form>
        </div>
        <div id="forgotPass" style="display: none;">
            <%--${ChangePass == true}--%>
            <h3>비밀번호 재설정</h3>
                <h4>새로 지정할 비밀번호를 입력해주세요</h4>
            <form action="forgotPass" method="post" id="forgetPass">
                <ul>
                    <li class="forgot-input-box">
                        <p>새로운 비밀번호 입력</p>
                        <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력해주세요">
                    </li>
                    <li class="forgot-input-box">
                        <p>비밀번호 확인</p>
                        <input type="password" name="repass" id="repass" placeholder="비밀번호를 한 번 더 입력해주세요">
                        <div id="checkRePassResult" style="font-size:0.8em; display:none;"></div>
                    </li>
                    <li>
                        <input id="forgotPassBtn" class="btn-login" type="submit" value="비밀번호 변경">
                    </li>
                </ul>
                <input type="hidden" name="memid">
            </form>
        </div>
    </div>
</div>

<script>
    $(()=>{
        const $passInput = $("#pass");
        const $repassInput = $("#repass");

        $repassInput.keyup(function() {
            if ($passInput.val() !== $repassInput.val()) {
                $("#checkRePassResult").show().css("color", "red").text("비밀번호가 일치하지 않습니다.");
                $("#forgotPassBtn :submit").attr("disabled", true).css("background","#ddd");
            } else {
                $("#checkRePassResult").show().css("color", "#01b03f").text("비밀번호가 일치합니다.");
                $("#forgotPassBtn :submit").attr("disabled", false).css("background","#01b03f");
            }
        });
    });

    // 버튼 누르면 위에 사라짐
    $(()=>{
        // forgotPassCheck 폼이 제출될 때
        $("form[modelAttribute='infoCheck']").submit(function (e) {
            e.preventDefault(); // 기본 폼 제출 방지

            // 폼 데이터를 직렬화
            var formData = $(this).serialize();

            // AJAX 요청
            $.ajax({
                type: "POST",
                url: "/forgotPassCheck", // 서버 엔드포인트에 맞게 수정
                data: formData,
                success: function (data) {
                    console.log("data:"+data.ChangePass);
                    // 서버에서 받은 데이터 처리
                    var ChangePass = data.ChangePass;
                    console.log("changepass" + ChangePass);
                    if (ChangePass===true) {
                        // ChangePass가 true이면 forgotPassForm을 표시
                        $("#forgotPass").show();
                        $("#forgot").hide();
                    } else {
                        // ChangePass가 false이면 fail_check 메시지를 표시
                        $(".fail_check").show();
                    }
                },
                error: function (error) {
                    console.log("Error:", error);
                }
            });
        });
    });
    /* ChangePass넘어오는지 확인용
    var ChangePass = <%--<%= request.getAttribute("ChangePass") %>;--%>
    console.log(ChangePass);
    if (ChangePass === true) {
        $("#forgotPassForm").show();
    } else {
        $(".fail_check").show();
    }
    */

    // forgotPassCheck폼에 있던 memid값을 forgotPassForm으로 넘겨줌
    $(()=>{
        $("#forgotPassBtn").click(function() {
            var memidValue = $("#memid").val();
            $("#forgotPass input[name='memid']").val(memidValue);
        });
    });
</script>
<%@ include file="../include/footer.jsp" %>