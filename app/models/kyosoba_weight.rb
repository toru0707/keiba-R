class KyosobaWeight < ActiveRecord::Base
  self.table_name = :JVD_BATAIJU
  belongs_to :kyosoba_race, :foreign_key => "UMABAN"
end
