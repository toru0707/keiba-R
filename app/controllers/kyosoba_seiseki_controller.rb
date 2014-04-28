class KyosobaSeisekiController < ApplicationController
  def index
    render json: KyosobaSeiseki.all()
  end

  def show 
    @kyosobaSeiseki = KyosobaSeiseki.find(params[:id])
    render json: self.add_sumary_seiseki(@kyosobaSeiseki)
  end

  def find_by_bamei
    @kyosobaSeiseki = KyosobaSeiseki.find(self.get_id_by_bamei(params[:bamei]))
    render json: self.add_sumary_seiseki(@kyosobaSeiseki)
  end

  def add_sumary_seiseki seiseki
    return {seiseki: seiseki, kyakushitsu_keiko: seiseki.kyakushitsu_keiko, nyushoritsu_by_shiba: seiseki.nyushoritsu_by_shiba, nyushoritsu_by_dirt: seiseki.nyushoritsu_by_dirt, nyushoritsu_by_short: seiseki.nyushoritsu_by_short, nyushoritsu_by_middle: seiseki.nyushoritsu_by_middle, nyushoritsu_by_long: seiseki.nyushoritsu_by_long}
  end

  def get_id_by_bamei bamei
    begin
      return Kyosoba.where(:BAMEI => params[:bamei]).first.KETTO_TOROKU_BANGO
    rescue
      return nil
    end
  end
end
