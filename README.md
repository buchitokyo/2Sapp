# README
１．記憶トークンにはランダムな文字列を生成して用いる。
２．ブラウザのcookiesにトークンを保存するときには、有効期限を設定する。
３．トークンはハッシュ値に変換してからデータベースに保存する。
４．ブラウザのcookiesに保存するユーザーIDは暗号化しておく。
５．永続ユーザーIDを含むcookiesを受け取ったら、そのIDでデータベースを検索し、
　　記憶トークンのcookiesがデータベース内のハッシュ値と一致することを確認する。

remember_digest  のカラム追加（usersテーブル）



remember機能
(1)Userモデルの仮想的な属性(attr_accessor :remember_token)に設定する。
これは実際にはDBには保存されないが、cookiesには（20年期限付きで）保存される
トークンのハッシュをDBの remember_digest カラムに保存する。なお、
ユーザーのパスワード検証とは別の話なのでバリデーションを通らないようにupdate_attributeメソッドを用いて保存する。

(2)一方 cookiesに対しては、（署名付き、20年期限付き）ユーザーIDと（20年期限付き）トークンを記憶。つまり永続cookiesを作成

(1)と(2)でユーザーを永続的セッションに記憶したことになる

ユーザーがログインするときにsessions_controller.rbのcreateアクションによりログイン認証後にrememberヘルパーメソッドにユーザーが渡される
rememberヘルパーメソッドの中にはUserモデルのインスタンスメソッドuser.rememberが呼び出されており、user.rememberメソッドはユーザーインスタンスに記憶ダイジェストを持たせる
その後、rememberヘルパーメソッドではcookiesに永続化と暗号化されたユーザーIDと、永続化された（ユーザーの）記憶トークンが入れられる

そしてログイン状態を調べる、つまり現在のログインユーザーを調べる段階になったら、
一時セッションがあればそこからログインユーザーを判別し、
なければ、永続的セッションのユーザーを判別し内部的にログインしておく（一時セッションを張り直す）
cookiesからユーザーとトークン（cookies[:remember_token]）を取り出し、DBの記憶ダイジェスト（remember_digest）
と一致することを確認する


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
