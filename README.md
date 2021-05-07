# アプリケーション名　
FoodMarket

# アプリケーション概要

当アプリケーションは食品ネットショッピングアプリケーションです。食品の売買は企業間と消費者間によって行われるためユーザー機能を二つに分けております。一つは商品を出品できる企業、もう一方は商品を購入できる消費者。消費者は商品をカートに入れることによって複数の商品を購入ページにてカード情報と住所情報を入力することで購入することが出来ます。

# URL
[FoodMarket](https://food-market-35185.herokuapp.com/)

# テスト用アカウント
<div>
  <div>ログイン機能</div>
  <div><strong>企業ログイン</strong></div>
  <div>email:　corporation@1234.com</div>
  <div>password:　corporation/corporation1234</div>
  <div><strong>消費者ログイン</strong></div>
  <div>email: 1@1</div>
  <div>password: 1a1a1a</div>
</div>
<!-- 
# 利用方法
企業としてログインすれば商品を出品することができます。
消費者としてログインすれば商品をカートに入れて購入することができます。 -->

# 制作背景
わざわざスーパーに行かなくともお家で食品を注文し購入できるようにしました。
その際商品を一つずつ購入するのはとても手間なので複数の商品を一括で購入できるようにしました。
またこのアプリケーションを作りたいと思った背景には、プログラミングスクールの最終課題で作ったフリマアプリが関係しています。フリマアプリは個人間で行われるものであり、誰でも商品を出品出来て誰でも商品を購入出来ました。ですので今度は個人間ではなくて企業と消費者間で行われるネットショッピング、つまりは企業は出品できるが購入できず消費者は出品出来ないが購入できるアプリケーションを作りたいと思ったからです。

# 洗い出した要件
[スプレッドシート](https://docs.google.com/spreadsheets/d/1w7BKQGipT6zWaOVzTDgcRJs9JfU_LdhtXkQ6hFcuyDY/edit#gid=282075926)

# 実装した機能
トップページには企業が出品した商品の一覧があります。この際商品は出品時に登録したカテゴリー別に分類しております。
またトップページには企業のログインページとお客の新規登録ページ・ログインページがあります。
[![Image from Gyazo](https://i.gyazo.com/a947c73b4c9f4dd20c6eedf873f68b67.gif)](https://gyazo.com/a947c73b4c9f4dd20c6eedf873f68b67)

見てお分かりの通り企業側には新規登録ページを作っておりません。予めemailとパスワードを設定しているので、そのemailとパスワードでログインしていただきます。このようにした理由は企業の新規登録ページを作ってしまうと誰でも企業として商品を出品できてしまうからです。その状況を防ぐために企業のemailとパスワードは1つだけに設定しました。

[企業]
そして企業側でログインしますと出品するリンクが現れ、商品を出品できます。
[![Image from Gyazo](https://i.gyazo.com/743c99d8e7f84a20b5d0612119014278.gif)](https://gyazo.com/743c99d8e7f84a20b5d0612119014278)

出品した商品をクリックしますとその商品の詳細ページに行き、商品を編集または削除できます。
[![Image from Gyazo](https://i.gyazo.com/6e2307901c9000d8cfec4ac93c6531a3.gif)](https://gyazo.com/6e2307901c9000d8cfec4ac93c6531a3)

[客]
客側でログインしますと出品するリンクがありません。商品をクリックすると編集・削除ではなく、カートに入れるリンクがあります。
[![Image from Gyazo](https://i.gyazo.com/f5a01b2976ac5678d5ed703b4d83824b.gif)](https://gyazo.com/f5a01b2976ac5678d5ed703b4d83824b)

購入する数を入力してカートに入れるをクリックするとカート内に商品が入ります。カート内には複数の商品を入れることが出来ます。商品ごとに合計金額が表示され、カート内全ての合計金額もお支払い金額として算出されます。またカート内で商品の数を変更する・商品を取り消すことが出来ます。さらにカートの中身を空にすることも出来ます。
[![Image from Gyazo](https://i.gyazo.com/244db2bf81f99788c6eb74d0968820be.gif)](https://gyazo.com/244db2bf81f99788c6eb74d0968820be)

カート内から購入ページに行くことができ、カード情報と住所の情報を入力すると商品を購入することが出来ます。料金はpay.jpへと支払われます。
[![Image from Gyazo](https://i.gyazo.com/546d7a711a5c437ed052bc4507507321.gif)](https://gyazo.com/546d7a711a5c437ed052bc4507507321)

# アプリケーションで工夫したところ
このアプリケーションのポイントはユーザー機能を二つに分けたこととカート機能だと思っています。
ユーザー機能の企業側に関して、emailとパスワードを設定するのにdbのseeds.rbを利用しました。これによりそのemailとパスワード以外でログインすることは出来ません。README.md内では企業のemailとパスワードを記述しましたが、seeds.rb内では環境変数においています。
そしてこのアプリケーションの一番のポイントはカート機能です。これにはセッションの機能を利用しております。私はこのカート機能が作れず、一時挫折して別のアプリケーションを作っておりました。別のアプリケーションを作る中、このアプリケーションを作れないのが悔しかったので、もう一度挑戦してみようと挑戦したところ無事作れることが出来ました。なぜ作るのかが出来た背景には私が一人で考えて作ることに慣れてきたからだと思います。そして今までとは別の視点で考えられるようになったことです。例えばで言いますと、当初はカート内の商品の数を変更する機能を作ろうとしていたのですが、これをやめました。というのももう一度商品をカートに入れる作業を行い数を上書きしてあげれば、実質変更機能になると気づいたからです。

# アプリケーションの課題
このアプリケーションはトップページの情報量が多いため、10分ほど作業しているとmysqlの無料枠である1時間に使えるクエリを消費してしまいます。その結果「We're sorry...」の画面が表示され1時間の間再び使用することが出来ないです。この問題を解決するには商品の数を減らしてクエリの負担を抑えるか、mysqlを有料化するかだと考えます。予期せぬ問題ですが、これによって改めてデータベース周りの重要性を認識しました。



# テーブル設計

## customers テーブル

| Column                | Type   | Options                       |
| ----------------------| ------ | ----------------------------- |
| name                  | string | null: false                   |
| email                 | string | null: false, uniqueness: true |
| encrypted_password    | string | null: false                   |
| first_name            | string | null: false                   |
| last_name             | string | null: false                   |
| first_name_kana       | string | null: false                   |
| last_name_kana        | string | null: false                   |
| birthday              | date   | null: false                   |

### Association


- has_many :orders

# テーブル設計

## corporations テーブル

| Column                | Type   | Options                       |
| ----------------------| ------ | ----------------------------- |
| email                 | string | null: false, uniqueness: true |
| encrypted_password    | string | null: false                   |

### Association

- has_many :items

## items テーブル

| Column                | Type       | Options                        |
| ----------------------| ---------- | ------------------------------ |
| name                  | string     | null: false                    |
| category_id           | integer    | null: false                    |
| price                 | integer    | null: false                    |
| corporation           | references | null: false, foreign_key: true |

### Association


- belongs_to :corporation
- has_many :item_carts

## carts テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |


### Association

- has_many :item_carts
- has_one :order

## item_carts テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| quantity | integer    | null: false                    |
| item     | references | null: false, foreign_key: true |
| cart     | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :cart

## orders テーブル

| Column                | Type   | Options                        |
| ----------------------| ---------- | ------------------------------ |
| customer              | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :customer
- belongs_to :cart
- has_one :address



## addresses テーブル

| Column                | Type       | Options                        |
| ----------------------| ---------- | ------------------------------ |
| postal_code           | string     | null: false                    |
| prefecture_id         | integer    | null: false                    |
| town                  | string     | null: false                    |
| residence             | string     | null: false                    |
| building              | string     |                                |
| tell_number           | string     | null: false                    |
| order                 | references | null: false, foreign_key: true |

### Association

- belongs_to :order

# ローカルでの動作方法
## 環境　
macOS Big Sur バージョン11.2.2にインストールしたRuby 2.6.5を使っています。


## コマンド
% git clone https://github.com/taijusugahara/food-market-35185.git
% cd food-market-35185
% bundle install
% yarn install
% rails db:create
% rails db:migrate
% rails s