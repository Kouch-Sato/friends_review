module ApplicationHelper
  def default_meta_tags
    {
      site: 'みんなの通信簿',
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: '匿名で、普段の様子についての成績をつけられるサービスです！',
      keywords: 'みんなの通信簿, 通信簿, みんなの通知表, friends review, 他己評価',
      separator: '|',
      og: {
        site_name: :site,
        title: 'みんなの通信簿',
        description: '記入する/結果を見る',
        type: 'website',
        url: request.original_url,
        image: image_url('book_sample.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@ツイッターのアカウント名',
      }
    }
  end

  # admin_meta_tagsを設置する可能性あり
end
