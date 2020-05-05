$(function() {
  // 本移動のときの追加
  function addBooks(book) {
    let html = `
    <div class="bookshelvesPopup__form__book">
    <p class="bookshelvesPopup__form__book--name">${book.title}</p>
    <input type="hidden" name="bookshelf[book_ids][]" value="${book.id}"></div>
    `;
    $(".bookshelvesPopup__moveBook").append(html);
  }
  
  // 本移動先
  function addStatus(status,moveto){
    let html = `
    <input class="bookshelvesPopup__form__status" type="hidden" name="status" value="${status}">
    <p>以上の本を${moveto}に移動しますか？</p>
    `;
    $(".bookshelvesPopup__moveBook").append(html);
  }
  
  // 申請のときの本追加
  function addWishBooks(book) {
    let html = `
    <div class="bookshelvesWishPopup__form__book">
    <p class="bookshelvesWishPopup__form__book--name">${book.title}</p>
    <input type="hidden" name="wish[book_ids][]" value="${book.id}">
    </div>
    `;
    $(".bookshelvesWishPopup__add").append(html);
  }
  
  // 貸出申請のときのインフォ
  function addBorrowInfo(for_id) {
    let html = `
    <div class="bookshelvesWishPopup__form--info">
    <input type="hidden" name="wish[for_id]" value="${for_id}">
    <input type="hidden" name="wish[purpose]" value="borrow"></div>
    <div class="bookshelvesWishPopup__form--day">
    返却予定日
    <input type="date" name="wish[deadline]"></input>
    </div>
    `;
    $(".bookshelvesWishPopup__add").append(html);
  }

  // 返却申請のときのインフォ
  function addReturnInfo(for_id) {
    let html = `
    <div class="bookshelvesWishPopup__form--info">
    <input type="hidden" name="wish[for_id]" value="${for_id}">
    <input type="hidden" name="wish[purpose]" value="return"></div>
    `;
    $(".bookshelvesWishPopup__add").append(html);
  }
  
  // 本棚表示切替
  let tabs = $(".all-bookshelves__menu__item");
  function tabSwitch() {
    $(".active").removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".bookshelves__shelf").removeClass("show").eq(index).addClass("show");
    $(".move-check").prop("checked",false)
  }
  tabs.click(tabSwitch);
  
  // 本棚移動ボタン
  $(".book__move").on("click",function(){
    let moveBooksId = []
    let moveBooks = $(".move-check")
    moveBooks.each(function(i,moveBook){
      if ($(moveBook).prop("checked") == true){
        moveBooksId.push($(moveBook).attr("value"))
      }
    })
    userid = $(this).attr("data-user-id")
    status = $(this).attr("data-book-status")
    $.ajax({
      type: "GET",
      url: "/users/" + $(".book__move").attr("data-user-id")+ "/books",
      data: { bookids: moveBooksId },
      dataType: "json"
    })
    .done(function(books){
      books.forEach(function(book){
        addBooks(book)
      })
      if (status == "close"){
        addStatus(status,"書庫")
      }else{
        addStatus(status,"開架")
      }
      $(".bookshelvesPopup").addClass("show")
    })
  })
  
  // 貸出申請ボタン
  $(".book__borrow").on("click",function(){
    let moveBooksId = []
    let moveBooks = $(".move-check")
    moveBooks.each(function(i,moveBook){
      if ($(moveBook).prop("checked") == true){
        moveBooksId.push($(moveBook).attr("value"))
      }
    })
    for_id = $(this).attr("data-bookshelf-id")
    $.ajax({
      type: "GET",
      url: "/users/" + $(".book__borrow").attr("data-bookshelf-id")+ "/books",
      data: { bookids: moveBooksId },
      dataType: "json"
    })
    .done(function(books){
      books.forEach(function(book){
        addWishBooks(book)
      })
      addBorrowInfo(for_id)
      $(".bookshelvesWishPopup").addClass("show")
    })
  })
  
  $(".bookshelvesPopup__close").on("click",function(){
    location.href=location.href
  })
  
  $(".return-check").change(function(){
    if ($(this).prop("checked")){
      ownerId = $(this).attr("data-owner-id")
      returnCheck = $(".return-check")
      returnCheck.each(function(i,check){
        if ($(check).attr("data-owner-id") != ownerId) {
          $(check).prop("checked",false)
        }
      })
    }
    
// 返却申請
    $(".book__return").on("click",function(){
      let moveBooksId = []
      let moveBooks = $(".return-check")
      moveBooks.each(function(i,moveBook){
        if ($(moveBook).prop("checked") == true){
          moveBooksId.push($(moveBook).attr("value"))
        }
      })
      for_id = $(moveBooks).attr("data-owner-id")
      $.ajax({
        type: "GET",
        url: "/users/" + $(".book__return").attr("data-user-id")+ "/books",
        data: { bookids: moveBooksId },
        dataType: "json"
      })
      .done(function(books){
        books.forEach(function(book){
          addWishBooks(book)
          console.log(book)
        })
        addReturnInfo(for_id)
        $(".bookshelvesWishPopup").addClass("show")
      })
    })
    // else {
    //   if ($(".return-check").prop("checked") == false {
    
    //   }
    // }
  }
  )
  
  
});
