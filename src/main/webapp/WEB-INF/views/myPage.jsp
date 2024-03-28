<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<c:if test="${empty loginUser}">
    <script>
        alert("로그인 후 작성 가능합 니다.");
        location.href = "/login";
    </script>
</c:if>
<div class="con wrap">
    <%@include file="../include/mypg_menu.jsp" %>
    <div class="my-wrap">
        <ul class="my-info-wrap">
            <li class="file-top my-img">
                <span>
                    <img src="${loginUser.memImg}" onerror="this.src='img/profileImg_w.png'">
                </span>
            </li>
            <li class="my-info">
                <div>
                    <b>이름</b>
                    <div>${loginUser.name}</div>
                </div>
                <div>
                    <b>생년월일</b>
                    <div>${loginUser.birth}</div>
                </div>
                <div>
                    <b>이메일</b>
                    <div>${loginUser.email}</div>
                </div>
                <div>
                    <a href="updateMyInfo">회원정보수정</a>
                </div>
            </li>
        </ul>
        <div class="my-resv-wrap board_con">
            <div class="mypg_tt">
                <h3>최근 예약내역</h3>
                <a href="/mypageReservation">더보기 <i class="xi-angle-right-min"></i></a>
            </div>
            <table>
                <thead>
                <tr>
                    <th>No</th>
                    <th>예약한 농장</th>
                    <th>예약기간</th>
                    <th>예약날짜</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty reservations}">
                        <c:forEach var="resv" items="${reservations}" varStatus="i">
                            <c:set var="nowNum" value="${fn:length(reservations)}"/>
                            <fmt:parseDate value="${resv.rvDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime"
                                           type="both"/>
                            <tr>
                                <td>${nowNum - i.index}</td>
                                <td><a href="mypageReservation?id=${resv.rvIdx}">${wfSubjectlist[i.index]}</a></td>
                                <td>${resv.rvUseDate}년</td>
                                <td><fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">자료가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="my-review-wrap board_con">
            <div class="mypg_tt">
                <h3>최근 리뷰</h3>
                <a href="/mypgReview">더보기 <i class="xi-angle-right-min"></i></a>
            </div>
            <table>
                <thead>
                <tr>
                    <th>No</th>
                    <th>방문한 농장</th>
                    <th>제목</th>
                    <th>리뷰작성일자</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <c:set var="nowNum" value="${fn:length(reviews)}"/>
                        <c:forEach var="review" items="${reviews}" varStatus="i">
                            <fmt:parseDate value="${review.reviewDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime"
                                           type="both"/>
                            <tr>
                                <td>${nowNum - i.index}</td>
                                <td>${reviewWfSubjectlist[i.index]}</td>
                                <td><a href="mypgReviewDetail?id=${review.reviewIdx}"
                                       class="ellipsis">${review.reviewSubject}</a></td>
                                <td><fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4">자료가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="my-story-wrap">
            <div class="mypg_tt">
                <h3>스토리</h3>
                <a href="/mypgStory">더보기<i class="xi-angle-right-min"></i></a>
            </div>
            <div class="story_wrap">
                <c:choose>
                    <c:when test="${not empty stories}">
                        <c:forEach var="story" items="${stories}" varStatus="i">
                            <fmt:parseDate value="${story.storyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime"
                                           type="both"/>
                            <div class="story_items">
                                <a href="/storyDetail?id=${story.storyIdx}">
                                    <div class="story_img">
                                        <img src="/image/${story.storyIdx}/1" alt="Image"
                                             onerror="this.src='img/logoimg.png'">
                                    </div>
                                    <div class="my-story_subject">
                                            ${story.storySubject}
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty">자료가 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<%@include file="../include/footer.jsp" %>