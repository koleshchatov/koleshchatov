puts "введите а"
a = gets.chomp.to_i

puts "введите b"
b = gets.chomp.to_i

puts "введите c"
c = gets.chomp.to_i

d = b**2 - 4 * a * c

if d.negative?
	puts "корней нет"

elsif d == 1 
	puts "x1 = #{(-b + Math.sqrt(d)) / (2 * a)}"

else 
	puts "x1 = #{(-b + Math.sqrt(d)) / (2 * a)}"
	puts "x2 = #{(-b - Math.sqrt(d)) / (2 * a)}"
end
