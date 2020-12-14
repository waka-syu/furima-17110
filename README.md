# テーブル設計

## users テーブル

| Column     | Type    | Options     |
| ---------- | ------  | ----------- |
| nickname   | string  | null: false |
| email      | string  | null: false |
| password   | string  | null: false |
| last_name  | string  | null: false |
| first_name | string  | null: false |
| last_kana  | string  | null: false |
| first_kana | string  | null: false |
| birth_date | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| text            | text       | null: false                    |
| state           | string     | null: false                    |
| category        | string     | null: false                    |
| fee             | string     | null: false                    |
| delivery_source | string     | null: false                    |
| delivery_date   | string     | null: false                    |
| value           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| credit_num   | integer    | null: false                    |
| credit_date  | integer    | null: false                    |
| security_num | integer    | null: false                    |
| postal_code  | integer    | null: false                    |
| region       | string     | null: false                    |
| city         | string     | null: false                    |
| address_line | string     | null: false                    |
| phone_num    | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item