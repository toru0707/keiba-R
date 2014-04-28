class KyosobaController < ApplicationController
  def index
    render json: Kyosoba.all()
  end

  def show 
    @kyosoba = Kyosoba.find(params[:id])
    render json: @kyosoba 
  end

  def find_by_bamei
    @kyosoba = Kyosoba.where(:BAMEI => params[:bamei])
    render json: @kyosoba
  end

end
