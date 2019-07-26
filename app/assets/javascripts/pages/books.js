$(document).on('turbolinks:load', function() {
  $('#afterApproveModal').on('show.bs.modal', function (event) {
    var button         = $(event.relatedTarget); //モーダルを呼び出すときに使われたボタンを取得
    var review_type    = button.data('review-type')
    var review_content = button.data('review-content');
    var tweet_url      = button.data('tweet-url');
    var review_id      = button.data('review-id');
    var approve_path   = button.data('approve-path');
    var modal          = $(this);  //モーダルを取得
    modal.find('.review-content').text(review_type + review_content)
    modal.find('textarea').val("\n" + tweet_url + " #みんなの通信簿");
    modal.find('.hidden-review-id').val(review_id);
    modal.find('.btn-review-approve').attr('href', approve_path);
  })

  $('#reply-textarea').keyup(function() {
    var count = $(this).val().length;
    $('#textlength').text("残り" + (140 - count) + "文字");
    var tweet_button = $('#reply-submit');
    if ( count > 140 ) {
      tweet_button.prop("disabled", true);
    } else {
      tweet_button.prop("disabled", false);
    }
  });
});
