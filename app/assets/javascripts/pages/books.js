$(document).on('turbolinks:load', function() {
  $('.reply-textarea').keyup(function() {
    let review_id = $(this).data('review-id');
    let count     = $(this).val().length;
    let tweet_btn = $(`#reply-submit-${review_id}`);
    $(`#length-show-${review_id}`).text("残り" + (140 - count) + "文字");
    if ( count > 140 ) {
      tweet_btn.prop("disabled", true);
    } else {
      tweet_btn.prop("disabled", false);
    }
  });
});
