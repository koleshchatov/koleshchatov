puts "введите x"

x = gets.chomp.to_i

puts "введите y"

y = gets.chomp.to_i

puts "введите z"

z = gets.chomp.to_i

triangle = [x, y, z].sort

k1 = triangle.last
k2 = triangle [0]
k3 = triangle [1]

if k1**2 == k2**2 + k3**2
  puts "Треугольник прямоугольный" 

elsif k1 == k2 && k1 == k3
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"

elsif k1 == k2 || k1 == k3 || k2 == k3
  puts "Треугольник равносторонний"

else puts "Непрямоугольный, неравнобедренный и неравносторониий"
end
