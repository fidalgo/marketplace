class CreateSkillings < ActiveRecord::Migration
  def change
    create_table :skillings do |t|
      t.references :skill, index: true
      t.references :worker, index: true
      t.datetime :created_at
    end
  end
end
