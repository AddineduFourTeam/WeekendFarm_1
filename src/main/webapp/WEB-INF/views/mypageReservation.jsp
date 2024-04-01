<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="con wrap">
    <%@include file="../include/mypg_menu.jsp" %>
    <div class="my-wrap">
        <div class="info_wrap">
            <c:choose>
                <c:when test="${not empty reservations}">
                    <c:forEach var="resv" items="${reservations}" varStatus="i">
                        <%--                    <fmt:parseDate value="${resv.rvDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />--%>
                        <div class="rv_info">
                            <input type="hidden" id="wfidx" name="wfidx" value="">
                            <div class="info_list">
                                <div class="data">
                                    <p class="farm_name">${wfSubjects.get(i.index)}</p>
                                    <p class="date">${resv.rvDate}</p>
                                </div>
                                <div class="arrow_wrap">
                            <span class="arrow-top">
                                <i class="fa-solid fa-caret-down"></i>
                            </span>
                                </div>
                            </div>
                            <div class="info_con">
                                <div class="write">
                                    <c:choose>
                                        <c:when test="${hasReview}">
                                            <a href="/mypgReviewDetail?id=${resv.rvIdx}" class="review_btn">
                                                <i class="fa-solid fa-pen"></i>
                                                <span>후기보기</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/mypgReviewWrite?rno=${resv.rvIdx}" class="review_btn">
                                                <i class="fa-solid fa-pen"></i>
                                                <span>후기쓰기</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <ul>
                                    <li>
                                        <p class="tit">예약 여부</p>
                                        <div class="badge">
                                            <span>${resv.status.toString() eq "Y" ? "확정" : "미확정"}</span>
                                        </div>
                                    </li>
                                    <li>
                                        <p class="tit">이용 기간</p>
                                        <p class="txt">${resv.rvUseDate}년(${resv.rvUseYearDate})</p>
                                    </li>
                                    <li>
                                        <p class="tit">평 수</p>
                                        <p class="txt">${resv.rvFeet}평</p>
                                    </li>
                                    <li>
                                        <p class="tit">옵션</p>
                                        <div class="txt">
                                            <span class="option ${resv.rvOptionSeeding.toString() eq 'Y' ? 'color' : ''}">
                                                <i class="fa-solid fa-seedling"></i>
                                                <span>모종제공</span>
                                            </span>
                                            <span class="option ${resv.rvOptionPlow.toString() eq 'Y' ? 'color' : ''}">
                                                <i class="fa-solid fa-tractor"></i>
                                               <span>밭갈기</span>
                                            </span>
                                            <span class="option ${resv.rvOptionWatering.toString() eq 'Y' ? 'color' : ''}">
                                                <i class="fa-solid fa-droplet"></i>
                                                <span>물주기</span>
                                            </span>
                                            <span class="option ${resv.rvOptionCompost.toString() eq 'Y' ? 'color' : ''}">
                                                <i class="fa-solid fa-sack-xmark"></i>
                                                <span>퇴비뿌리기</span>
                                            </span>
                                        </div>
                                    </li>
                                    <li>
                                        <p class="tit">총 금액</p>
                                        <p class="txt price" id="revPrice"><fmt:formatNumber value="${resv.rvPrice}"
                                                                                             pattern="#,###"/>원</p>
                                    </li>
                                </ul>
                                <div class="btn_wrap">
                                    <a href="javascript:void(0)" class="update" data-wfidx="${resv.rvFarmIdx}"
                                       id="rvidx${resv.rvIdx}">예약 수정</a>
                                        <%--<a href="javascript:void(0)" onclick="showModal('reservation',this)" class="update" data-wfidx="${resv.rvFarmIdx}" data-rvIdx="${resv.rvIdx}">예약 수정</a>--%>
                                    <a href="#" class="del">예약 취소</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>
</div>
</div>
<%@include file="../include/modal.jsp" %>
<%@include file="../include/footer.jsp" %>
<script>


    $(document).ready(function () {

        /* 아코디언 리스트 */
        $(".info_list").click(function () {
            $(this).next(".info_con").stop().slideToggle(300);
            $(this).toggleClass('on').siblings().removeClass('on');
            $(this).next(".info_con").siblings(".info_con").slideDown(300);
        });

        $(".btn_wrap .update").click(function () {
            showModal("reservation", this);
            $("#mypgModal").val("true");
            var rvIdx = $(this).attr("id").replaceAll("rvidx", "");
            console.log(rvIdx);
            $.ajax({
                type: 'GET',
                url: "/getReservation", // 서버 엔드포인트. 실제 경로는 서버 구현에 따라 다릅니다.
                data: {
                    // 필요한 경우, 요청에 포함할 데이터. 예를 들어, 특정 예약 ID
                    rvIdx: rvIdx
                },
                success: function (data) {
                    console.log(data);
                    $(".rs_year").text((data.reservation.rvUseDate) + "년 (" + data.reservation.rvUseYearDate + ")");
                    $(".rs_total_price").text(AddComma(parseInt(data.reservation.rvPrice)));
                    $(".rs_feet").text(`${"${data.reservation.rvFeet}"}평`);
                    $(".rv_farmName").text(data.wfSubject);

                    $("#reFeet").val(data.reservation.rvFeet);
                    $("#reYear").val(data.reservation.rvUseDate);
                    $("#price").val(data.wfPrice);
                    $("#option_price").val(data.wfOptionPrice);
                    $("#rvIdx").val(data.reservation.rvIdx);



                    setOptions(data.reservation.rvOptionsData); // rvOptionsData를 처리하는 함수, 구현 필요

                    function setOptions(optionsData) {
                        if (data.reservation.rvOptionSeeding === 'Y') $("#op1").prop('checked', true);
                        if (data.reservation.rvOptionPlow === 'Y') $("#op2").prop('checked', true);
                        if (data.reservation.rvOptionWatering === 'Y') $("#op3").prop('checked', true);
                        if (data.reservation.rvOptionCompost === 'Y') $("#op4").prop('checked', true);
                    }

                    let arr = data.reservation.rvUseYearDate.split(",");
                    for (let i = 0; i < arr.length; i++) {
                        $($("input[name='year']")).each(function (idx, ele) {
                            if ($(this).val() === arr[i]) {
                                //console.log(arr[idx]);
                                $(this).prop("checked", true);
                            }
                        });
                    }
                    let optionTxt = "";
                    optionTxt += data.reservation.rvOptionSeeding === 'Y' ? "모종 제공<span>,</span>" : "";
                    optionTxt += data.reservation.rvOptionPlow === 'Y' ? "밭갈기<span>,</span>" : "";
                    optionTxt += data.reservation.rvOptionWatering === 'Y' ? "물주기<span>,</span>" : "";
                    optionTxt += data.reservation.rvOptionCompost === 'Y' ? "퇴비뿌리기<span>,</span>" : "";

                    let optionNull = data.reservation.rvOptionSeeding === 'N' && data.reservation.rvOptionPlow === 'N' && data.reservation.rvOptionWatering === 'N' && data.reservation.rvOptionCompost === 'N' ? true : false;
                    console.log(optionNull);
                    $(".rs_option").html(optionNull ? '선택 없음' : optionTxt);

                    let feetlength = data.reservation.rvFeet / 3;
                    console.log(feetlength);
                    for (let i = 0; i < feetlength; i++) {
                        //console.log(i);
                        $(".field_wrap > div").eq(i).find("img").attr("src", "../img/field_on.png");
                        $(".field_wrap > div").eq(i).find("input").prop("checked", true)
                    }
                    $(".feet span").text(data.reservation.rvFeet);

                    //console.log(data);
                    console.log($("#rvMemIdx").val(data.reservation.rvMemIdx));
                },
                error: function (xhr, status, error) {
                    // 에러 메시지 표시 로직
                    var errorMessage = "오류가 발생했습니다: ";
                    if (xhr.status === 0) {
                        errorMessage += "네트워크 연결을 확인해주세요.";
                    } else if (xhr.status === 404) {
                        errorMessage += "요청한 페이지를 찾을 수 없습니다. (404)";
                    } else if (xhr.status === 500) {
                        errorMessage += "서버 내부 오류가 발생했습니다. (500)";
                    } else if (status === 'parsererror') {
                        errorMessage += "요청한 JSON 파싱이 실패했습니다.";
                    } else if (status === 'timeout') {
                        errorMessage += "시간 초과 오류.";
                    } else if (status === 'abort') {
                        errorMessage += "AJAX 요청이 중단되었습니다.";
                    } else {
                        errorMessage += "오류가 발생했습니다. 오류: " + xhr.responseText;
                    }
                    console.log(errorMessage); // 콘솔에 에러 메시지 출력
                    // 사용자에게 에러 메시지를 보여주는 로직을 여기에 추가할 수 있습니다.
                    alert(errorMessage); // 사용자에게 에러 메시지를 알림으로 표시
                }
            })

        });
    });
</script>