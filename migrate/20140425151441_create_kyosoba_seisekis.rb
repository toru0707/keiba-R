class CreateKyosobaSeisekis < ActiveRecord::Migration
  def change
    create_table :kyosoba_seisekis do |t|

      t.timestamps
    end
  end
end
