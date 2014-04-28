class CreateKyosobaRaces < ActiveRecord::Migration
  def change
    create_table :kyosoba_races do |t|

      t.timestamps
    end
  end
end
