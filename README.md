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


<strong id="following" class="stat">
...
</strong>
こうしておくと、14.2.5でAjaxを実装するときに便利。

has_many :followeds, through: :active_relationships
Railsは「followeds」というシンボル名を見て、これを「followed」という単数形に変え、 relationshipsテーブルのfollowed_idを使って対象のユーザーを取得してきます。しかし、14.1.1で指摘したように、user.followedsという名前は英語として不適切です。代わりに、user.followingという名前を使いましょう。そのためには、Railsのデフォルトを上書きする必要があります。ここでは:sourceパラメーター (リスト 14.8) を使って、「following配列の元はfollowed idの集合である」ということを明示的にRailsに伝えます。

リスト 14.8: Userモデルにfollowingの関連付けを追加する
app/models/user.rb
 class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  .
  .
  .
end

def create
  post_user_id = Picture.find(params[:picture_id]).user_id
  if post_user_id != current_user.id
    current_user.likes.create(picture_id: params[:picture_id])
    @picture = Picture.find(params[:picture_id])
  end
end

def destroy
  post_user_id = Picture.find(params[:picture_id]).user_id
  if post_user_id != current_user.id
    current_user.likes.find_by(picture_id: params[:picture_id]).destroy
    @picture = Picture.find(params[:picture_id])
  end
end

<% if picture.like_user(current_user.id) %>
<% like_id = picture.likes.find_by(user_id: current_user.id).id %>
<!-- @likes = @picture.likes で、 pictureがlikeしたidがわかり、likeされたpicture.idを削除する-->
  <%= button_to picture_like_path(likes, picture_id: picture.id), method: :delete, id: "like-button",
    class: "btn btn-default btn-xs", remote: true do %>
      <%= content_tag :span, "#", class: "glyphicon glyphicon-heart" %>
       <span>
        <%= picture.likes_count %>
      </span>
  <% end %>
<% else %>
  <%= button_to picture_likes_path(picture), id: "like-button", class: "btn btn-default btn-xs",
    remote: true do %>
      <%= content_tag :span, "#", class: "glyphicon glyphicon-heart-empty" %>
        <span>
          <%= picture.likes_count %>
        </span>
    <% end %>
<% end %>



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
