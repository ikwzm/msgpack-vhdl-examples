require 'msgpack'

class Requester

  def request(msgid, method, params)
    msg  = [0, msgid, method, params].to_msgpack.each_byte.map{|ch| sprintf("0x%02X",ch)}.join(',')
    snr  = "- I  :\n" << "  - XFER   : {DATA: [#{msg}]}\n"
  end

end
class Responder

  def response(msgid, error, result)
    msg = [1, msgid, error, result].to_msgpack.each_byte.map{|ch| sprintf("0x%02X",ch)}.join(',')
    snr = "- O  :\n" << "  - XFER   : {DATA: [#{msg}], LAST:1}\n"
  end

end

File.open('test_1.snr','w') do |file|

  i = Requester.new
  o = Responder.new

  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "  - SAY    : ZunDoko_Server TEST 1 Start."
  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "  - SAY    : ZunDoko_Server TEST 1.1 Start."
  file.puts "---"
  [0..0].each do |x|
    file.puts "- MARCHAL  : "
    file.puts "  - SAY    : zundoko"
    file.puts "---"
    file.puts i.request( 0x22, "zundoko", [])
    file.puts o.response(0x22, nil      , ['ZUN', 'ZUN', 'DOKO', 'ZUN', 'ZUN', 'ZUN', 'ZUN', 'DOKO', 'KI.YO.SHI!'])
  end
  file.puts "- MARCHAL  : "
  file.puts "- SAY      : ZunDoko_Server TEST 1 Done."
  file.puts "---"
end
