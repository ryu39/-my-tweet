# MyTweet App

## 必要環境

* Ruby 2.5.1
* bundler
* PostreSQL

## 動かし方

事前に `config/database.yml` をご自分の環境に合わせてセットしてください。

```
$ ruby -v # => 2.5.1

$ bundle install
$ rails db:migrate
$ rails db:seed

$ rails s

$ open http://localhost:3000
```

## 使い方

### ログイン

[http://localhost:3000](http://localhost:3000)

以下の情報でログインできます。

* ユーザーID: `test`
* パスワード: `password`

### ツイート

ツイートを作成するためには、はじめにOAuth 2.0の [Authorization Code Flow](https://tools.ietf.org/html/draft-ietf-oauth-v2-22#section-4.1) に沿ってアクセストークンを取得する必要があります。

認可コードを取得するためのページに必要な情報は以下になります。(redirect_uriは固定です。このURLに合うように実装してください)

* URL: http://localhost:3000/oauth/authorize
* HTTP method: GET
* response_type: `code`
* client_id: `uid`
* redirect_uri: `http%3A%2F%2Flocalhost%3A3000%2Foauth%2Fcallback`
* scope: 未設定

すでにログイン状態している場合、認可するかどうかの画面が開くので「承認」を押してください。下記URLにリダイレクトされます。
（もしログイン画面が開いた場合、ログインして再度認可ページにアクセスさせてください）

`http://localhost:3000/oauth/callback?code=認可コード`

最後にURLパラメーターに含まれている認可コード(code)を使い、アクセストークンを取得してください。
取得に必要と思われる情報は以下になります。

* URL: http://localhost:3000/oauth/token
* HTTP method: POST
* client_id: `uid`
* client_secret: `secret`
* grant_type: `authorization_code`
* redirect_uri: `http%3A%2F%2Flocalhost%3A3000%2Foauth%2Fcallback`

こんな感じのレスポンスが帰ります。

```
{
  "access_token":"xxxxxxxxx",
  "token_type":"bearer",
  "created_at":1529052135
}
```

このアクセストークンをヘッダにつけて [http://localhost:3000/api/tweets](http://localhost:3000/api/tweets) にPOSTすれば、ツイートすることができます。

```
$ access_token=xxxxxxxx
$ curl -v -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $access_token" -d '{"text": "Google", "url": "https://google.co.jp"}' http://localhost:3000/api/tweets
```
