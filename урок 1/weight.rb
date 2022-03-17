puts "Как тебя зовут?"

name = gets.chomp

puts "#{name}, какой у тебя рост, см?"

growth = gets.chomp.to_i

weight = (growth - 110) * 1.15

if weight.positive?
puts " #{name}, Ваш оптимальный вес: #{weight}."

else 
puts "#{name}, Ваш вес уже оптимальный."
end
