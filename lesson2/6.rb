backet = {}
result = 0

puts "Enter stop to end"
loop do
  puts "Enter name"
  name = gets.chomp
  break if name == "stop"
  puts "Enter price"
  price = gets.chomp.to_f
  puts "Enter count"
  count = gets.chomp.to_f
  backet[name] = {price => count}
end

backet.each do |name, price|
  puts "#{name} cost is #{price.keys.first * price.values.first}"
  result += price.keys.first * price.values.first
end

puts "Total sum is: #{result}"
