$('select[name=reason]').change(function () {
    if ($(this).val() == 'funds') {
        $('#money').show();
    } else {
        $('#money').hide();
    }
});
$('select[name=reason]').change(function () {
    if ($(this).val() == 'volunteer') {
        $('#service').show();
    } else {
        $('#service').hide();
    }
});
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