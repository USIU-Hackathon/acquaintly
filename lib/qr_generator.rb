class QrGenerator
  def initialize(user_id)
    @id = user_id
  end

  def generate
    qr_code_img = RQRCode::QRCode.new("http://0.0.0.0:4000/users/#{@id}", :size => 4, :level => :h ).to_img
    qr_code_img.resize(290,290).save("public/#{@id}.png")
  end
end