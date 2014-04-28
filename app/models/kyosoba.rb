class Kyosoba < ActiveRecord::Base
  self.table_name = 'JVD_KYOSOBA_MASTER'
  self.primary_key = 'KETTO_TOROKU_BANGO'
  has_one :kyosoba_seiseki, :foreign_key => "KETTO_TOROKU_BANGO"
  # 0:未設定, 1:牡馬, 2:牝馬, 3:せん馬（去勢したオスウマ)
  alias_attribute :sex, :SEIBETSU_CODE

end
