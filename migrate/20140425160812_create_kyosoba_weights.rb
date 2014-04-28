class CreateKyosobaWeights < ActiveRecord::Migration
  def change
    create_table :kyosoba_weights do |t|

      t.timestamps
    end
  end
end
