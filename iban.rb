class IBAN

  attr_accessor :iban, :country, :check_digits, :bban, :bank, :branch, :account

  CODEPOINTS = ("0".."9").to_a + ("A".."Z").to_a
  MOD97 = [1, 10, 3, 30, 9, 90, 27, 76, 81, 34, 49, 5, 50, 15, 53, 45, 62,
          38, 89, 17, 73, 51, 25, 56, 75, 71, 31, 19, 93, 57, 85, 74, 61]

  def initialize(iban)
    @iban = iban.gsub(/[^A-Za-z0-9]/,"")
    @country = @iban[0,2]
    @check_digits = @iban[2,2]
    @bban = @iban[4..-1]

    case @country
      when "AD":$;=/(^\d{4})(\d{4})(\w{12})$/;@bank,@branch,@account=@bban.split.drop 1
      when "AE":$;=/^(\d{3})(\d{16})$/;@bank,@account=@bban.split.drop 1
      when "AL":$;=/(^\d{3})(\d{4})(\d)(\w{16})$/;@bank,@branch,@check,@account=@bban.split.drop 1
      when "AT":$;=/(^\d{5})(\d{11})$/;@bank,@account=@bban.split.drop 1
      when "AZ":$;=/(^\w{4})(\d{20})$/;@bank,@account=@bban.split.drop 1
      when "BA":$;=/^(\d{3})(\d{3})(\d{8})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "BE":$;=/(^\d{3})(\d{7})(\d{2})$/;@bank,@account,@check=@bban.split.drop 1
      when "BG":$;=/^([A-Z]{4})(\d{4})(\d{2})(\w{8})$/;@bank,@branch,@account_type,@account=@bban.split.drop 1
      when "BH":$;=/^([A-Z]{4})(\w{14})$/;@bank,@account=@bban.split.drop 1
      when "CH":$;=/^(\d{5})(\w{12})$/;@bank,@account=@bban.split.drop 1
      when "CR":$;=/^(\d{3})(\d{14})$/;@bank,@account=@bban.split.drop 1
      when "CY":$;=/^(\d{3})(\d{5})(\w{16})$/;@bank,@branch,@account=@bban.split.drop 1
      when "CZ":$;=/^(\d{4})(\d{6})(\d{10})$/;@bank,@branch,@account=@bban.split.drop 1
      when "DE":$;=/^(\d{8})(\d{10})$/;@bank,@account=@bban.split.drop 1
      when "DK":$;=/^(\d{4})(\d{10})$/;@bank,@account=@bban.split.drop 1
      when "DO":$;=/^([A-Z]{4})(\d{20})$/;@bank,@account=@bban.split.drop 1
      when "EE":$;=/^(\d{2})(\d{2})(\d{11})(\d)$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "ES":$;=/^(\d{4})(\d{4})(\d{2})(\d{10})$/;@bank,@branch,@check,@account=@bban.split.drop 1
      when "FI":$;=/^(\d{6})(\d{7})(\d)$/;@bank,@account,@check=@bban.split.drop 1
      when "FO":$;=/^(\d{4})(\d{9})(\d)$/;@bank,@account,@check=@bban.split.drop 1
      when "FR":$;=/^(\d{5})(\d{5})(\w{11})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "GB":$;=/^([A-Z]{4})(\d{6})(\d{8})$/;@bank,@branch,@account=@bban.split.drop 1
      when "GE":$;=/^(\w{2})(\d{16})$/;@bank,@account=@bban.split.drop 1
      when "GI":$;=/^([A-Z]{4})(\w{15})$/;@bank,@account=@bban.split.drop 1
      when "GL":$;=/^(\d{4})(\d{10})$/;@bank,@account=@bban.split.drop 1
      when "GR":$;=/^(\d{3})(\d{4})(\w{16})$/;@bank,@branch,@account=@bban.split.drop 1
      when "GT":$;=/^(\w{4})(\w{20})$/;@bank,@account=@bban.split.drop 1
      when "HR":$;=/^(\d{7})(\d{10})$/;@bank,@account=@bban.split.drop 1
      when "HU":$;=/^(\d{3})(\d{4})(\d)(\d{15})(\d)$/;@bank,@branch,@check,@account=@bban.split.drop 1 # FIXME
      when "IE":$;=/^(\w{4})(\d{6})(\d{8})$/;@bic,@bank,@account=@bban.split.drop 1
      when "IL":$;=/^(\d{3})(\d{3})(\d{13})$/;@bank,@branch,@account=@bban.split.drop 1
      when "IS":$;=/^(\d{4})(\d{2})(\d{6})(\d{10})$/;@bank,@branch,@account,@ident=@bban.split.drop 1
      when "IT":$;=/^([A-Z])(\d{5})(\d{5})(\w{12})$/;@check,@bank,@branch,@account=@bban.split.drop 1
      when "KW":$;=/^([A-Z]{4})(\d{22})$/;@bank,@account=@bban.split.drop 1
      when "KZ":$;=/^(\d{3})(\w{13})$/;@bank,@account=@bban.split.drop 1
      when "LB":$;=/^(\d{4})(\w{20})$/;@bank,@account=@bban.split.drop 1
      when "LI":$;=/^(\d{5})(\w{20})$/;@bank,@account=@bban.split.drop 1
      when "LT":$;=/^(\d{5})(\d{11})$/;@bank,@account=@bban.split.drop 1
      when "LU":$;=/^(\d{3})(\w{13})$/;@bank,@account=@bban.split.drop 1
      when "LV":$;=/^([A-Z]{4})(\w{13})$/;@bank,@account=@bban.split.drop 1
      when "MC":$;=/^(\d{5})(\d{5})(\w{11})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "MD":$;=/^(\w{2})(\d{18})$/;@bank,@account=@bban.split.drop 1
      when "ME":$;=/^(\d{3})(\d{12})(\d{2})$/;@bank,@account,@check=@bban.split.drop 1
      when "MK":$;=/^(\d{3})(\w{10})(\d{2})$/;@bank,@account,@check=@bban.split.drop 1
      when "MR":$;=/^(\d{5})(\d{5})(\d{11})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "MT":$;=/^([A-Z]{4})(\d{5})(\w{18})$/;@bank,@branch,@account=@bban.split.drop 1
      when "MU":$;=/^([A-Z]{4}\d{2})(\d{2})(\d{15}[A-Z]{3})$/;@bank,@branch,@account=@bban.split.drop 1
      when "NL":$;=/^([A-Z]{4})(\d{10})$/;@bank,@account=@bban.split.drop 1
      when "NO":$;=/^(\d{4})(\d{6})(\d)$/;@bank,@account,@check=@bban.split.drop 1
      when "PK":$;=/^(\w{4})(\d{16})$/;@bank,@account=@bban.split.drop 1 # 12/12
      when "PL":$;=/^(\d{3})(\d{4})(\d)(\d{16})$/;@bank,@branch,@check,@account=@bban.split.drop 1
      when "PS":$;=/^(\w{4})(\d{21})$/;@bank,@account=@bban.split.drop 1
      when "PT":$;=/^(\d{4})(\d{4})(\d{11})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "RO":$;=/^([A-Z]{4})(\w{16})$/;@bank,@account=@bban.split.drop 1
      when "RS":$;=/^(\d{3})(\d{13})(\d{2})$/;@bank,@account,@check=@bban.split.drop 1
      when "SA":$;=/^(\d{2})(\w{18})$/;@bank,@account=@bban.split.drop 1
      when "SE":$;=/^(\d{3})(\d{16})(\d)$/;@bank,@account,@check=@bban.split.drop 1
      when "SI":$;=/^(\d{2})(\d{3})(\d{8})(\d{2})$/;@bank,@branch,@account,@check=@bban.split.drop 1
      when "SK":$;=/^(\d{4})(\d{6})(\d{10})$/;@bank,@branch,@account=@bban.split.drop 1
      when "SM":$;=/^([A-Z])(\d{5})(\d{5})(\w{12})$/;@check,@bank,@branch,@account=@bban.split.drop 1
      when "TN":$;=/^(\d{2})(\d{3})(\d{15})$/;@bank,@branch,@account=@bban.split.drop 1
      when "TR":$;=/^(\d{5})(0\w{17})$/;@bank,@account=@bban.split.drop 1
      when "VG":$;=/^(\w{4})(\d{16})$/;@bank,@account=@bban.split.drop 1
      else initialize(IBAN.guess(@iban))
    end
  end

  def valid?
    return false if [country, check_digits, bank, account].any?(&:nil?)
    iban_check
  end

  def iban_check
    result = 0
    $; = //
    (bban + country + check_digits).split.reverse.map do |d|
      CODEPOINTS.index(d.upcase).to_s.split.reverse
    end.flatten.
    each_with_index {|d,i| result += d.to_i * MOD97[i] }
    result % 97 == 1
  end

  def iban_check_bignum
    (bban + country + check_digits).split(//).map do |d|
      CODEPOINTS.index(d.upcase).to_s
    end.join.to_i % 97 == 1
  end

  def self.guess(iban)
    %w(AD AE AL AT AZ BA BE BG BH CH CR CY CZ DE DK DO EE ES FI FO FR GB GE GI
      GL GR GT HR HU IE IL IS IT KW KZ LB LI LT LU LV MC MD ME MK MR MT MU NL
      NO PK PL PS PT RO RS SA SE SI SK SM TN TR VG).map do |c|
        IBAN.new(c + iban)
      end.select {|c| c.valid? }.first.iban
  end

end

