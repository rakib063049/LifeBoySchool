jQuery(document).ready(function () {
    $('input[data-option-confirmation=true]').each(function () {

        var observer_dom_id = $(this).attr('id');
        var observer = $('input#' + observer_dom_id);

        observer.focusout(function () {
            alert('Are you sure?');
        });
    });
});