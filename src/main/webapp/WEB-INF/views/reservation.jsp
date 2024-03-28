<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--<%@include file="../include/header.jsp" %>--%>
<!-- 현재날짜 -->
<c:set var="today" value="<%=new java.util.Date()%>"/>
<!-- 현재년도 -->
<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy"/></c:set>
<c:if test="${empty loginUser}">
<%--    <script>--%>
<%--        alert("로그인 후 작성 가능합 니다.");--%>
<%--        location.href="/login";--%>
<%--    </script>--%>
</c:if>

<div class="con wrap reservation_wrap">
    <div class="reservation">
        <div>
            <h3>이용 기간</h3>
            <div class="date_wrap">
                <c:forEach begin="${year}" end="${year+5}" var="year">
                    <div class="date">
                        <label for="year${year}">
                            <input type="checkbox" name="year" id="year${year}" value="${year}">
                            <span class="txt">${year}</span>
                        </label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div>
            <h3>평 수</h3>
            <div class="field_wrap">
                <c:forEach begin="1" end="9" varStatus="index">
                    <div class="field">
                        <input type="checkbox" value="feet" name="feet" id="feet${index.count}">
                        <label for="feet${index.count}">
                            <img src="../img/field.png">
                        </label>
                    </div>
                </c:forEach>
            </div>
            <div class="feet_wrap">
                <p class="feet"><span></span>평<b>(밭 하나당 3평)</b></p>
            </div>
        </div>

        <div>
            <h3>추가 옵션</h3>
            <div class="option">
                <div class="checkbox_wrap">
                    <label for="op1">
                        <input class="checkbox-input" type="checkbox" name="option" value="seeding" id="op1">
                        <span class="tit">
                            <i class="fa-solid fa-seedling"></i>
                            <span class="txt">모종제공</span>
                        </span>
                    </label>
                </div>
                <div class="checkbox_wrap">
                    <label for="op2">
                        <input class="checkbox-input" type="checkbox" name="option" value="plow" id="op2">
                        <span class="tit">
                            <i class="fa-solid fa-tractor"></i>
                            <span class="txt">밭갈기</span>
                        </span>
                    </label>
                </div>
                <div class="checkbox_wrap">
                    <label for="op3">
                        <input class="checkbox-input" type="checkbox" name="option" value="watering" id="op3">
                        <span class="tit">
                            <i class="fa-solid fa-droplet"></i>
                            <span class="txt">물주기</span>
                        </span>
                    </label>
                </div>
                <div class="checkbox_wrap">
                    <label for="op4">
                        <input class="checkbox-input" type="checkbox" name="option" value="compost" id="op4">
                        <span class="tit">
                            <i class="fa-solid fa-sack-xmark"></i>
                            <span class="txt">퇴비뿌리기</span>
                        </span>
                    </label>
                </div>
            </div>
        </div>

        <div>
            <h3>예약정보</h3>
            <div class="info_wrap">
                <ul>
                    <li>
                        <h4>농장이름</h4>
                        <p class="rv_farmName">${listDetail.wfSubject}</p>
                    </li>
                    <li>
                        <h4>분양 기간</h4>
                        <p class="rs_year"></p>
                    </li>
                    <li>
                        <h4>분양할 평수</h4>
                        <p class="rs_feet"></p>
                    </li>
                    <li>
                        <h4>추가 옵션</h4>
                        <p class="rs_option"></p>
                    </li>
                    <li>
                        <h4>금액</h4>
                        <p class="rs_total_price"></p>
                    </li>
                </ul>
            </div>
        </div>
        <input type="hidden" id="reYear">
        <input type="hidden" id="reFeet">
        <input type="hidden" id="price" value="${listDetail.wfPrice}">
        <input type="hidden" id="option_price" value="${listDetail.wfOptionPrice}">

        <button type="button" class="booking_btn">등록</button>
    </div>
</div>