class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :tagline
      t.text :bio
      t.string :treehouse_profile
      t.string :linkedin
      t.string :twitter
      t.string :github
      t.text :quote

      t.timestamps
    end
  end
end
