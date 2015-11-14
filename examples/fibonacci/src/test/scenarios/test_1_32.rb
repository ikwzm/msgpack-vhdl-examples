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

fib = Array.new
(0..42).to_a.each do |n|
  if n <= 1
    fib[n] = n
  else
    fib[n] = fib[n-2] + fib[n-1]
  end
end

File.open('test_1_32.snr','w') do |file|

  i = Requester.new
  o = Responder.new

  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "  - SAY    : Fibonacci_Server TEST 2 Start."
  file.puts "---"
  file.puts "- MARCHAL  : "
  file.puts "  - SAY    : Fibonacci_Server TEST 2.1 Start."
  file.puts "---"
  fib.each_index do |n|
    f = fib[n]
    file.puts "- MARCHAL  : "
    file.puts "  - SAY    :  TEST 1.1 #{n} => #{f}."
    file.puts i.request( 0x22, "fib"  , [n])
    file.puts o.response(0x22, nil    ,  f )
    file.puts "---"
  end
  file.puts "- MARCHAL  : "
  file.puts "- SAY      : Fibonacci_Server TEST 2 Done."
  file.puts "---"
end
