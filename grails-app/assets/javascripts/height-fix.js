var bookTitleTag = $('.book-title');
$.each(bookTitleTag, function () {
    var bookTitle = $(this).text().trim();
    var bookTitleLength = bookTitle.length;
    if(bookTitleLength > 15){
        $(this).html(bookTitle.substr(0,15) +"<br/>.........")
    }else{
        $(this).html(bookTitle +"<br/><br/>")
    }
});

$('.book-item').on('mouseover', function () {
    $(this).find('.book-title').next().removeClass('d-none');
    $(this).find('.book-title').addClass('d-none');
});
$('.book-item').on('mouseout', function () {
    $(this).find('.book-title').next().addClass('d-none');
    $(this).find('.book-title').removeClass('d-none');
});