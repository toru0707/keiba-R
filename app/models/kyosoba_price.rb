class KyosobaPrice < ActiveRecord::Base
  self.table_name = :JVD_KYOSOBA_TORIHIKI_KAKAKU

  # 対象馬の最大取引価格
  def max_price ketto_code
    begin
      KyosobaPrice.find_by_KETTO_TOROKU_BANGO(ketto_code).order("TORIHIKI_KAKAKU desc").first 
    rescue
      # 対象馬が存在しない
      return nil
    end
  end
end
