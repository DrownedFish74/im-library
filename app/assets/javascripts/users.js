$(function() {
  function addUser(user) {
    let html = `
    <div class="result">
    <a href="/users/${user.id}/bookshelves" class="result__name">${user.name}の本棚</a>
    <div class="user-search-add" data-user-name = "${user.name}" data-user-id="${user.id}"><a href="#">友達申請を送る</a></div>
    </div>
    `;
    $("#user-search-result").append(html);
  }
  
  function addNoUser() {
    let html = `
    <div class="result">
    <p class="user-search-add">ユーザーが見つかりません</p>
    </div>
    `;
    $("#user-search-result").append(html);
  }
  
  function friendWish(userId,userName){
    let html = `
    <div class="friendsPopup__form--info">
    <input type="hidden" name="wish[for_id]" value="${userId}"></input>
    <input type="hidden" name="wish[status]" value="wait"></input>
    <input type="hidden" name="wish[purpose]" value="friend"></input>
    <p>${userName}さんに友達申請を送ります</p>
    </div>
    `;
    $(".friendsPopup__form").append(html);
  }
  

  
  $("#user-search-field").on("keyup", function() {
    let input = $("#user-search-field").val();
    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })
    .done(function(users) {
      $("#user-search-result").empty();
      if (users.length !== 0) {
        users.forEach(function(user) {
          addUser(user)
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoUser();
        return false;
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    });
  });
  
  $(document).on("click", ".user-search-add", function() {
    const userName = $(this).attr("data-user-name");
    const userId = $(this).attr("data-user-id");
    $(".friendsPopup__form__info").remove
    friendWish(userId,userName)
    $(".friendsPopup").addClass("show")
  });
  
  $(document).on("click", ".friendsPopup__close", function() {
    $(".friendsPopup").removeClass("show")
  });
  
});