$(document).ready(function() {
    function initPhotoswipe(){
        /* Photoswipe lightbox*/
        var $pswp = $('.pswp')[0];
        var items = [];
        var $src = $('#picture').attr('src');

        /* Get image size */
        $width  = $("#picture").attr('data-width');
        $height = $("#picture").attr('data-height');

        var item = {
            src: $src,
            w: $width,
            h: $height
        }

        items.push(item);

        var options = {
            index: 0,
            bgOpacity: 0.8,
            showHideOpacity: true
        }
        var lightBox = new PhotoSwipe($pswp, PhotoSwipeUI_Default, items, options);
        lightBox.init();
    }

    $( "#picture" ).click(function() {
        initPhotoswipe();
    });
});
