<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${not empty param.id}">
        <c:set var="modifiedParam" value="id=${param.id}"/>
        <c:set var="modifiedParam" value="${fn:replace(modifiedParam, '{', '')}"/>
        <c:set var="modifiedParam" value="${fn:replace(modifiedParam, '}', '')}&amp;"/>
    </c:when>
    <c:otherwise>
        <c:set var="modifiedParam" value=""/>
    </c:otherwise>
</c:choose>
<!-- 페이징 영역 시작 -->
<div class="paging">
    <ul class="pagination justify-content-center">
        <!-- 이전 -->
        <li class="page-item"><a class="page-link" href="/${folderName}?${modifiedParam}page=1"><i class="fa-solid fa-angles-left"></i></a></li>
        <li class="page-item"><a class="page-link" href="/${folderName}?${modifiedParam}page=${pageNumber - 1 < 1 ? 1 : pageNumber - 1}"><i class="fa-solid fa-chevron-left"></i></a></li>

        <!-- 페이지 그룹 -->
        <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
            <c:choose>
                <c:when test="${pageNumber + 1 == i}">
                    <li class="page-item disabled ${param.page eq i ? 'on' : '' }"><a class="page-link" href="/${folderName}?${modifiedParam}page=${i}">${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li class="page-item ${param.page eq i or empty param.page ? 'on' : '' }"><a class="page-link" href="/${folderName}?${modifiedParam}page=${i}">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${endBlockPage < 1}">
            <li class="page-item disabled on"><a class="page-link" href="/${folderName}${fn:replace(fn:replace(param, '{', ''), '}', '')}">1</a></li>
        </c:if>

        <!-- 다음 -->
        <c:choose>
            <c:when test="pageNumber == totalPages ">
                <li class="page-item "><a class="page-link" href="/${folderName}?${modifiedParam}page=${pageNumber}"><i class="fa-solid fa-angle-right"></i></a></li>
            </c:when>
            <c:otherwise>
                <li class="page-item "><a class="page-link" href="/${folderName}?${modifiedParam}page=${pageNumber+1}"><i class="fa-solid fa-angle-right"></i></a></li>
            </c:otherwise>
        </c:choose>
        <li class="page-item "><a class="page-link" href="/${folderName}?${modifiedParam}page=${totalPages}"><i class="fa-solid fa-angles-right"></i></a></li>
    </ul>
    <%--<div class="paging">
        <ul>
            <li><a href=""><i class="fa-solid fa-angles-left"></i></a></li>
            <li><a href="">1</a></li>
            <li><a href=""><i class="fa-solid fa-angles-right"></i></a></li>
        </ul>
    </div>--%>
</div>
<!-- 페이징 영역 끝 -->