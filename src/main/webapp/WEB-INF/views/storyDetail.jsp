<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="wrap con">
    <%@include file="../include/board_search.jsp" %>
    <div class="board_con board_view">
        <div class="board_tb">
            <div class="board_view_tt">${story.storySubject}</div>
            <div class="board_view_top flex">
                <div class="board_view_writer">
                    <span><img src="${story.storyMemImg}" alt=""
                               onerror="this.src='img/profileImg.png'"></span>${story.storyMemId}
                </div>
                <div class="board_view_date">
                    <span>
                       조회수 : <span class="count">${story.storyCount}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </span>
                    <span>
                        <fmt:parseDate value="${story.storyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime"
                                       type="both"/>
                        <fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}"/>
                    </span>
                </div>
            </div>
            <div class="board_view_con">
                <c:if test="${not empty story.storyImg1}">
                    <div class="story_detail_slide">
                        <button type="button" class="prev"><i class="fa-solid fa-angle-left" aria-hidden="true"></i>
                        </button>
                        <div class="story_detail_img">
                            <div class="story_detail_img_list">
                                <c:if test="${not empty story.storyImg1}">
                                    <img src="/image/${story.storyIdx}/1" alt="Image">
                                </c:if>
                            </div>
                            <div class="story_detail_img_list">
                                <c:if test="${not empty story.storyImg2}">
                                    <img src="/image/${story.storyIdx}/2" alt="Image">
                                </c:if>
                            </div>
                            <div class="story_detail_img_list">
                                <c:if test="${not empty story.storyImg3}">
                                    <img src="/image/${story.storyIdx}/3" alt="Image">
                                </c:if>
                            </div>
                        </div>
                        <button type="button" class="next"><i class="fa-solid fa-angle-right" aria-hidden="true"></i>
                        </button>
                    </div>

                </c:if>
                <div class="story_detail_con">
                    ${story.storyContent}
                </div>
            </div>
            <div class="board_btn">
                <c:if test="${loginUser.memIdx eq story.storyMemIdx}">
                <a href="/storyWrite?sno=${param.id}">수정</a>
                <a href="javascript:myStoryDelete(${param.id})" class="delete">삭제</a>
                </c:if>
                <a href="/story">목록</a>
            </div>
            <div class="story_reply">
                <div class="story_reply_top">
                    <h4>댓글 <span>${ReplySize}</span>개</h4>
                </div>
                <div class="story_reply_input">
                    <textarea name="" row="1" placeholder="댓글을 작성해주세요." id="message_textbox"></textarea>
                    <div class="btnFlex flex">
                        <button class="emoji_btn" data-target-textbox="message_textbox"><i
                                class="fa-regular fa-face-smile"></i></button>
                        <button type="button" class="reply_submit" id="reply_submit" disabled="disabled">등록</button>
                    </div>
                </div>
                <c:choose>
                <c:when test="${Replylist ne null}">
                <% pageContext.setAttribute("newLineChar", "\n"); %>
                <div class="story_reply_list">
                    <ul>
                        <c:forEach var="list" items="${Replylist}" varStatus="i">
                            <li> <%--data-target-srIdx="${list.srIdx}"--%>
                                <input type="hidden" name="srIdx" value="${list.srIdx}">
                                <div class="sr_depth1">
                                    <div class="sr_depth_flex">
                                        <div class="sr_img"><img src="${memInfoList[i.index].memImg}" alt=""
                                                                 onerror="this.src='img/profileImg.png'"></div>
                                        <div class="sr_reply_right">
                                            <div class="sr_name">@${memInfoList[i.index].memid}</div>
                                            <div class="sr_txt">
                                                ${fn:replace(list.srContent, newLineChar, "<br/>")}
                                            </div>
                                            <div class="sr_btm">
                                                <div class="sr_txt_btn">
                                                    <a href="javascript:void(0);" onclick="like(this,${list.srIdx});" class="like"><i
                                                            class="fa-regular fa-thumbs-up"></i>
                                                        <span>${list.srLike > 0 ? list.srLike : ""}</span>
                                                    </a>
                                                    <c:if test="${loginUser.memIdx eq list.srMemIdx}">
                                                    <a href="javascript:void(0);" onclick="reply_update(this,${list.srIdx})">수정</a>
                                                    <a href="javascript:void(0)" onclick="reply_delete(this,${list.srIdx});">삭제</a>
                                                    </c:if>
                                                    <%--<a href="javascript:void(0);" onclick="rereply(this, '${list.srIdx}');" class="reply_submit_btn">댓글달기</a>--%>
                                                </div>
                                                <span class="sr_date">
                                                    <fmt:parseDate value="${list.srDate}"
                                                                   pattern="yyyy-MM-dd'T'HH:mm"
                                                                   var="parsedDateTime" type="both"/>
                                                    <fmt:formatDate pattern="yyyy.MM.dd"
                                                                    value="${parsedDateTime}"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--<c:if test="${list.srDepth eq 2}">
                                <ul class="sr_depth2">
                                    <li>
                                        <div class="sr_depth_flex">
                                            <div class="sr_img"><img src="" alt="" onerror="this.src='img/profileImg.png'"></div>
                                            <div class="sr_reply_right">
                                                <div class="sr_name"></div>
                                                <div class="sr_txt">
                                                    ${Relist.srContent}
                                                </div>
                                                <div class="sr_btm">
                                                    <div class="sr_txt_btn">
                                                        <a href="javascript:void(0);"><i class="fa-regular fa-thumbs-up"></i><span></span></a>
                                                        <a href="">수정</a>
                                                        <a href="">삭제</a>
                                                    </div>
                                                    <span class="sr_date">
                                                        <fmt:parseDate value="${Relist.srDate}"
                                                                       pattern="yyyy-MM-dd'T'HH:mm"
                                                                       var="parsedDateTime" type="both"/>
                                                    <fmt:formatDate pattern="yyyy.MM.dd"
                                                                    value="${parsedDateTime}"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                </c:if>--%>
                            </li>
                        </c:forEach>
                    </ul>
                    <%@include file="../include/paging.jsp" %>
                </div>
                </c:when>
                    <c:otherwise>
                        <div class="sr_empty">댓글이 없습니다. 댓글을 등록해주세요.</div>
                    </c:otherwise>
                </c:choose>
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
        let storySlideWidth = $(".story_detail_img").outerWidth();

        //이미지가 3개가 넘어가면 슬라이드
        $(window).on('load', function () {
            $(".story_detail_img_list").each(function () {
                slideItemWidth += $(this).innerWidth();
            });
            if (storySlideWidth < slideItemWidth) {
                story_slick();
            }
        });

        //댓글 등록
        $("#reply_submit").click(function () {
            let text = $("#message_textbox").val();
            text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');
            //console.log(text);
            if(is_login()) {
            $.ajax({
                url: "/storyReplySave",
                data: {"id":${param.id}, "srMemIdx":${user_idx}, "srDepth": 1, "srContent": text},
                type: "post",
                success: function (data) {
                    console.log(data);
                    let content = `<li>
                        <div class="sr_depth1">
                        <div class="sr_depth_flex">
                        <div class="sr_img"><img src="${"${data.memImg}"}" alt="" onerror="this.src='img/profileImg.png'"></div>
                        <div class="sr_reply_right">
                        <div class="sr_name">@${"${data.name}"}</div>
                        <div class="sr_txt">
                        ${"${data.storyReply.srContent}"}
                        </div>
                        <div class="sr_btm">
                        <div class="sr_txt_btn">
                        <a href="javascript:void(0);"><i class="fa-regular fa-thumbs-up"></i><span></span></a>
                        <a href="javascript:void(0)" onclick="reply_update(${"${data.storyReply.srIdx}"})">수정</a>
                        <a href="javascript:void(0)" onclick="reply_delete(${"${data.storyReply.srIdx}"});">삭제</a>
                        </div>
                        <span class="sr_date">${"${data.storyReply.srDate}"}</span>
                        </div>
                        </div>
                        </div>
                        </div>
                        </li>`;
                    /*<a href="javascript:void(0);" class="reply_submit_btn" id="reply_submit_${"${data.srIdx}"}">댓글달기</a>*/
                    $(".story_reply_list > ul").prepend(content);
                    $("#message_textbox").val('');
                }, error: function (xhr, status, error) {
                    console.log(xhr, status, error);
                }
            });
            }
        });

        $(document).on("click",".rereply_submit",function(){
            let targetId = $(this).data("target-id");
            let reText = $("#message_textbox"+targetId).val();
            //console.log(reText);
            reText = reText.replace(/(?:\r\n|\r|\n)/g, '<br>');
            //console.log(text);
            if(is_login()) {
                $.ajax({
                    url: "/storyReplySave",
                    data: {"id":${param.id}, "srMemIdx":${user_idx}, "srDepth": 2, "srContent": reText,"srReplyIdx" : targetId},
                    type: "post",
                    success: function (data) {
                        let content = `<li>
                                    <div class="sr_depth_flex">
                                        <div class="sr_img"><img src="" alt="" onerror="this.src='img/profileImg.png'"></div>
                                        <div class="sr_reply_right">
                                            <div class="sr_name">depth2</div>
                                            <div class="sr_txt">
                                                ${'${data.storyReply.srContent}'}
                                            </div>
                                            <div class="sr_btm">
                                                <div class="sr_txt_btn">
                                                   <a href="javascript:void(0)" onclick="reply_update(${"${data.srIdx}"})">수정</a>
                                                    <a href="javascript:void(0)" onclick="reply_delete(${"${data.srIdx}"});">삭제</a>
                                                </div>
                                                <span class="sr_date">${"${data.srDate}"}</span>
                                            </div>
                                        </div>
                                    </div>
                                </li>`;
                                                console.log(data);
                        if($(this).closest("li").find("div").hasClass("sr_depth2") === false) {
                            $(".sr_depth1").after("<ul class='sr_depth2'></ul>").prepend(content);
                        }else {
                            $(".sr_depth2").prepend(content);
                        }
                        $(".sr_depth1 textarea").val('');
                    }, error: function (xhr, status, error) {
                        console.log(xhr, status, error);
                    }
                });

            }
        });

            /*let arr = $(".story_reply_list > ul > li");

            // 각 요소에 대한 AJAX 요청
            arr.each(function() {
                var srIdx = $(this).attr("data-target-srIdx");
                //console.log(srIdx);
                $.ajax({
                    url: "/storyReplyList",
                    data: {"srIdx": srIdx, "id": ${param.id}},
                    type: "post",
                    success: function(data) {
                        console.log("success", data);
                        for (let j = 0; j < data.length; j++) {
                            console.log("sdfdssdfsfs");
                        }
                    },
                    error: function() {
                        console.log("error");
                    }
                });
            });*/


    });



    //이미지 슬릭
    function story_slick() {
        //story slick
        $(".story_detail_img").slick({
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

    //댓글달기 폼 생성
    let tmp = 0;
    function rereply(target,idx) {
        //console.log(idx);
        if(is_login()) {
            if(tmp === 0) {
                let content = `<div class="story_reply_input">
                <textarea name="" row="1" placeholder="댓글을 작성해주세요." id="message_textbox${"${idx}"}"></textarea>
                <div class="btnFlex flex">
                <button class="emoji_btn" data-target-textbox="message_textbox${"${idx}"}"><i class="fa-regular fa-face-smile"></i></button>
                <button type="button" class="reply_submit rereply_submit" data-target-id="${"${idx}"}" disabled="disabled">등록</button>
                </div>
                </div>`
                //onclick="rereply_btn(${"${idx}"})"
                $(target).closest(".sr_reply_right").append(content);
                tmp = 1;
            }else {
                $(target).closest(".sr_reply_right").find(".story_reply_input").remove();
                tmp = 0;
            }

        }
    }


    //좋아요
    let likeTmp = 0;
    function like(ele,id){
        if (is_login()) {
            if(likeTmp ===0) {
                $.ajax({
                    url:"/likeUp",
                    type:"post",
                    data:{id : id},
                    success:function(result){
                       console.log("success");
                       $(ele).find("i").attr("class", "fa-solid fa-thumbs-up").css("color", "#01b03f");
                        $(ele).find("span").text(result);
                       likeTmp = 1;
                    },error: function (xhr, status, error) {
                        console.log(xhr, status, error);
                    }
                });
            }else {
                $.ajax({
                    url:"/likeDown",
                    type:"post",
                    data:{id : id},
                    success:function(result){
                        console.log("success");
                        $(ele).find("i").attr("class", "fa-regular fa-thumbs-up").css("color","#999");
                        $(ele).find("span").text(result > 0 ? result : "");
                        likeTmp = 0;
                    },error: function (xhr, status, error) {
                        console.log(xhr, status, error);
                    }
                });

            }
        }
    };

    // 댓글 수정 폼 생성
    let replyTmp = 0 ;
    function reply_update(ele, idx) {
        if (is_login()) {
            if(replyTmp === 0) {
                let sr_txt = $(ele).closest(".sr_reply_right").find(".sr_txt");
                let sr_html = sr_txt.html().trim().replaceAll("<br>","\n");
                let sr_hei =  sr_txt.innerHeight();
                console.log(sr_hei);
                let content = `<div class="story_reply_input">
                    <textarea name="" rows="1" placeholder="댓글을 작성해주세요." id="message_textbox${"${idx}"}">${"${sr_html}"}</textarea>
                    <div class="btnFlex flex">
                    <button class="emoji_btn" data-target-textbox="message_textbox${"${idx}"}"><i class="fa-regular fa-face-smile"></i></button>
                    <button type="button" class="reply_submit" onclick="reply_update_func(this,${"${idx}"})" disabled="disabled">수정</button>
                    </div>
                </div>`;
                sr_txt.html(content);
                sr_txt.find("textarea").css("height",sr_hei);
                replyTmp = 1;
            }
        }
    }

    //댓글 수정
    function reply_update_func(ele,id) {
        let sr_txt = $(ele).closest(".sr_reply_right").find(".sr_txt textarea").val();
        sr_txt = sr_txt.replace(/(?:\r\n|\r|\n)/g, '<br>');
        if (is_login()) {
            $.ajax({
                url: "/replyUpdate",
                type: "post",
                data: {id: id, txt : sr_txt},
                success: function (result) {
                    console.log("success");
                    $(ele).closest(".sr_reply_right").find(".sr_txt").html(result);
                    replyTmp = 0;
                }, error: function (xhr, status, error) {
                    console.log(xhr, status, error);
                }
            });
        }
    }
    function reply_delete(ele,idx) {
        if (is_login()) {
            $.ajax({
                url:"/replyDelete",
                type:"post",
                data:{id:idx},
                success:function(){
                    $(ele).closest("li").remove();
                }, error: function (xhr, status, error) {
                    console.log(xhr, status, error);
                }
            });
        }
    }

    function myStoryDelete(id){
        if(confirm("게시물을 삭제 하시겠습까?")) {
            $.ajax({
                url: "/storyDelete",
                data: {"id": id},
                type: "post",
                success: function (data) {
                    alert("삭제가 완료 되었습니다.");
                    history.back();
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