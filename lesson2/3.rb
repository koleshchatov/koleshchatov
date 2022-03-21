fibbonachi = [0, 1]

while (fibbonachi.last + fibbonachi[fibbonachi.count - 2]) < 100
  fibbonachi << fibbonachi.last + fibbonachi[fibbonachi.count - 2]
end

puts fibbonachi
