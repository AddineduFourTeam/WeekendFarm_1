<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-01-26
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${fn:contains(folderName, 'board')}">
    <c:set var="action" value="boardSearch" />
</c:if>
<c:if test="${fn:contains(folderName, 'story')}">
    <c:set var="action" value="storySearch"/>
</c:if>
<div class="boarder_top">
    <h2>
        <c:if test="${fn:contains(folderName, 'board')}">
            고객센터
        </c:if>
        <c:if test="${fn:contains(folderName, 'story')}">
            농장 스토리
        </c:if>
    </h2>
    <div class="search">
        <form action="${action}">
            <select name="type" id="type">
                <option value="title" <c:if test="${param.type eq 'title'}">selected</c:if>>제목</option>
                <option value="content" <c:if test="${param.type eq 'content'}">selected</c:if>>내용</option>
                <option value="user" <c:if test="${param.type eq 'user'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" name="keyword" id="keyword" value="${param.keyword}">
            <button type="submit">검색</button>
        </form>
    </div>
</div>
