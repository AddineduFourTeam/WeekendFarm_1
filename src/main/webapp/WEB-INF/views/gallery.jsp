<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<h2>${listDetail.wfSubject}</h2>
<div class="modal_swiper">
    <div class="swiper-wrapper">
        <div class="swiper-slide"><img src="${listDetail.wfImgUrl1}" alt="이미지1" onerror="this.src='/img/placeholder.png'"></div>
        <c:forEach begin="0" end="6">
            <div class="swiper-slide"><img src="" alt="placeholder image" onerror="this.src='/img/placeholder.png'"></div>
        </c:forEach>
    </div>
</div>
<div class="modal-button-prev"><i class="fa-solid fa-angle-left"></i></div>
<div class="modal-button-next"><i class="fa-solid fa-angle-right"></i></div>

<script>
    var swiper = new Swiper(".modal_swiper", {
        navigation: {
            nextEl: ".modal-button-next",
            prevEl: ".modal-button-prev",
        },
    });
</script>