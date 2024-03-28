
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>

<div class="con login-wrap">
    <div class="login-form">
        <c:choose>
            <c:when test="${loginUser != null}">
                <b>${loginUser.memid}</b>님 로그인
            </c:when>
            <c:when test="${loginUser == null}">
                <form action="loginForm" method="post">
                    <ul>
                        <li>
                            <c:choose>
                                <c:when test="${insertComplete==true}">
                                    <h3>회원가입을 환영합니다</h3>
                                </c:when>
                            </c:choose>
                        </li>
                        <li>
                            <h3>로그인</h3>
                        </li>
                        <li>
                            <c:choose>
                                <c:when test="${isOutUser==true}">
                                    <p class="fail_check">
                                        <b>탈퇴한 사용자 입니다</b>
                                    </p>
                                </c:when>
                                <c:when test="${loginFail == true}">
                                    <p class="fail_check">
                                        아이디 또는 비밀번호가 일치하지 않습니다
                                    </p>
                                </c:when>
                            </c:choose>
                        </li>
                        <li class="login-input-box">
                            <input name="memid" id="id" placeholder="ID">
                        </li>
                        <li class="login-input-box">
                            <input type="password" name="pass" id="pass" placeholder="PASSWORD">
                        </li>
                        <li class="forgot-pass">
                            <a href="forgotPass">비밀번호 찾기</a>
                        </li>
                        <li>
                            <input class="btn-login" type="submit" value="로그인">
                        </li>
                    </ul>
                </form>
            </c:when>
        </c:choose>
    </div>
</div>
<script>
    if(${insertComplete}){
        alert("주말농장에 어서오세요오");
    }
</script>
<%@include file="../include/footer.jsp" %>