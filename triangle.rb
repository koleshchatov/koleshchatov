puts "введите x"

x = gets.chomp.to_i

puts "введите y"

y = gets.chomp.to_i

puts "введите z"

z = gets.chomp.to_i

if x ** 2 == y ** 2 + z ** 2 or y ** 2 == x ** 2 + z ** 2 or z ** 2 == x ** 2 + y ** 2
  puts "Треугольник прямоугольный"

elsif x == y and x == z
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"

elsif x == y or x == z or y == z
  puts "Треугольник равносторонний"

else puts "Непрямоугольный, неравнобедренный и неравносторониий"

end