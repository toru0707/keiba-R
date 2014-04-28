class KyosobaRace < ActiveRecord::Base
  self.table_name = :JVD_UMAGOTO_RACE_JOHO
  alias_attribute :tansho_odds, :TANSHO_ODDS
  alias_attribute :futan_juryo, :FUTAN_JURYO  
  alias_attribute :barei, :BAREI 
  alias_attribute :kakutei_chakujun, :KAKUTEI_CHAKUJUN
end
