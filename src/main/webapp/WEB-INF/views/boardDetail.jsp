<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-01-17
  Time: 오후 5:15
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../include/header.jsp" %>

<div class="wrap con">
    <%@include file="../include/board_search.jsp" %>
    <div class="board_con board_view">
        <div class="board_tb">
            <div class="board_view_tt">${board.boardSubject}</div>
            <div class="board_view_top flex">
                <div class="board_view_writer">
                    작성자 : 관리자
                </div>
                <div class="board_view_date">
                    <span>
                       조회수 : <span class="count">${board.boardCount}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </span>
                    <span>
                        <fmt:parseDate value="${board.boardDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both"/>
                        <fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}"/>
                    </span>
                </div>
            </div>
            <div class="board_view_con">${board.boardContent}</div>
        </div>
    </div>
    <div class="board_btn">
        <a href="/board">목록</a>
    </div>
</div>
<%@include file="../include/footer.jsp" %>