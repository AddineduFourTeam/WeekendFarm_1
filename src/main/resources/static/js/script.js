
// animate 효과
/*wow = new WOW(
    {
        boxClass:     'wow',      // 기본값
        animateClass: 'animated',  // 기본값
        offset:       0,          // 기본값
        mobile:       true,       // 기본값
        live:         true        // 기본값
    });
wow.init();*/
new WOW().init();

$(document).ready(function(){
    smoothScroll();

    /* main */

    $(window).scroll(function(){
        scroll();
    });
    scroll();
    if($("header").hasClass("on") === true) {
        $("h1 img").attr("src","/img/logo.png");
    }else {
        $(".index_body h1 img").attr("src", "/img/logo_w.png");
    }

    $(".main_story_slide").slick({
        arrows:false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        centerMode: true,
        variableWidth: true,
        spaceBetween: 20,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false
        }
    });

    // story list
    if($("div").hasClass("story_list") === true) {
        //console.log("ddddd");
        setTimeout(function(){
            masonryLayout();
            window.addEventListener("resize", masonryLayout);
        },1000)
    }


    $(document).on("input",".story_reply textarea",function(){
        var reply_submit = $(this).parents(".story_reply_input").find(".reply_submit");
        resize(this);
        if($(this).val().length > 0) {
            $(reply_submit).addClass("on");
            $(reply_submit).prop("disabled",false);
        }else {
            $(reply_submit).removeClass("on");
            $(reply_submit).prop("disabled",true);
        }
    });

    function resize(obj) {
        obj.style.height = '1px';
        obj.style.height = (14 + obj.scrollHeight) + 'px';
    }



});

function scroll() {
    if($(window).scrollTop() > 20) {
        $("header").addClass("on");
        $("h1 img").attr("src","/img/logo.png");
        $(".tnb span img").on("error", function() {
            $(this).attr("src", "/img/profileImg.png");
        });
        $(".list_nav").addClass("nav_up");

    }else {
        $("header").removeClass("on");
        $(".index_body h1 img").attr("src", "/img/logo_w.png");
        $(".tnb span img").on("error", function() {
            $(this).attr("src", "/img/profileImg_w.png");
        });
        $(".list_nav").removeClass("nav_up");
    }
}


    $(".list_nav ul li a").click(function(event){
        event.preventDefault();
        $('html,body').animate({
            scrollTop: $(this.hash).offset().top - 220
        }, 50);
    });


function masonryLayout() {
    const masonryContainerStyle = getComputedStyle(
        document.querySelector(".story_list")
    );
    const columnGap = parseInt(
        masonryContainerStyle.getPropertyValue("column-gap")
    );
    const autoRows = parseInt(
        masonryContainerStyle.getPropertyValue("grid-auto-rows")
    );

    document.querySelectorAll(".story_items").forEach((elt) => {
        elt.style.gridRowEnd = `span ${Math.ceil(elt.querySelector(".story_content").scrollHeight / 10 + 1)}`;
    });
}


function AddComma(num)
{
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return num.toString().replace(regexp, ',');
}
function removeComma(str)
{
    n = parseInt(str.replace(/,/g,""));
    return n;
}