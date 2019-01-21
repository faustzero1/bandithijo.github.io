$("p").each(function() {
    if($(this).html()=='[expand]') {
        $(this).addClass('expand_start');
    }
    if($(this).html()=='[/expand]') {
        $(this).addClass('expand_end');
    }
});
$( "p.expand_start" ).each(function() {
    $(this).nextUntil( $("p.expand_end") ).wrapAll("<div class='expand' style='overflow: hidden;'></div>");
    $(this).prev().append('<span>..&nbsp; <a href="#" style="cursor: pointer;" onclick="$(this).parent().parent().next().slideToggle(); $(this).parent().hide();">read&nbsp;more&nbsp;&rarr;</a></span>');
    $(this).remove()
});
$( ".expand").hide();
$( "p.expand_end" ).hide();
