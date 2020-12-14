# テーブル設計

## users テーブル

| Column               | Type    | Options                   |
| -------------------- | ------  | ------------------------- |
| nickname             | string  | null: false               |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| last_name            | string  | null: false               |
| first_name           | string  | null: false               |
| last_kana            | string  | null: false               |
| first_kana           | string  | null: false               |
| birth_date           | date    | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| text            | text       | null: false                    |
| state_id        | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| fee_id          | integer    | null: false                    |
| prefectures_id  | integer    | null: false                    |
| date_id         | integer    | null: false                    |
| value           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| phone_num    | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| address      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address

## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefectures_id  | integer    | null: false                    |
| city            | string     | null: false                    |
| address_line    | string     | null: false                    |
| address_line2   | string     | null: false                    |

### Association

- has_one :purchase