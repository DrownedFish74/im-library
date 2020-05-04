$(function(){
  function buildHTML(impression){
    var html = `<p>
    <a href=/users/${impression.user_id}>${impression.user_name}</a>
    ：
    ${impression.text}
    </p>`
    return html;
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
      var html = buildHTML(data);
      $('.bookShow__impressions__impression').append(html);
      $('.impression-textarea').val('');
      $('.impression-submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})