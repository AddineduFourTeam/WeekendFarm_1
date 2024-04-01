<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<div class="con wrap">
    <%@include file="../include/mypg_menu.jsp" %>
    <div class="cancel-wrap">

        <div class="cancel-form">
            <h3>회원 탈퇴 버튼 선택시, <br/>계정은 삭제되며 복구되지 않습니다</h3>
            <c:choose>
                <c:when test="${isOutUser==false}">
                    <p class="fail_check">
                        <b>비밀번호가 일치하지 않습니다</b>
                    </p>
                </c:when>
                <c:when test="${isOutFail==false}">
                    <p class="fail_check">
                        <b>회원탈퇴에 실패했습니다</b>
                    </p>
                </c:when>
            </c:choose>
            <form action="cancelAccountForm" method="post" class="cancelAccountForm">
                <div>
                    <span>회원 탈퇴를 위해 비밀번호를 입력해주세요</span>
                    <input type="password" name="cancelPass" class="cancelPass" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="cancel-btn-wrap">
                    <a href="/" class="btn-cancel-home">홈으로</a>
                    <input type="submit" class="btn-cancel" value="회원 탈퇴">
                </div>
            </form>
        </div>
    </div>
</div>
</div>
</div>

<%@include file="../include/footer.jsp" %>