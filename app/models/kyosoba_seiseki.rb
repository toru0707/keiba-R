class KyosobaSeiseki < ActiveRecord::Base
  self.table_name = :JVD_KYOSOBA_SEISEKI
  belongs_to :kyosoba, :foreign_key => "KETTO_TOROKU_BANGO"

  # 統計から脚質の傾向を返す
  # 0: 逃げ, 1: 先行, 2: 差し, 3: 追い込み
  def kyakushitsu_keiko
    h = {'0' =>  self.KYAKUSHITSU_KEIKO_NIGE, '1' => self.KYAKUSHITSU_KEIKO_SENKO, '2' => self.KYAKUSHITSU_KEIKO_SASHI, '3' => self.KYAKUSHITSU_KEIKO_OIKOMI}
    m = h.max {|a,b| a[1] <=> b[1]}
    m[1] = m[1].to_f / [self.KYAKUSHITSU_KEIKO_NIGE, self.KYAKUSHITSU_KEIKO_SENKO, self.KYAKUSHITSU_KEIKO_SASHI, self.KYAKUSHITSU_KEIKO_OIKOMI].inject(:+).to_f
    return m
  end

  #体重の増減差で入賞率を計算する
  #@fugo 増減符号: + , -
  #@daisyo 大か小か: ika, ijo
  #@bataiju 増減値: 
  def nyushoritsu_by_bataiju fugo, daisyo, bataiju
    #血統登録番号から、kyosoba_raceの配列を取得
    nyusyo_num = 0
    race_num = 0
    races = KyosobaRace.where(:KETTO_TOROKU_BANGO => KETTO_TOROKU_BANGO)
    races.each do |race|
      if fugo == "+" then
        if daisyo == "ijo" then
          if ZOGEN_FUGO == "+" && bataiju <= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        elsif daisyo == "ika" then
          if ZOGEN_FUGO == "+" && bataiju >= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        end
      elsif fugo == "-"
        if daisyo == "ijo" then
          if ZOGEN_FUGO == "-" && bataiju <= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        elsif daisyo == "ika" then
          if ZOGEN_FUGO == "-" && bataiju >= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        end
      end
      race_num = race_num + 1
    end 
    return nyusyo_num / race_num
  end

  #負担重量で入賞率を計算する
  #@fugo 増減符号: + , -
  #@daisyo 大か小か: ika, ijo
  #@bataiju 増減値: 
  def nyushoritsu_by_bataiju fugo, daisyo, bataiju
    #血統登録番号から、kyosoba_raceの配列を取得
    nyusyo_num = 0
    race_num = 0
    races = KyosobaRace.where(:KETTO_TOROKU_BANGO => KETTO_TOROKU_BANGO)
    races.each do |race|
      if fugo == "+" then
        if daisyo == "ijo" then
          if ZOGEN_FUGO == "+" && bataiju <= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        elsif daisyo == "ika" then
          if ZOGEN_FUGO == "+" && bataiju >= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        end
      elsif fugo == "-"
        if daisyo == "ijo" then
          if ZOGEN_FUGO == "-" && bataiju <= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        elsif daisyo == "ika" then
          if ZOGEN_FUGO == "-" && bataiju >= ZOGEN_SA then
            nyusho_num = nyusho_num + 1
          end
        end
      end
      race_num = race_num + 1
    end 
    return nyusyo_num / race_num
  end

  #芝レースで3着以内に入る率
  def nyushoritsu_by_shiba
    nyusho_num = [self.SHIBA_CHOKU_1CHAKU, self.SHIBA_CHOKU_2CHAKU, self.SHIBA_CHOKU_3CHAKU, self.SHIBA_MIGI_1CHAKU, self.SHIBA_MIGI_2CHAKU, self.SHIBA_MIGI_3CHAKU, self.SHIBA_HIDARI_1CHAKU, self.SHIBA_HIDARI_2CHAKU, self.SHIBA_HIDARI_3CHAKU].inject(:+)
    return (nyusho_num == 0 ) ? 0 : nyusho_num.to_f / race_num_by_race_type("shiba").to_f
  end

  #ダートレースで3着以内に入る率
  def nyushoritsu_by_dirt
    nyusho_num = [self.DIRT_CHOKU_1CHAKU, self.DIRT_CHOKU_2CHAKU, self.DIRT_CHOKU_3CHAKU, self.DIRT_MIGI_1CHAKU, self.DIRT_MIGI_2CHAKU, self.DIRT_MIGI_3CHAKU, self.DIRT_HIDARI_1CHAKU, self.DIRT_HIDARI_2CHAKU, self.DIRT_HIDARI_3CHAKU].inject(:+)
    return (nyusho_num == 0 ) ? 0 : nyusho_num.to_f / race_num_by_race_type("dirt").to_f
  end

  #1600m以下レースで3着以内に入る率
  def nyushoritsu_by_short
    nyusho_num = [self.SHIBA_SHORT_1CHAKU, self.SHIBA_SHORT_2CHAKU, self.SHIBA_SHORT_3CHAKU, self.DIRT_SHORT_1CHAKU, self.DIRT_SHORT_2CHAKU, self.DIRT_SHORT_3CHAKU].inject(:+)
    return (nyusho_num == 0 ) ? 0 : nyusho_num.to_f / race_num_by_kyori("short").to_f
  end
  
  #2200m以下レースで3着以内に入る率
  def nyushoritsu_by_middle
    nyusho_num = [self.SHIBA_MIDDLE_1CHAKU, self.SHIBA_MIDDLE_2CHAKU, self.SHIBA_MIDDLE_3CHAKU, self.DIRT_MIDDLE_1CHAKU, self.DIRT_MIDDLE_2CHAKU, self.DIRT_MIDDLE_3CHAKU].inject(:+)
    return (nyusho_num == 0 ) ? 0 : nyusho_num.to_f / race_num_by_kyori("middle").to_f
  end
  
  #2200m以上レースで3着以内に入る率
  def nyushoritsu_by_long
    nyusho_num = [self.SHIBA_LONG_1CHAKU, self.SHIBA_LONG_2CHAKU, self.SHIBA_LONG_3CHAKU, self.DIRT_LONG_1CHAKU, self.DIRT_LONG_2CHAKU, self.DIRT_LONG_3CHAKU].inject(:+)
    return (nyusho_num == 0 ) ? 0 : nyusho_num.to_f / race_num_by_kyori("long").to_f
  end

  # @type raceタイプ. shiba, dirt, shogai
  def race_num_by_race_type type 
    race_num = 0
    for i in 1..5 do
      eval("race_num = race_num + self." + type.upcase + "_CHOKU_" + i.to_s + "CHAKU")
      eval("race_num = race_num + self." + type.upcase + "_MIGI_" + i.to_s + "CHAKU")
      eval("race_num = race_num + self." + type.upcase + "_HIDARI_" + i.to_s + "CHAKU")
    end
    eval("race_num =  race_num + self." + type.upcase + "_CHOKU_CHAKUGAI")
    eval("race_num =  race_num + self." + type.upcase + "_MIGI_CHAKUGAI")
    eval("race_num =  race_num + self." + type.upcase + "_HIDARI_CHAKUGAI")
    return race_num
  end

  # @type 馬場タイプ. ryo, yayaomo, omo, furyo
  def race_num_by_baba_type type 
    race_num = 0
    for i in 1..5 do
      eval("race_num = race_num + self.SHIBA_" + type.upcase + "_" + i.to_s + "CHAKU")
      eval("race_num = race_num + self.DIRT_" + type.upcase + "_" + i.to_s + "CHAKU")
      eval("race_num = race_num + self.SHOGAI_" + type.upcase + "_" + i.to_s + "CHAKU")
    end
    eval("race_num =  race_num + self.SHIBA_" + type.upcase + "_CHAKUGAI")
    eval("race_num =  race_num + self.DIRT_" + type.upcase + "_CHAKUGAI")
    eval("race_num =  race_num + self.SHOGAI_" + type.upcase + "_CHAKUGAI")
    return race_num
  end

  # @type レース距離. short, middle, long 
  def race_num_by_kyori type 
    race_num = 0
    for i in 1..5 do
      eval("race_num = race_num + self.SHIBA_" + type.upcase + "_" + i.to_s + "CHAKU")
      eval("race_num = race_num + self.DIRT_" + type.upcase + "_" + i.to_s + "CHAKU")
    end
    eval("race_num =  race_num + self.SHIBA_" + type.upcase + "_CHAKUGAI")
    eval("race_num =  race_num + self.DIRT_" + type.upcase + "_CHAKUGAI")
    return race_num
  end

end
