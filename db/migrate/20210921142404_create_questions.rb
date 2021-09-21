class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :descripton, null: false
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
