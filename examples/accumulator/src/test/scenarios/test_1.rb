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
  file.puts "  - SAY    : Add_Server TEST 1 Start."
  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "  - SAY    : Add_Server TEST 1.1 Start."
  file.puts "---"
  [0,1,5,127,128,255,256,32768,65536,-1,-127,-128,-255,-256,-32768,-65536].each do |reg|
    file.puts "- MARCHAL  : "
    file.puts "  - SAY    : set #{reg}"
    file.puts "---"
    file.puts i.request( 0x21, "$SET" , [{"reg" => reg}])
    file.puts o.response(0x21, nil    , nil)
    file.puts "---"
    [0,1,5,127,128,255,256,32768,65536,-1,-127,-128,-255,-256,-32768,-65536].each do |x|
      reg = reg + x
      file.puts "- MARCHAL  : "
      file.puts "  - SAY    : add #{x} => #{reg}"
      file.puts "---"
      file.puts i.request( 0x22, "add"  , [x])
      file.puts o.response(0x22, nil    , reg)
      file.puts "---"
      file.puts i.request( 0x21, "$GET" , [{"reg" => nil}])
      file.puts o.response(0x21, nil    , [{"reg" => reg}])
      file.puts "---"
    end
  end
  file.puts "- MARCHAL  : "
  file.puts "- SAY      : Add_Server TEST 1 Done."
  file.puts "---"
end
