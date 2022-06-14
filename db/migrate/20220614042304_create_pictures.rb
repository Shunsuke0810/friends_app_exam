class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.text :content
      t.text :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
