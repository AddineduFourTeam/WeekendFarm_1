<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현재 페이지명 가져오기 -->
<c:set var="URI" value="${pageContext.request.requestURI}"/>
<c:set var="basePath" value="/WEB-INF/views/"/>
<c:set var="folderPath" value="${fn:substringAfter(URI, basePath)}"/>
<c:set var="folderName" value="${fn:substringBefore(folderPath, '.jsp')}"/>
<!-- 지역명 뿌리기 -->
<c:set var="localArray">전체,서울,경기,인천,강원,제주,대전,충북,충남/세종,부산,울산,경남,대구,경북,광주,전남,전주/전북</c:set>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <link href="img/favicon.png" rel="icon">
    <title>주말 농장 - ${folderName}</title>

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

    <link rel="stylesheet" href="/css/animate.css">
    <link rel="stylesheet" href="/css/style.css">

    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="https://kit.fontawesome.com/256c666685.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=437827de1a7ca4ddf726ffe0bca1c156"></script>
</head>

<body class="<c:if test="${folderName eq 'index' || folderName eq 'login'}">index_body</c:if>
             <c:if test="${folderName eq 'list'}">list_body</c:if>
             <c:if test="${folderName eq 'login'}">auth_body</c:if>">

<header class="<c:if test="${folderName eq 'listDetail'}">listDetail_header</c:if>">
    <c:choose>
        <c:when test="${loginUser != null}">
            <ul class="tnb wrap">
                <li><span><img src="${loginUser.memImg}" onerror="this.src='img/profileImg_w.png'"></span></li>
                <li><b>${loginUser.memid}</b>님 환영</li>
                <li><a href="logout">로그아웃</a></li>
                <li><a href="myPage">마이페이지</a></li>
            </ul>
        </c:when>
        <c:otherwise>
            <ul class="tnb wrap">
                <li><a href="/login">로그인</a></li>
                <li><a href="/join">회원가입</a></li>
            </ul>
        </c:otherwise>
    </c:choose>
    <nav>
        <div class="wrap">
            <h1>
                <a href="/">
                    <c:choose>
                        <c:when test="folderName ne 'index'">
                            <img src="/img/logo_w.png" alt="weekend farm" onerror="this.src='/img/logo_w.png'">
                        </c:when>
                        <c:otherwise>
                            <img src="/img/logo.png" alt="weekend farm" onerror="this.src='/img/logo.png'">
                        </c:otherwise>
                    </c:choose>
                </a>
            </h1>
            <form action="/search" name="search-form" class="search-form" method="get">
                <select name="select" id="select" class="list-select">
                    <option value="location" <c:if test="param.select eq 'location'">selected</c:if>>지역명</option>
                    <option value="title" <c:if test="param.select eq 'title'">selected</c:if>>농장명</option>
                    <option value="theme" <c:if test="param.select eq 'theme'">selected</c:if>>테마</option>
                </select>
                <input type="search" name="keyword" id="search" class="list-search" placeholder="검색해주세요"
                       autocomplete="on" value="<c:out value='${param.keyword}'/>">
                <button><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
            <ul class="gnb">
                <li <c:if test="${fn:contains(folderName, 'list')}">class="on"</c:if>><a href="/list">주말농장</a></li>
                <li <c:if test="${fn:contains(folderName, 'board')}">class="on"</c:if>><a href="/board">공지사항</a></li>
                <li <c:if test="${fn:contains(folderName, 'story')}">class="on"</c:if>><a href="/story">농장 스토리</a></li>
            </ul>
        </div>
    </nav>
</header>


