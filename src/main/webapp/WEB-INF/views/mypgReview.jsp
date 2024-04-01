<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<c:if test="${empty loginUser}">
    <script>
        alert("로그인 후 작성 가능합 니다.");
        location.href="/login";
    </script>
</c:if>
<div class="con wrap">
    <%@include file="../include/mypg_menu.jsp" %>
            <div class="my-wrap board_con">
                <div class="board_tb">
                    <table>
                    <thead>
                        <tr>
                            <th>NO.</th>
                            <th>리뷰 제목</th>
                            <th>예약 목장</th>
                            <th>리뷰 등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty list}">
                        <%--${fn:length(list)}--%>
                        <c:set var="nowNum" value="${fn:length(list)}"/>
                        <c:forEach var="list" items="${list}" varStatus="status">
                            <fmt:parseDate value="${list.reviewDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />
                            <tr>
                            <td>${nowNum - status.index}</td>
                            <td><a href="mypgReviewDetail?id=${list.reviewIdx}"><b>${list.reviewSubject}</b></a></td>
                            <td class="tac">${reviewWfSubjectlist[status.index]}</td>
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}" /></td>
                        </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty list}">
                        <!-- list 데이터가 없을 때 수행할 작업 -->
                        <tr class="empty">
                            <td colspan="4">자료가 없습니다.</td>

                        </tr>
                    </c:if>
                    </tbody>
                    </table>
                </div>

                <div class="storybtn">
                    <a href="/mypageReservation" class="btn">예약내역 바로가기</a>
                    <span class="btnimg"><img src="/img/sprout.png" alt="새싹"></span>
                </div>
                <%@include file="../include/paging.jsp" %>
            </div>

        </div>

    </div>
</div>

<%@include file="../include/footer.jsp" %>