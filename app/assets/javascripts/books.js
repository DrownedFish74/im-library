$(function() {
  $('.getBookInfo').click( function( e ) {
    e.preventDefault();
    const isbn = $(".booksNew__form--ISBN").val();
    const url = "https://api.openbd.jp/v1/get?isbn=" + isbn;
    
    $.getJSON( url, function( data ) {
      if( data[0] == null ) {
        alert("データが見つかりません");
      } else {
        if( data[0].summary.cover == "" ){
          $("#thumbnail").html('<img src=\"\" />');
        } else {
          $("#thumbnail").html('<img src=\"' + data[0].summary.cover + '\" style=\"border:solid 1px #000000\" />');
        }
        $(".booksNew__form--title").val(data[0].summary.title);
        $(".booksNew__form--publisher").val(data[0].summary.publisher);
        $(".booksNew__form--author").val(data[0].summary.author);
        $(".booksNew__form--cover").val(data[0].summary.cover);
        $(".booksNew__form--description").val(data[0].onix.CollateralDetail.TextContent[0].Text);
      }
    });
  });
});