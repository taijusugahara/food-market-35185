# アプリケーション名　FoodMarket

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

- has_many :items
- has_many :orders

# テーブル設計

## corporations テーブル

| Column                | Type   | Options                       |
| ----------------------| ------ | ----------------------------- |
| name                  | string | null: false                   |
| email                 | string | null: false, uniqueness: true |
| encrypted_password    | string | null: false                   |

### Association

- has_many :items

## items テーブル

| Column                | Type       | Options                        |
| ----------------------| ---------- | ------------------------------ |
| name                  | string     | null: false                    |
| category_id           | integer    | null: false                    |
| number                | integer    | null: false                    |
| price                 | integer    | null: false                    |
| customer              | references | null: false, foreign_key: true |
| corporation           | references | null: false, foreign_key: true |

### Association

- belongs_to :customer
- belongs_to :corporation
- has_many :order
- has_many :item_order

## orders テーブル

| Column                | Type   | Options                        |
| ----------------------| ---------- | ------------------------------ |
| customer              | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :customer
- has_many :order
- has_many :item_order
- has_one :address

## item_order テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| order  | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :order

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