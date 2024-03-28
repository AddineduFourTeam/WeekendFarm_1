<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<div class="background">
    <div class="window">
        <div class="popup">
            <input type="hidden" id="mypgModal" value="false">
            <input type="hidden" id="rvIdx" value="">
            <button class="close"><i class="fa-solid fa-xmark"></i></button>
            <div class="modal-content-reservation modal-content" style="display: none">
                <c:import url="../views/reservation.jsp"/>
            </div>
            <div class="modal-content-gallery modal-content" style="display: none">
                <c:import url="../views/gallery.jsp"/>
            </div>
        </div>
    </div>
</div>

<script>
    /*** 팝업 동작 ***/
    document.addEventListener('DOMContentLoaded', () => {
        const galleryItems = document.querySelectorAll(".gallery > ul >  li");
        const openModalButton = document.querySelector(".rv_btn");
        const modal = document.querySelector(".background");
        const closeButton = document.querySelector(".close");

        galleryItems.forEach((li, index) => {
            li.addEventListener('click', () => {
                swiper.slideTo(index, 0, false)
                showModal('gallery');
            });
        });

        //galleryItems.addEventListener('click', () => showModal("gallery"));
        closeButton.addEventListener('click', () => closeModal(modal));
    });
    const wfidx = 0;
    function showModal(type<c:if test="${folderName eq 'mypageReservation'}">, target</c:if>) {
        <c:if test="${folderName eq 'mypageReservation'}">
        document.getElementById("wfidx").value = target.getAttribute('data-wfidx');
        </c:if>
        //console.log(".modal-content-" + type);
        modal = document.querySelector(".background");
        modal.classList.add("show");
        document.querySelector("body").style.overflow = "hidden";
        document.querySelector(".popup").classList.add("popup", "animate__animated", "animate__zoomIn", "animate__faster");
        document.querySelector(".modal-content-" + type).style.display = "block";
    }

    const closeModal = (modal) => {
        document.querySelector("body").style.overflow = "auto";
        let mc = document.querySelectorAll(".modal-content");
        mc.forEach(function(ele, index){
            ele.style.display = "none";
        });
        document.querySelector(".popup").classList.add("popup" ,"animate__animated" ,"animate__zoomOut" ,"animate__faster")
        setTimeout(function (){
            modal.classList.remove("show");
            document.querySelector(".popup").classList.remove("animate__animated", "animate__zoomIn", "animate__faster", "animate__zoomOut");
        },200)
    }

    /*** 예약팝업내용 ***/
    $(document).ready(function () {
        let price = $("#price").val();
        let option_price = $("#option_price").val();
        //console.log(option_price);
        let isChecked = $("input[name='feet']");
        let src;
        isChecked.change(function () {
            if ($(this).is(':checked')) {
                src = "../img/field_on.png";
            } else {
                src = "../img/field.png";
            }
            $(this).siblings("label").find("img").attr('src', src);
        });
        let optionArr = [];
        $("input[name='option']").change(function() {
            //let optionName = $(this).val();
            if ($(this).is(":checked")) {

                $(this).val("Y");
            } else {
                $(this).val("N");
            }
            optionArr = [];
            $("input[name='option']").each(function(){
                if ($(this).is(":checked")) {
                    optionArr.push($(this).siblings().children('.txt').text());
                }
            });
        });

        let year_leng = 0;
        let option_leng = 0;

        $("input[type='checkbox']").change(function () {
            let price = $("#price").val();
            let option_price = $("#option_price").val();
            let name = $(this).attr("name");

            let count = $("input[name='feet']:checked").length * 3;
            if (name === "option") {
                let content = $("input[name='option']:checked");
                option_leng = $("input[name='option']:checked").length;
                let value = content.siblings().children('.txt').text();
                $(".rs_option").text(optionArr);
            } else {
                yearArr = [];
                $("input[name='year']").each(function(){
                    if ($(this).is(":checked")) {
                        yearArr.push($(this).val());
                    }
                });
                year_leng = $("input[name='year']:checked").length;
                $("#reYear").val(year_leng);
                $("#reFeet").val(count);

                $(".rs_year").text(year_leng + "년 (" + yearArr + ")");
                $(".rs_feet").text(count + "평");
                $('.feet > span').html(count);
            }
            $(".rs_total_price").text(AddComma(parseInt((year_leng * count / 3 * price) + (option_leng * option_price))));
            console.log(option_price);
            console.log((year_leng * count / 3 * price) + "/" + (option_leng * option_price));
        });

    });

    $(".booking_btn").click(function(e){
        e.preventDefault();
        function getOptionValue(selector) {
            return $(selector).is(":checked") ? "Y" : "N";
        }

        let rvOptionsData = {
            "rvOptionSeeding": getOptionValue("#op1"),
            "rvOptionPlow": getOptionValue("#op2"),
            "rvOptionWatering": getOptionValue("#op3"),
            "rvOptionCompost": getOptionValue("#op4")
        };

        if(validate()) {
            var arr = [];
            $("input[name='year']:checked").each(function(){
                arr.push(parseInt($(this).val()));
            });

            console.log(arr);
            let wfidx = $("#wfidx").val() !== null ? $("#wfidx").val() : 0 ;
            $.ajax({
                type: 'POST',
                url: $("#mypgModal").val() ? "/reservationSave" : "/reservationUpdate",
                data: {
                    "rvIdx" : $("#rvIdx").val(),
                    "rvMemIdx" : ${loginUser.memIdx > 0 ? loginUser.memIdx : 0 },
                    "rvFarmIdx" : <c:if test="${param.id ne null}">${param.id}</c:if>
                                    <c:if test="${empty param.id}">wfidx</c:if>,
                    "rvUseDate" : $("#reYear").val(),
                    "status" : "Y",
                    "rvPrice" :  removeComma($(".rs_total_price").text()),
                    "rvFeet" : $("#reFeet").val(),
                    "rvUseYearDate" : arr,
                    ...rvOptionsData
                },
                success: function (){
                    console.log("성공");
                    window.location.href = "/mypageReservation";
                },
                error: function(){
                    console.log("실패");
                }
            })
        }

    });

    function validate(){
        let year = $(".rs_year").text();
        let feet = $(".rs_feet").text();

        if(year < 1){
            alert("기한을 선택해주세요");
            $("input[name='year']").focus();
            return false;
        }else if(feet < 1){
            alert("평 수를 선택해주세요");
            $("input[name='feet']").focus();
            return false;
        }else{
            return true;
        }
    }


</script>