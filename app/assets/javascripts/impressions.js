$(function(){
  function buildHTML(impression){
    let html = `<div class="impression">
    <a href=/users/${impression.user_id}>${impression.user_name}</a>
    ：
    ${impression.comment}
    </div>`
    $('.booksShow__impressions__impression').append(html);
  }
  $('.impression-submit').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      buildHTML(data);
      $('.impression-textarea').val('');
      $('.impression-submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})