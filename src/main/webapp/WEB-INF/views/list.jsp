<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="con wrap list-wrap">
    <div class="container">
        <h3>지역 선택</h3>
        <%-- 농장 필터 --%>
        <div class="filter">
            <input type="hidden" id="farm_select" name="farm_select">
            <ul class="swiper-wrapper">
                <c:forEach items="${localArray}" var="localArray" varStatus="idx">
                    <li class="swiper-slide <c:if test="${param.local eq localArray}">on</c:if>">
                        <a href="javascript:void(0);">${localArray}</a>
                       <%-- <a href="/list?local=${localArray}">${localArray}</a>--%>
                    </li>
                </c:forEach>
                <li class="selector"></li>
            </ul>
            <div class="filter-button-prev"><i class="fa-solid fa-angle-left"></i></div>
            <div class="filter-button-next"><i class="fa-solid fa-angle-right"></i></div>
        </div>
        <%-- 농장 목록 --%>
        <div class="farm-list">
            <ul>
                <c:choose>
                    <c:when test="${farms ne null}">
                        <c:forEach var="farm" items="${farms}" varStatus="status">
                            <%--<c:forEach items="${farms}" var="farm">--%>
                            <li>
                                <a href="/listDetail?id=${farm.wfIdx}">
                                    <div class="view">
                                        <div class="view-img">
                                            <img src="${farm.wfImgUrl1}">
                                        </div>
                                    </div>
                                    <div class="desc">
                                        <div class="left">
                                            <p class="title">${farm.wfSubject}</p>
                                            <span class="theme">${farm.wfTheme}</span>
                                        </div>
                                        <div class="right">
                                            <i class="fa-solid fa-star"></i>
                                            <span class="score">${farm.wfRating}</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="empty_li">자료가 없습니다.</li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="pagination">
                <c:set value="${empty param.local ? '전체' : param.local}" var="local"/>
                <!-- 이전페이지 -->
                <c:choose>
                    <c:when test="${pageNumber > 1}">
                        <a href="list?local=${local}&page=1"><i class="fa-solid fa-angles-left"></i></a>
                        <a href="list?local=${local}&page=${nowPage}"><i class="fa-solid fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angles-left"></i></a>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angle-left"></i></a>
                    </c:otherwise>
                </c:choose>

                <!-- pagination -->
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <a class="<c:if test='${param.page eq null ? i eq 1 : param.page eq i}'>on</c:if>" href="list?local=${local}&page=${i}"><strong>${i}</strong></a>
                </c:forEach>

                <!-- 다음페이지 -->
                <c:choose>
                    <c:when test="${pageNumber < totalPages}">
                        <a href="list?local=${local}&page=${nowPage + 2}"><i class="fa-solid fa-angle-right"></i></a>
                        <a href="list?local=${local}&page=${totalPages}"><i class="fa-solid fa-angles-right"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angle-right"></i></a>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angles-right"></i></a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<script>
    // /* map영역 */
    // var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    //     mapOption = {
    //         center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    //         level: 3 // 지도의 확대 레벨
    //     };
    //
    // // 지도를 표시할 div와  지도 옵션으로  지도를 생성
    // var map = new kakao.maps.Map(mapContainer, mapOption);

    /* swiper */
    var swiper = new Swiper(".filter", {
        slidesPerView: 9,
        spaceBetween: 0,
        navigation: {
            nextEl: ".filter-button-next",
            prevEl: ".filter-button-prev",
        },
    });
    if($(".swiper-slide").hasClass("on") === true) {
        let target = $(".swiper-slide.on");
        muCenter(target);
        $(".selector").css("left",(target.position().left) + 20);
        console.log("left"+target.position().left);
    }else {
        $(".swiper-slide").eq(0).addClass("on");
    }


    /***셋타임아웃사용***/
    document.addEventListener("DOMContentLoaded", function () {
        let tabs = document.querySelectorAll(".filter ul li a");
        let selector = document.querySelector(".selector");

        /*if (tabs.length > 0) {
            tabs.forEach(tab => tab.classList.remove("on"));
            tabs[0].classList.add("on");
            filter({currentTarget: tabs[0]});
        }*/
        tabs.forEach(tab => {
            tab.addEventListener("click", filter);
        });

        function filter(event) {

            // 클릭 이벤트가 발생한 경우, "on" 클래스를 관리합니다.
            tabs.forEach(tab => tab.closest("li").classList.remove("on"));
            let label = event.currentTarget;
            label.closest("li").classList.add("on");

            // 선택 표시기의 위치와 크기를 조정합니다.
            let selectorHeight = selector.offsetHeight;
            selector.style.left = label.offsetLeft + "px";
            selector.style.width = label.offsetWidth + "px";
            /*selector.style.top = (label.offsetTop + label.offsetHeight - selectorHeight / 2) + "px";*/

            setTimeout(function(){
                if(label.innerText !== "전체") {
                    window.location.href="/list?local="+label.innerText;
                }
            },200);
            console.log(label.innerText);
            console.log(label.offsetLeft , selector.offsetLeft);
            if(label.innerText !== "전체" && label.offsetLeft === selector.left) {
                window.location.href="/list?local="+label.innerText;
            }

        }
    });

    function muCenter(target){
        var snbwrap = $('.filter .swiper-wrapper');
        var targetPos = target.position();
        var box = $('.filter');
        var boxHarf = box.width()/2;
        var pos;
        var listWidth=0;

        snbwrap.find('.swiper-slide').each(function(){ listWidth += $(this).outerWidth(); })

        var selectTargetPos = targetPos.left + target.outerWidth()/2;
        if (selectTargetPos <= boxHarf) { // left
            pos = 0;
        }else if ((listWidth - selectTargetPos) <= boxHarf) {     //right
            pos = listWidth-box.width();
        }else {
            pos = selectTargetPos - boxHarf;
        }

        setTimeout(function(){snbwrap.css({
            "transform": "translate3d("+ (pos*-1) +"px, 0, 0)",
            "transition-duration": "500ms"
        })}, 200);
    }

</script>

<%@include file="../include/footer.jsp" %>
