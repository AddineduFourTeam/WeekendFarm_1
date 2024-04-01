<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<%--<c:if test="${empty loginUser}">
    <script>
        alert("로그인 후 작성 가능합 니다.");
        location.href="/login";
    </script>
</c:if>--%>
<div class="wrap con">
    <%@include file="../include/mypg_menu.jsp" %>
        <div class="my-wrap">
            <div class="story_con review_con">
            <form action="<c:out value="${not empty param.id ? 'reviewUpdate' : 'reviewForm'}"/>" method="post" enctype="multipart/form-data">
                <input type="hidden" id="reviewRvIdx" name="reviewRvIdx" value="${param.rno}">
                <input type="hidden" id="id" name="id" value="${param.id}">
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

                <div class="storyW_star">
                    <label for="title" class="story_listtt">리뷰 평점</label>
                    <div class="storyW_con">
                        <input type="hidden" value="5" id="reviewCount" name="reviewCount">
                       <ul class="star_list">
                           <c:forEach begin="1" end="5">
                           <li class="active"><i class="fa-solid fa-star"></i></li>
                           </c:forEach>
                       </ul>
                        <div class="star_text"> (<span class="star_txt">${review.reviewCount ne null ? review.reviewCount : 5}</span>/5)</div>
                    </div>
                </div>

                <div class="storyW_tt">
                    <label for="title" class="story_listtt">리뷰 제목</label>
                    <input type="text" id="title" name="reviewSubject" value="${review.reviewSubject}" required>
                </div>
                <div class="story_txt">
                    <label for="content" class="story_listtt">리뷰 내용</label>
                    <textarea id="content" name="reviewContent" required><c:out value="${fn:replace(review.reviewContent, '<br>', '&lt;br&gt;')}" escapeXml="false" /></textarea>
                </div>
                <div class="farm_img">
                    <div class="story_listtt">
                        리뷰 이미지
                    </div>
                    <ul>
                        <li class="farm_img1">
                            <input id="fileInput" type="file" multiple name="file1" value="${review.reviewImg1}" hidden/>
                            <label for="fileInput">
                                <c:choose>
                                    <c:when test="${review.reviewImg1 ne null}">
                                        <img src="${review.reviewImg1}" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        이미지 선택<span>(썸네일 이미지)</span><small>10mb 이하</small>
                                    </c:otherwise>
                                </c:choose>
                            </label>
                        </li>
                        <li class="farm_img2" <c:if test="${review.reviewImg2 ne null}">style="display:block"</c:if>>
                            <input id="fileInput2" type="file" value="${review.reviewImg2}" multiple name="file2" hidden/>
                            <label for="fileInput2">
                                <c:choose>
                                    <c:when test="${review.reviewImg2 ne null}">
                                        <img src="${review.reviewImg2}" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        이미지 선택<span>(썸네일 이미지)</span><small>10mb 이하</small>
                                    </c:otherwise>
                                </c:choose>
                            </label>
                        </li>
                        <li class="farm_img3" <c:if test="${review.reviewImg3 ne null}">style="display:block"</c:if>>
                            <input id="fileInput3" type="file" multiple name="file3" value="${review.reviewImg3}" hidden/>
                            <label for="fileInput3">
                                <c:choose>
                                    <c:when test="${review.reviewImg3 ne null}">
                                        <img src="${review.reviewImg3}" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        이미지 선택<span>(썸네일 이미지)</span><small>10mb 이하</small>
                                    </c:otherwise>
                                </c:choose>
                            </label>
                        </li>
                    </ul>
                </div>

                <div class="story_submit">
                    <button><c:out value="${not empty param.id ? '수정' : '등록'}"/></button>
                    <span class="btnimg"><img src="/img/sprout.png" alt="새싹"></span>
                </div>
            </form>
        </div>
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $(".farm_img li input").change(function () {
            $(this).parents("li").next("li").show();
            readURL(this);
        });

        $('.star_list li').click(function() {
            $(this).parent().children('li').removeClass('active');
            $(this).parent().children('li').find("i").attr("class","fa-regular fa-star");
            $(this).addClass('active').prevAll('li').addClass('active');
            $(this).addClass('active').find("i").attr("class","fa-solid fa-star");
            $(this).prevAll('li').find("i").attr("class","fa-solid fa-star");
            var star_len = $(".star_list").find("li.active").length;
            $(".star_text").find(".star_txt").text(star_len);
            $("#reviewCount").val($(this).index()+1);
        });
        <c:if test="${review.reviewCount ne null}">
        for(let i = 0; i < ${review.reviewCount} ; i++) {
            $(".star_list li").eq(i).addClass("active").siblings("li").removeClass("active");
        }
        </c:if>

    });


    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                console.log(input);
                $(input).next("label").html(`<img src='${"${e.target.result}"}'>`);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

</script>
<%@include file="../include/footer.jsp" %>