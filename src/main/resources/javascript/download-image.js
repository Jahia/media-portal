$(function(){
    $('.radioType').click(function() {
        if ($(this).is(':checked')) {
            $("#button-download").attr('href', $(this).attr('data-url'));
        }
    });

    $("#radio_1").attr('checked', true).click();

});