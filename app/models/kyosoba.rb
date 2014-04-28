class Kyosoba < ActiveRecord::Base
  self.table_name = 'JVD_KYOSOBA_MASTER'
  self.primary_key = 'KETTO_TOROKU_BANGO'
  has_one :kyosoba_seiseki, :foreign_key => "KETTO_TOROKU_BANGO"
  # 0:未設定, 1:牡馬, 2:牝馬, 3:せん馬（去勢したオスウマ)
  alias_attribute :sex, :SEIBETSU_CODE

  # 統計から脚質の傾向を返す
  # 0: 逃げ, 1: 先行, 2: 差し, 3: 追い込み
  def kyakushitsu_keiko
    h = {'0' =>  self.kyosoba_seiseki.KYAKUSHITSU_KEIKO_NIGE, '1' => self.kyosoba_seiseki.KYAKUSHITSU_KEIKO_SENKO, '2' => self.kyosoba_seiseki.KYAKUSHITSU_KEIKO_SASHI, '3' => self.kyosoba_seiseki.KYAKUSHITSU_KEIKO_OIKOMI}
    h.max {|a,b| a[1] <=> b[1]}
  end
end
