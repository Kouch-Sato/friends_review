class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :book_id
      t.integer :review_type
      t.string :content
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
