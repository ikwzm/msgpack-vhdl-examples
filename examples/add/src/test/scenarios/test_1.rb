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
  file.puts i.request( 0x21, "ADD" , [16,17])
  file.puts o.response(0x21, nil, 33)
  file.puts "---"
  file.puts i.request( 0x22, "ADD" , [-1,17])
  file.puts o.response(0x22, nil, 16)
  file.puts "---"
  file.puts i.request( 0x23, "ADD" , [500,300])
  file.puts o.response(0x23, nil, 800)
  file.puts "---"
  file.puts i.request( 0x23, "ADD" , [100000,-100001])
  file.puts o.response(0x23, nil, -1)
  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "- SAY      : Add_Server TEST 1 Done."
  file.puts "---"
end
