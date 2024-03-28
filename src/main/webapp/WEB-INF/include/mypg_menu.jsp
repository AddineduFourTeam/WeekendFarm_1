<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="boarder_top">
    <h2>
        마이페이지
        <c:if test="${fn:contains(folderName, 'myPage')}">
            - 홈
        </c:if>
        <c:if test="${fn:contains(folderName, 'updatePass')}">
            - 비밀번호 변경
        </c:if>
        <c:if test="${fn:contains(folderName, 'updateMyInfo')}">
            - 회원정보 변경
        </c:if>
        <c:if test="${fn:contains(folderName, 'mypgStory')}">
        - 내 스토리
        </c:if>
        <c:if test="${fn:contains(folderName, 'mypgReview')}">
        - 내 리뷰
        </c:if>
        <c:if test="${fn:contains(folderName, 'mypageReservation')}">
            - 농장 예약 내역
        </c:if>
    </h2>
</div>
<div class="my-full-wrap">
    <div class="my-tap-wrap">
        <div class="my-tap">
            <ul>
                <li class="<c:if test="${folderName eq 'myPage'}">on</c:if>">
                    <a href="myPage">
                        홈
                    </a>
                </li>
                <li class="<c:if test="${folderName eq 'mypageReservation'}">on</c:if>">
                    <a href="mypageReservation">
                        예약내역
                    </a>
                </li>
                <li class="<c:if test="${fn:contains(folderName, 'mypgReview')}">on</c:if>">
                    <a href="mypgReview">
                        리뷰내역
                    </a>
                </li>
                <li class="<c:if test="${folderName eq 'mypgStory'}">on</c:if>">
                    <a href="mypgStory">
                        내 스토리
                    </a>
                </li>
                <li class="<c:if test="${folderName eq 'updateMyInfo'}">on</c:if>">
                    <a href="updateMyInfo">
                        회원정보변경
                    </a>
                </li>
                <li class="<c:if test="${folderName eq 'updatePass'}">on</c:if>">
                    <a href="updatePass">
                        비밀번호변경
                    </a>
                </li>
                <li class="<c:if test="${folderName eq 'cancelAccount'}">on</c:if>">
                    <a href="cancelAccount">
                        회원탈퇴
                    </a>
                </li>
            </ul>
        </div>