<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<div class="wrap con">
    <%@include file="../include/board_search.jsp" %>
    <c:if test="${not empty list}">
    <div class="story_list">
            <c:forEach var="list" items="${list}" varStatus="status">
                <div class="story_items">
                    <div class="story_content">
                        <div class="story_tt">
                           <span><img src="${list.storyMemImg}" alt="${list.storyMemId} profile" onerror="this.src='img/profileImg_w.png'"></span>
                            <b>${list.storyMemId}</b>
                        </div>
                        <a href="/storyDetail?id=${list.storyIdx}">
                            <div class="story_img">
                                <img src="/image/${list.storyIdx}/1" alt="Image" onerror="this.src='img/logoimg.png'">
                            </div>
                        </a>
                        <div class="story_txt">
                            <div class="story_subject"><a
                                    href="/storyDetail?id=${list.storyIdx}">${list.storySubject}</a></div>
                            <div class="story_content_ele ellipsis">${list.storyContent}</div>
                            <div class="story_tag">
                                    ${list.storyTag}
                            </div>
                            <div class="story_date">
                                 <%--${list.storyDate}--%>
                                     <fmt:parseDate value="${list.storyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                     <fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}" />
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
    </div>
    </c:if>
    <c:if test="${empty list}">
        <!-- list 데이터가 없을 때 수행할 작업 -->
        <div class="notable">
            <span>자료가 없습니다.</span>
        </div>
    </c:if>
    <c:choose>
        <c:when test="${not empty loginUser}">
            <c:set value="/storyWrite" var="storybtn" />
            <c:set value="" var="onClickScript" />
        </c:when>
        <c:otherwise>
            <c:set value="javascript:void(0);" var="storybtn" />
            <c:set value="로그인 후 이용가능합니다." var="alertMessage" />
            <c:set value="/login" var="redirectURL" />
            <c:set value="alert('${alertMessage}'); location.href='${redirectURL}';" var="onClickScript" />
        </c:otherwise>
    </c:choose>

    <div class="storybtn">
        <a href="${storybtn}" class="btn" onclick="${onClickScript}">스토리 올리기</a>
        <span class="btnimg"><img src="/img/sprout.png" alt="새싹"></span>
    </div>
    <%@include file="../include/paging.jsp" %>
</div>
<%@include file="../include/footer.jsp" %>