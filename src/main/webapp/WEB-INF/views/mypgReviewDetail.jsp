<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="wrap con">
    <%@include file="../include/mypg_menu.jsp" %>
    <div class="my-wrap">
        <div class="board_con board_view">
            <div class="board_tb">
                <div class="board_view_tt">${review.reviewSubject}</div>
                <div class="board_view_top flex">
                    <div class="board_view_writer">
                        <span><img src="${loginUser.memImg}" alt=""
                                   onerror="this.src='img/profileImg.png'"></span>${loginUser.memid}
                    </div>
                    <div class="board_view_date">
                        <span>
                            <c:forEach begin="1" end="${review.reviewCount}">
                                <span class="active"><i class="fa-solid fa-star"></i></span>
                            </c:forEach>
                           (별점 : <span class="count">${review.reviewCount}</span>) &nbsp;&nbsp;|&nbsp;&nbsp;
                        </span>
                        <span>
                            <fmt:parseDate value="${review.reviewDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />
                            <fmt:formatDate pattern="yyyy.MM.dd H:mm" value="${parsedDateTime}"/>
                        </span>
                    </div>
                </div>
                <div class="board_view_con">
                    <div class="story_farm">
                        <div class="story_listtt">예약 내역</div>
                        <div class="review_con review_txt_con">
                            <div class="review_farm_con">
                                <div class="review_farm_img">
                                    <div class="farmImg"><img src="${reviewFarm.wfImgUrl1}" alt="" onerror="this.src='/img/placeholder.png'"></div>
                                </div>
                                <div class="review_farm_text">
                                    <ul>
                                        <li>
                                            <span>농장명</span>
                                            <b class="color">${reviewFarm.wfSubject}</b>
                                        </li>
                                        <%--<li>
                                            <span>농장 주소</span>
                                            <b>${reviewFarm.wfAddr}</b>
                                        </li>--%>
                                        <li>
                                            <span>예약 기한</span>
                                            <b>${reviewReservation.rvUseDate}년</b>
                                        </li>
                                        <li>
                                            <span>예약 평수</span>
                                            <b>${reviewReservation.rvFeet}평</b>
                                        </li>
                                        <li>
                                            <span>예약 옵션</span>
                                            <b>
                                                <c:if test="${reviewReservation.rvOptionSeeding.toString() eq 'Y'}">모종 제공 <span>,</span></c:if>
                                                <c:if test="${reviewReservation.rvOptionPlow.toString() eq 'Y'}">밭갈기 <span>,</span></c:if>
                                                <c:if test="${reviewReservation.rvOptionWatering.toString() eq 'Y'}">물주기 <span>,</span></c:if>
                                                <c:if test="[${reviewReservation.rvOptionCompost.toString() eq 'Y'}">퇴비뿌리기 <span>,</span></c:if>
                                                <c:set var="options" value="[${reviewReservation.rvOptionSeeding.toString()}, ${reviewReservation.rvOptionPlow.toString()}, ${reviewReservation.rvOptionWatering.toString()}, ${reviewReservation.rvOptionCompost.toString()}]" />
                                                <c:if test="${options eq '[N, N, N, N]'}">
                                                    없음
                                                </c:if>
                                            </b>
                                        </li>
                                        <li>
                                            <span>예약 금액</span>
                                            <b><fmt:formatNumber value="${reviewReservation.rvPrice}" pattern="#,###" />원</b>
                                        </li>
                                        <li>
                                            <span>예약 상태</span>
                                            <b>
                                                <c:choose>
                                                    <c:when test="${reviewReservation.status.toString() eq 'Y'}">확정</c:when>
                                                    <c:otherwise>미확정</c:otherwise>
                                                </c:choose>
                                            </b>
                                        </li>
                                        <li>
                                            <span>예약일</span>
                                            <b>
                                                <fmt:parseDate value="${reviewReservation.rvDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />
                                                <fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}"/>
                                            </b>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty review.reviewImg1}">
                        <div class="story_detail_slide">
                            <button type="button" class="prev"><i class="fa-solid fa-angle-left" aria-hidden="true"></i>
                            </button>
                            <div class="story_detail_img review_detail_img">
                                <div class="story_detail_img_list review_detail_img_list">
                                    <c:if test="${not empty review.reviewImg1}">
                                        <img src="${review.reviewImg1}" alt="Image">
                                    </c:if>
                                </div>
                                <div class="story_detail_img_list review_detail_img_list">
                                    <c:if test="${not empty review.reviewImg2}">
                                        <img src="${review.reviewImg2}" alt="Image">
                                    </c:if>
                                </div>
                                <div class="story_detail_img_list review_detail_img_list">
                                    <c:if test="${not empty review.reviewImg3}">
                                        <img src="${review.reviewImg3}" alt="Image">
                                    </c:if>
                                </div>
                            </div>
                            <button type="button" class="next"><i class="fa-solid fa-angle-right" aria-hidden="true"></i>
                            </button>
                        </div>

                    </c:if>
                    <div class="story_detail_con">
                        <%--${fn:replace(review.reviewContent, '<br>', '\\n')}--%>
                        ${review.reviewContent}
                    </div>
                </div>
                <div class="board_btn">
                    <a href="/mypgReviewWrite?id=${review.reviewIdx}&rno=${review.reviewRvIdx}">수정</a>
                    <a href="javascript:myReviewDelete(${review.reviewIdx})" class="delete">삭제</a>
                    <a href="/mypgReview">목록</a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<c:set var="user" value="${loginUser ne null ? 'true' :'false' }"/>
<c:set var="user_idx" value="${loginUser.memIdx ne null ? loginUser.memIdx : '0'}"/>
<script>
    let is_user = ${user};

    $(document).ready(function(){
        let slideItemWidth = 0;
        let reviewSlideWidth = $(".review_detail_img").outerWidth();

        //이미지가 3개가 넘어가면 슬라이드
        $(".review_detail_img_list").each(function () {
            slideItemWidth += $(this).innerWidth();
        });
        if (reviewSlideWidth < slideItemWidth) {
            review_slick();
        }

    });


    //이미지 슬릭
    function review_slick() {
        //review slick
        $(".review_detail_img").slick({
            draggable: true,
            variableWidth: true,
            slidesToShow: 1,
            arrows: true,
            swipeToSlide: true,
            infinite: false,
            prevArrow: $('.prev'),
            nextArrow: $('.next'),
        });
    }

    $(document).on("click", ".emoji_btn", function (e) {
        const button = e.currentTarget;

        // 해당 버튼에 대한 처리
        const picker = new EmojiButton({
            i18n: {
                search: 'Search emojis...',
                categories: {
                    recents: 'Recent Emojis',
                    smileys: 'Smileys & Emotion',
                    people: 'People & Body',
                    animals: 'Animals & Nature',
                    food: 'Food & Drink',
                    activities: 'Activities',
                    travel: 'Travel & Places',
                    objects: 'Objects',
                    symbols: 'Symbols',
                    flags: 'Flags'
                },
                notFound: 'No emojis found'
            }
        });

        picker.on('emoji', emoji => {
            const associatedTextBoxId = button.dataset.targetTextbox;
            console.log(associatedTextBoxId);
            const text_box = $("#" + associatedTextBoxId);

            text_box.val(text_box.val() + emoji);
        });

        picker.togglePicker(button);
    });

    function myReviewDelete(id){
        if(confirm("게시물을 삭제 하시겠습까?")) {
            $.ajax({
                url: "/reviewDelete",
                data: {"id": id},
                type: "post",
                success: function (data) {
                    alert("삭제가 완료 되었습니다.");
                    window.location.href = "/mypgReview";
                }, error: function (xhr, status, error) {
                    console.log(xhr, status, error);
                }
            });
        }

    }


    //로그인여부 체크
    function is_login() {
        if(is_user === true) {
            return true;
        }else {
            alert("로그인 후 이용 가능합니다.");
            return false;
        }
    }
</script>
<%@include file="../include/footer.jsp" %>