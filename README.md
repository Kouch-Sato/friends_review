# friends_review
## 環境構築
```
$ docker-compose build
$ docker-compose up
$ docker-compose exec app bin/rails db:migrate
$ docker-compose exec app bin/rails db:migrate db:fixtures:load
```

## annotateをする
```
$ docker-compose exec app bundle exec annotate
$ docker-compose exec app bundle exec annotate -r
```

## デプロイ
### 最初の設定
```
$ heroku login
```
### masterをデプロイする時
```
$ git push heroku master
$ heroku run bin/rails db:migrate #必要なら
```

### master以外をデプロイする時
```
$ git push heroku use_heroku:master --force  
```

### 環境変数の設定
```
$ heroku config:add TWITTER_API_SECRET=aaaaaaaaaaaaaaaaaaaaaaa
```

