<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<div class="con wrap">
    <%@include file="../include/mypg_menu.jsp" %>
        <div class="upass-wrap">
            <div class="upass-form">
                <div class="upass-h">
                    <h3>비밀번호 변경</h3>
                    <h4>변경할 비밀번호를 입력해주세요</h4>
                </div>
                <div>
                    <%--${ChangePass == true}--%>
                    <form action="updatePass" method="post" id="updatePassForm">
                        <ul>
                            <li class="upass-input-box">
                                <p>새로운 비밀번호 입력</p>
                                <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력해주세요">
                            </li>
                            <li class="upass-input-box">
                                <p>비밀번호 확인</p>
                                <input type="password" name="repass" id="repass" placeholder="비밀번호를 한 번 더 입력해주세요">
                                <div id="checkRePassResult" style="font-size:0.8em; display:none;"></div>
                            </li>
                            <li>
                                <input id="updatePassBtn" class="btn-login m-top" type="submit" value="비밀번호 변경">
                            </li>
                        </ul>
                        <input type="hidden" name="memid">
                    </form>
                </div>
            </div>
        </div>

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
                $("#updatePassBtn :submit").attr("disabled", true).css("background","#ddd");
            } else {
                $("#checkRePassResult").show().css("color", "#01b03f").text("비밀번호가 일치합니다.");
                $("#updatePassBtn :submit").attr("disabled", false).css("background","#01b03f");
            }
        });
    });

</script>
<%@include file="../include/footer.jsp" %>