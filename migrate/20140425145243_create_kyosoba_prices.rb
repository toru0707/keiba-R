class CreateKyosobaPrices < ActiveRecord::Migration
  def change
    create_table :kyosoba_prices do |t|

      t.timestamps
    end
  end
end
