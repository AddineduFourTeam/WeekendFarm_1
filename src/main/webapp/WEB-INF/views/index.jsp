<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<div class="mainImg">
    <img src="/img/mainimg.jpg"  alt="초원에 집에 있는 메인 이미지"> <!--class="wow fadeIn" data-wow-delay="0.2s"-->
    <div class="mainBannerTxt wow fadeInUp" data-wow-delay="0.3s">
        <span>도시를 떠나 힐링의 시간</span>
        <div><b>주말농장</b>에서 마음의 평화와 </div>
        <div>자연 속 즐거움을 만나다.</div>
    </div>
</div>
<div class="con">
    <div class="maincon01 section">
        <div class="wrap">
            <div class="contt">
                <h4>지역별 농장 리스트</h4>
                <p>여러분들의 주말을 책임질 힐링 농장을 지역별로 만나보세요!</p>
            </div>
            <div class="main_localList">
                <ul>
                    <li class="main_slideitem seoul"><a href="/list?local=서울">
                        <img src="/img/seoul02.jpg" alt="seoul">
                        <div>
                            <span>seoul</span>
                            <span>서울</span>
                        </div>

                    </a></li>
                    <li class="main_slideitem busan"><a href="/list?local=부산">
                        <img src="/img/busan.jpg" alt="busan">
                        <div>
                            <span>busan</span>
                            <span>부산</span>
                        </div>
                    </a></li>
                    <li class="main_slideitem gangwon"><a href="/list?local=강원">
                        <img src="/img/gangwon02.jpg" alt="강원">
                        <div>
                            <span>gangwon</span>
                            <span>강원</span>
                        </div>
                    </a></li>
                    <li class="main_slideitem gyeonggi"><a href="/list?local=경기">
                        <img src="/img/gyeonggi.png" alt="경기">
                        <div>
                            <span>gyeonggi</span>
                            <span>경기</span>
                        </div>
                    </a></li>
                    <li class="main_slideitem chungcheong"><a href="/list?local=충청">
                        <img src="/img/chungcheong.jpg" alt="충청">
                        <div>
                            <span>chungcheong</span>
                            <span>충청</span>
                        </div>
                    </a></li>
                    <li class="main_slideitem jeolla"><a href="/list?local=전라">
                        <img src="/img/jeolla02.jpg" alt="전라">
                        <div>
                            <span>jeolla</span>
                            <span>전라</span>
                        </div>
                    </a></li>
                    <li class="main_slideitem gyeongsang"><a href="/list?local=경상">
                        <img src="/img/gyeongsang.png" alt="경상">
                        <div>
                            <span>gyeongsang</span>
                            <span>경상</span>
                        </div>
                    </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="maincon02 section">
        <div class="wrap">
            <div class="contt">
                <h4>나의 농장 스토리</h4>
            </div>
            <div class="mainstory">
                <div class="main_story_slide">
                    <c:forEach var="story" items="${list}" varStatus="i">
                    <div class="ms_slide_items">
                        <a href="/storyDetail?sno=${story.storyIdx}">
                            <img src="image/${story.storyIdx}/1" alt="${story.storySubject}">
                            <div class="mainstory_txt">
                                <b>${story.storySubject}</b>
                                <p>${story.storyContent}</p>
                            </div>
                        </a>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div class="maincon03 section">
        <div class="wrap">
            <div class="contt">
                <h4 class="wow fadeInUp" data-wow-delay="0.3s">도시 속 작은 농장, 당신의 주말을 초록으로 채워드립니다.</h4>
                <div class="wow fadeInUp" data-wow-delay="0.5s">
                    Weekend Farm은 바쁜 일상 속에서 자연과 연결하는 기회를 제공합니다. <p>직접 농사를 지어 신선한 식탁을 경험 하고 , 일상의 스트레스를 해소할 수 있습니다.</p></div>
                <div class="wow fadeInUp" data-wow-delay="0.5s">단순한 농작물 재배를 넘어, 도시인에게 자연을 통한 힐링과 가족 간의 소중한 추억을 만들어가는 장소로,
                    <p>주말마다 삶에 풍성한 자연의 색감과 생명력을 더하는 재충전의 시간을 가져보세요.</p></div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
        $(window).scroll(function(){
            if($(window).scrollTop() >= $(".maincon01").offset().top - 300) {
                let count = 0;
                let width = 250;
                $(".main_localList li").each(function () {

                    if ($(this).index() === 4) {
                        $(this).css({"top": width, "left": "15%"});
                    } else if ($(this).index() === 5) {
                        $(this).css({"top": width, "left": "calc(15% + " + width + "px)"});
                    } else if ($(this).index() === 6) {
                        $(this).css({"top": width, "left": "calc(15% + " + 2 * width + "px)"});
                    } else {
                        $(this).css("left", count);
                        count += width;
                    }
                });
            }
            /*$(".section").each(function(){
                if($(window).scrollTop() >= $(this).offset().top - 300) {
                    $(this).addClass("active").siblings().removeClass("active");
                }
            });*/
        });
    });
</script>
<%@include file="../include/footer.jsp" %>

