
$( document ).ready(function() {
    var $container = $('.masonryGrid-area');
    try {
        $container.imagesLoaded(function () {
            $container.masonry({
                itemSelector: '.masonryGrid-item',
                columnWidth: parseInt($container.attr('colwidth'))
            });
        });
    }catch(error){}

    $('.tagfilterform').submit(function() {
        var oldtags = $(this).find('.previoustags').val();
        var currenttag = $(this).find('.currenttag').val();
        $(this).find('.tags').val($.trim(oldtags  + ' ' + currenttag ));
        $(this).find('.previoustags').remove();
        return true;
    });

    $(".removeTag").click(function(){
        // debugger;
        var tags = $(this).attr('tag');
        window.location.search=$.trim(removeFilter(window.location.search, tags));
    });

});

/** removeFilter function:
 *            remove filter by key.
 **/
function removeFilter(searchUri, key) {
    var uri = '?tags=';
    var filters = searchUri.replace(uri,"").split('+');
    var filterCounter = 0;

    filters.forEach(function(entry) {
        if(entry != key){
            if(!uri.endsWith('=')){uri = uri + '+'}
            uri = uri + entry;
            filterCounter++;
        }
    });

    return filterCounter > 0 ? uri : '';
}

