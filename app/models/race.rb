class Race < ActiveRecord::Base
  self.table_name = :JVD_RACE_SHOSAI
  self.primary_key = :RACE_CODE
end
