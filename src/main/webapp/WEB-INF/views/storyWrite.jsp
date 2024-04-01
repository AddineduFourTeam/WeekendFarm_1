<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<c:if test="${empty loginUser}">
    <script>
        alert("로그인 후 작성 가능합 니다.");
        location.href="/login";
    </script>
</c:if>
<div class="wrap con">
    <%@include file="../include/board_search.jsp" %>
    <div class="story_con">
        <form action="<c:out value="${not empty param.sno ? 'storyUpdate' : 'storyForm'}"/>" method="post" enctype="multipart/form-data">
            <input type="hidden" id="storyIdx" name="storyIdx" value="${param.sno}">
            <div class="storyW_tt">
                <label for="title" class="story_listtt">스토리 제목</label>
                <input type="text" id="title" name="storySubject" value="${story.storySubject}" required>
            </div>
            <div class="story_txt">
                <label for="content" class="story_listtt">스토리 내용</label>
                <textarea id="content" name="storyContent" required>${fn:replace(story.storyContent, '<br>', '\\n')}</textarea>
            </div>
            <div class="story_farm">
                <input type="hidden" id="farm_select" name="farm_select">
                <div class="story_listtt">농장 선택</div>
                <ul class="farm_select">
                    <c:forEach items="${localArray}" var="localArray" varStatus="idx">
                        <li>
                            <input type="radio" class="" id="farm_local${idx.index}" name="farm_local" value="${localArray}" <c:if test="${idx.index == 0}">checked</c:if>>
                            <label for="farm_local${idx.index}">${localArray}</label>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="story_img_submit">
                <ul class="story_submit_ul">
                    <%--<c:if test="${not empty param.sno}">
                        <li>
                            <input type="radio" id="storyWfIdx${status.index}" name="storyWfIdx" value="" class="" >
                            <label for="storyWfIdx${status.index}">
                                <div class="farm_list_img">
                                    <img src="http://www.nongsaro.go.kr/cms_contents/1096/229882_MF_BIMG_01.jpg" alt="">
                                </div>
                                <span class="farm_list_tt">농장데스네</span>
                            </label>
                        </li>
                    </c:if>--%>
                </ul>
            </div>
            <div class="farm_img">
                <div class="story_listtt">
                    스토리 이미지
                </div>
                <ul>
                    <li class="farm_img1">
                        <input id="fileInput" type="file" multiple name="file1" value="${story.storyImg1}" onchange='readFile(this)' hidden/>
                        <label for="fileInput">
                        <c:choose>
                            <c:when test="${story.storyImg1 ne null}">
                                <img src="/image/${story.storyIdx}/1" alt="">
                            </c:when>
                            <c:otherwise>
                                이미지 선택<span>(썸네일 이미지)</span><small>10mb 이하</small>
                            </c:otherwise>
                        </c:choose>
                        </label>
                    </li>
                    <li class="farm_img2" <c:if test="${story.storyImg2 ne null}">style="display:block"</c:if>>
                        <input id="fileInput2" type="file" multiple name="file2" onchange='readFile(this)' value="${story.storyImg2}" hidden/>
                        <label for="fileInput2">
                            <c:choose>
                                <c:when test="${story.storyImg2 ne null}">
                                    <img src="/image/${story.storyIdx}/2" alt="">
                                </c:when>
                                <c:otherwise>
                                    이미지 선택<span>(썸네일 이미지)</span><small>10mb 이하</small>
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </li>
                    <li class="farm_img3" <c:if test="${story.storyImg3 ne null}">style="display:block"</c:if>>
                        <input id="fileInput3" type="file" multiple name="file3" value="${story.storyImg3}" onchange='readFile(this)' hidden/>
                        <label for="fileInput3">
                            <c:choose>
                                <c:when test="${story.storyImg3 ne null}">
                                    <img src="/image/${story.storyIdx}/3" alt="">
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
                <button><c:out value="${not empty param.sno ? '수정' : '등록'}"/></button>
                <span class="btnimg"><img src="/img/sprout.png" alt="새싹"></span>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        let farm_local = $("input[name='farm_local']:checked").val();
        farmlocal(farm_local);

        $("input[name='farm_local']").change(function () {
            farmlocal($(this).val());
        });
        /* $(".story_submit button").click(function(){
             $(this)
         });*/

        <%--<c:if test="${param.sno ne null}">
        var checkedInput = $(".story_submit_ul input:checked");
        console.log(checkedInput);

        if (checkedInput.length > 0) {
            var sTop = checkedInput.closest("li").offset().top;
            $(".story_submit_ul").scrollTop(sTop);
        }
        </c:if>--%>
    });

    $(".farm_img li input").change(function () {
        $(this).parents("li").next("li").show();
    });

    function farmlocal(input) {
        $.ajax({
            url: "/storyLocal",
            data: {'local': input, "use": "storyWrite"},
            type: "post",
            success: function (data) {
                console.log("success");
                let content ="";
                //console.log(data);
                if(data === null || data.length === 0) {
                    content = "<li class='nofarmlist'>해당 지역에 농장이 없습니다.</li>"
                }else {
                    data.forEach(function (data, idx) {
                        var checked = "" ;
                        <c:if test="${story.storyWfIdx ne null}">
                        checked = (data.wfIdx === ${story.storyWfIdx}) ? 'checked' : ''; // JSTL 변수를 JavaScript 변수로 사용
                        </c:if>
                        content += "<li>"+
                            "<input type='radio' id='storyWfIdx"+idx+"' "+ checked +" name='storyWfIdx' value='"+data.wfIdx+"' class=''>"+
                            "<label for='storyWfIdx"+idx+"'>"+
                            "<div class='farm_list_img'>"+
                            "<img src='"+data.wfImgUrl1+"' alt=''>"+
                            "</div>"+
                            "<b class='farm_list_tt'>"+data.wfSubject+"</b>"+
                            "<span>"+data.wfAddr+"</span>"+
                            "</label>"+
                            "</li>";
                        //console.log(data.wfAddr);
                    });
                }
                $(".story_submit_ul").html(content);
            },error: function(){
                console.log('error');
            }
        });
    };



    function readFile(input) {
        readURL(input);

        const file = input.files[0]; // 첨부된 파일을 가져옴

        const reader = new FileReader();

        reader.readAsDataURL(file); // 파일을 base64로 변환

        reader.onload = function() {
            console.log(reader.result); // 읽은 파일 소스단에 출력
            //document.querySelector('img').src = reader.result;
        };

        reader.onerror = function() {
            console.log(reader.error);
        };

    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                //console.log(input);
                $(input).next("label").html(`<img src='${"${e.target.result}"}'>`);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

</script>
<%@include file="../include/footer.jsp" %>