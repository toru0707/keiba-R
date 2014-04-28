class CreateKishus < ActiveRecord::Migration
  def change
    create_table :kishus do |t|

      t.timestamps
    end
  end
end
