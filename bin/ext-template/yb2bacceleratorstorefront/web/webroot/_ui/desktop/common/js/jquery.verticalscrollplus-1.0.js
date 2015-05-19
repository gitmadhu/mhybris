/*
* jQuery verticalScroll
* Copyright (c) 2011 SaCaWeb www.sacaweb.com
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:

* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE. 
*/

/*
* Version: V1.0
* Release: 23-02-2011
* Based on jQuery 1.4.2
*/



(function ($) {
    $.fn.verticalScrollPlus = function (options) {
        var options = $.extend({}, { speed: 500, step: 60, upID: "#su_btn", downID: "#giu_btn", scrollerID:"#scroller" }, options);

        return this.each(function () {
            obj = $(this);//il wrapper
            obj.css("overflow", "hidden");
            obj.css("position", "relative");
            /*obj.css("height", options.height + "px");*/
            var wrapper_h = obj.outerHeight();

            $(options.scrollerID).css("position", "absolute");

            $(options.downID).click(function () {
                 var scroller_h = $(options.scrollerID).outerHeight();
                 var scroller_top2 = parseInt($(options.scrollerID).css("top"));
                 if((scroller_top2 - wrapper_h - options.step) < - scroller_h ){
                     var offset2 = scroller_h - wrapper_h;
                     $(options.scrollerID).stop().animate({top:"-" + offset2 + "px"}, options.speed);
                     return;
                 }
                 $(options.scrollerID).stop().animate({
                      top: "-=" + options.step + "px"
                          }, options.speed);
            });

            $(options.upID).click(function () {
                 var scroller_top = parseInt($(options.scrollerID).css("top"));
                 var offset = scroller_top + wrapper_h;
                 if(offset > 0){
                     $(options.scrollerID).stop().animate({top:0}, options.speed);
                     return;
                 }
                 $(options.scrollerID).stop().animate({
                      top: "+=" + options.step + "px"
                          }, options.speed);

            });


        });

    };

})(jQuery);