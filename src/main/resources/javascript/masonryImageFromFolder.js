
$( document ).ready(function() {
    var $container = $('.masonryGrid-area');
    $container.imagesLoaded( function() {
        $container.masonry({
            itemSelector: '.masonryGrid-item',
            columnWidth: parseInt($container.attr('colwidth'))
        });
    })

});