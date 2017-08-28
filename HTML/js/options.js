$('select[name=reason]').change(function () {
    if ($(this).val() == 'textSuggest') {
        $('#text').show();
    } else {
        $('#text').hide();
    }
});
$('select[name=reason]').change(function () {
    if ($(this).val() == 'prosopSuggest') {
        $('#prosop').show();
    } else {
        $('#prosop').hide();
    }
});