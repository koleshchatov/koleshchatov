ALPHABET = ('a'..'z').to_a
volwes = ["a", "o", "e", "u", "i", "y"]
result = {}


ALPHABET.each do |letter|
 if volwes.include?(letter)
  result[letter] = ALPHABET.index(letter) + 1
 end
end

puts result
