<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<div class="wrap con">
    <%@include file="../include/board_search.jsp" %>
    <div class="board_con">
        <div class="board_tb">
            <table>
                <tr>
                    <th>NO.</th>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
                <%--${board}--%>
                <%--<c:forEach var="board" items="${list}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td><a href="/boardDetail?bno=${board.boardIdx}">${board.boardSubject}</a></td>
                        <td><fmt:formatDate value="${board.boardDate}" pattern="yyyy-MM-dd" /></td>
                    </tr>
                </c:forEach>--%>
                <c:if test="${not empty list}">
                    <!-- board 데이터가 있을 때 수행할 작업 -->
                    <c:forEach var="board" items="${list}" varStatus="status">
                        <c:set var="nowNum" value="${fn:length(list)}"/>
                        <tr>
                            <td>${nowNum - status.index}</td>
                            <td><a href="/boardDetail?bno=${board.boardIdx}">${board.boardSubject}</a></td>
                            <td><fmt:formatDate value="${board.boardDate}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty list}">
                    <!-- board 데이터가 없을 때 수행할 작업 -->
                    <tr>
                        <td colspan="3">자료가 없습니다.</td>
                    </tr>
                </c:if>
            </table>
        </div>
        <%@include file="../include/paging.jsp" %>
    </div>
</div>
<%@include file="../include/footer.jsp" %>