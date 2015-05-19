
function UpdateTableHeaders() {
   $(".persist_area").each(function() {

       var el             = $(this),
           offset         = el.offset(),
           scrollTop      = $(window).scrollTop(),
           floatingHeader = $(".floatingHeader", this)


       if ((scrollTop > offset.top) && (scrollTop < offset.top + el.height())) {
           floatingHeader.css({
            "visibility": "visible"
           });
       } else {
           floatingHeader.css({
            "visibility": "hidden"
           });
       };
   });
}

$(function() {
    var $floatingHeader = $(".persist_header", this).clone();

    $floatingHeader.children().width(function (i, val) {
    return $(".persist_header").children().eq(i).width();
    });

    $floatingHeader.css("width", $(".persist_header", this).width()).addClass("floatingHeader");
    $(".persist_header", this).before($floatingHeader);

   $(window)
    .scroll(UpdateTableHeaders)
    .trigger("scroll");

});
