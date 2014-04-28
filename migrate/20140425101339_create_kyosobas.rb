class CreateKyosobas < ActiveRecord::Migration
  def change
    create_table :kyosobas do |t|

      t.timestamps
    end
  end
end
