
$( document ).ready(function() {
    var $container = $('.masonryGrid-area');
    $container.imagesLoaded( function() {
        $container.masonry({
            itemSelector: '.masonryGrid-item',
            columnWidth: parseInt($container.attr('colwidth'))
        });
    })

    $('.tagfilterform').submit(function() {
        var oldtags = $(this).find('.previoustags').val();
        var newtags = $(this).find('.tags').val();
        $(this).find('.tags').val($.trim(newtags+' '+oldtags));
        $(this).find('.previoustags').remove();
        return true;
    });

    $(".removeTag").click(function(){
        debugger;
        var tags = $(this).attr('tag');
        // Perform your action on click here, like redirecting to a new url
        window.location.search=$.trim(window.location.search.replace("+"+tags+"+", ""));
        window.location.reload()
    });

});

