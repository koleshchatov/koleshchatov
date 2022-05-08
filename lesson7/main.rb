require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Interface

  def initialize
    @stations_user_all = []
    @trains_user_all = []
    @routes_user_all = []
  end  

  def menu 
    loop do
      puts "Выберите доступную опцию:
      1-создать станцию
      2-создать поезд
      3-создать маршрут поезду
      4-добавить станцию в маршрут
      5-удалить станцию из маршрута
      6-назначить маршрут поезду
      7-прицепить вагон к поезду
      8-отцепить вагон от поезда
      9-переместить поезд вперед по маршруту
      10-переместить поезд назад по маршруту
      11-посмотреть список станций
      12-посмотреть список поездов на станции
      13-посмотреть список вагонов у поезда
      14-занять место в вагоне
      0-выйти из программы"
      number = gets.chomp.to_i
      start_program(number)
    end  
  end

  def start_program(number)
    case number
    when 1 
      create_station
    when 2 
      create_train
    when 3 
      create_route
    when 4 
      add_station_route
    when 5 
      delete_station_rout
    when 6 
      add_route_train
    when 7 
      add_wagon_train
    when 8 
      delete_wagon_train
    when 9 
      forward_train
    when 10 
      back_train
    when 11 
      stations_user_all
    when 12 
      train_in_station
    when 13
      list_wagons
    when 14
      get_seat
    when 0 
      puts 'До свидания!'
      exit
    end
  end 

  def create_station
    puts "Вы выбрали 'Создать станцию'. Для этого введите название станции:"
    name = gets.chomp
    station_user = Station.new(name)
    @stations_user_all << station_user
  rescue Exception => e
    puts "#{e.message}. Попробуйте снова создать станцию."
  end

  def create_train
    puts "Вы выбрали 'Создать поезд'. Для этого выберите тип поезда какой хотите создать:
    1 - Пассажирский
    2 - Грузовой"
    type_train = gets.chomp.to_i
    puts "введите номер поезда"
    number_train = gets.chomp
    train_user = case type_train
    when 1
      PassengerTrain.new(number_train)
    when 2
      CargoTrain.new(number_train)
    end  
    @trains_user_all << train_user
  rescue Exception => e
    puts "#{e.message}. Попробуйте снова создать поезд."
  end

  def create_route
    puts "Вы выбрали 'Создать маршрут поезду'. Для этого введите
    начальную станцию маршрута:"
    starting_station_user = gets.chomp
    starting_station = Station.new(starting_station_user)
    @stations_user_all << starting_station
    puts "конечную станцию маршрута:"
    end_station_user = gets.chomp
    end_station = Station.new(end_station_user)
    @stations_user_all << end_station
    route_user = Route.new(starting_station, end_station)
    @routes_user_all << route_user
  rescue Exception => e
    puts "#{e.message}. Попробуйте снова создать маршрут."
  end

  def add_station_route
    if @routes_user_all.any?
      puts "Вы выбрали 'Добавить станцию в маршрут'. Для этого выберите маршрут в который хотите добавить станцию:"
      @routes_user_all.each_with_index do
        |routes, index|
        print index
        print ": "
        puts routes
      end
      index_user_route = gets.chomp.to_i
      puts "Введите название станции какую хотите добавить"
      name = gets.chomp
      user_station = Station.new(name)
      @stations_user_all << user_station
      @routes_user_all[index_user_route].add_station(user_station)
    else 
      puts "Сначало создайте маршрут поезда"
    end
  end

  def delete_station_rout
    if @routes_user_all.any? 
      puts "Вы выбрали 'Удалить станцию из маршрута'. Для этого выберите номер маршрута из которого хотите удалить станцию:"
      @routes_user_all.each_with_index do
        |routes, index|
        print index
        print ": "
        puts routes
      end
      index_user_route = gets.chomp.to_i
      if @routes_user_all[index_user_route].intermediate_stations.any? 
        puts "Выберите станцию которую хотите удалить:"
        @routes_user_all[index_user_route].intermediate_stations.each_with_index do
          |stations, index|
          print index
          print ": "
          puts stations.name
        end
        index_user_station = gets.chomp.to_i
        @routes_user_all[index_user_route].delete_stations(index_user_station)
      else 
        puts "Нет станций которые можно удалить из  маршрута!"
      end
    else 
      puts "Сначалa создайте маршрут поезда!"
    end
  end

  def add_route_train
    if @trains_user_all.any? 
      puts "Вы выбрали 'Назначить маршрут поезу'. Для этого выберите поезд которому хотите назначить маршрут:"
      @trains_user_all.each_with_index do
        |trains, index|
        print index
        print ": "
        puts trains
      end
      index_user_train = gets.chomp.to_i
      if @routes_user_all.any?
        puts "Выберите маршрут который хотите добавить:"
        @routes_user_all.each_with_index do
          |routes, index|
          print index
          print ": "
          puts routes
        end
        index_user_route = gets.chomp.to_i
        @trains_user_all[index_user_train].train_route(@routes_user_all[index_user_route])
      else 
        puts "Нет маршрута который можно добавить. Создайте маршрут!"
      end
    else 
      puts "Сначалa создайте поезд!"
    end
  end

  def add_wagon_train
    puts "Вы выбрали 'прицепить вагон к поезду'. Для этого выберите тип вагона какой хотите прицепить:
    1 - Пассажирский
    2 - Грузовой"
    type_wagon = gets.chomp.to_i
    puts "Для пассажирского вагона задайте количество мест" if type_wagon == 1
    puts "Для грузового вагона задайте обьем вагона" if type_wagon == 2
    params = gets.chomp.to_i
    wagon_user = case type_wagon
    when 1
      PassengerWagon.new(params)
    when 2
      CargoWagon.new(params)
    end 
    if @trains_user_all.any?
      puts "Выберите поезд к которому хотите прицепить вагон"
      @trains_user_all.each_with_index do
        |trains, index|
        print index
        print ": "
        puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].plus_wagon(wagon_user)
      else
       puts "Остановите поезд или поменяйте тип вагона"
      end
    else 
      puts "Нет поезда к которому можно прицепить вагон. Создайте поезд!"
    end
  end

  def delete_wagon_train
    if @trains_user_all.any?
      puts "Выберите поезд от которого хотите отцепить вагон"
      @trains_user_all.each_with_index do
        |trains, index|
        print index
        print ": "
        puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].wagon.any? 
        puts "Выберите вагон который хотите отцепить"
        @trains_user_all[index_user_train].wagon.each_with_index do
          |wagon, index|
          print index
          print ": "
          puts wagon
        end
        index_user_wagon = gets.chomp.to_i
        if @trains_user_all[index_user_train].minus_wagon(index_user_wagon)
        else
          puts "Остановите поезд!"
        end  
      else 
        puts "У этого поезда нет вагонов"
      end
    else 
      puts "Нет поезда от которого можно отцепить вагон. Создайте поезд!"
    end
  end

  def forward_train
    if @trains_user_all.any? 
      puts "Вы выбрали 'Переместить поезд вперед по маршруту'. Для этого выберите поезд который хотите продвинуть:"
      @trains_user_all.each_with_index do
        |trains, index|
        print index
        print ": "
        puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].next_station.nil?
        puts "Вы на конечной станции"
      elsif @trains_user_all[index_user_train].forward_train
      else 
        puts "У поезда нет маршрута! Присвойте маршрут"
      end
    else 
      puts "Сначалa создайте поезд!"
    end
  end

  def back_train
    if @trains_user_all.any?
      puts "Вы выбрали 'Переместить поезд назад по маршруту'. Для этого выберите поезд который хотите переместить:"
      @trains_user_all.each_with_index do
        |trains, index|
        print index
        print ": "
        puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].previous_station.nil?
        puts "Вы на начальной станции"
      elsif @trains_user_all[index_user_train].back_train
      else 
        puts "У поезда нет маршрута! Присвойте маршрут"
      end
    else 
      puts "Сначалa создайте поезд!"
    end
  end

  def stations_user_all
    if @stations_user_all.any?
      @stations_user_all.each_with_index do
        |station, index|
        puts "#{index += 1} - #{station.name}"
      end
    else 
      puts "Нет ни одной станции"
    end
  end

  def train_in_station
    if @stations_user_all.any?
      @stations_user_all.each do
        |station|
        puts "#{station.name} - Поезд №: #{station.trains.map {|trains| trains.number}}"
      end
    else 
      puts "Нет ни одной станции"
    end
  end

  def list_wagons
    if @trains_user_all.any?
      puts "Выберите поезд у которго хотите посмотреть спиcок вагонов:"
      @trains_user_all.each_with_index do |trains, index|
      print index
      print ": "
      puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].wagon.any?
        num = 0
        block_train = Proc.new {|wagon| wagon.each {|wagon| puts "Номер вагона № #{num += 1},"+  
        "Тип вагона - #{wagon.type} , Количество свободных мест - #{wagon.free_seats},"+
         "Количество занятых мест - #{wagon.occupited_places}"}} if @trains_user_all[index_user_train].type == :passenger
        block_train = Proc.new {|wagon| wagon.each {|wagon| puts "Номер вагона № #{num += 1},"+
        "Тип вагона - #{wagon.type} , Количество свободного обьема - #{wagon.free_volume},"+ 
        "Количество занятого обьема - #{wagon.all_occupited_volume}"}} if @trains_user_all[index_user_train].type == :cargo
        @trains_user_all[index_user_train].block_train(&block_train)
      else
          puts "У поезда нет вагонов! Добавьте вагоны"
      end
    else 
      puts "Нет поезда у которого можно посмотреть вагоны"
    end
    menu
  end
  
  def get_seat
    if @trains_user_all.any?
      puts "Выберите поезд в вагоне которого хотите занять место:"
      @trains_user_all.each_with_index do |trains, index|
      print index
      print ": "
      puts trains
      end
      index_user_train = gets.chomp.to_i
      if @trains_user_all[index_user_train].wagon.any?
      puts "Выберите вагон в котором хотите занять место:"
      @trains_user_all[index_user_train].wagon.each_with_index do |wagon, index|
        print index
        print ": "
        puts wagon
        end
        index_user_wagon = gets.chomp.to_i
        if @trains_user_all[index_user_train].type == :passenger
        @trains_user_all[index_user_train].wagon[index_user_wagon].take_seats
        else
          puts "Введите количество обьема которое хотите занять:"
          occupited_volume = gets.chomp.to_i
        @trains_user_all[index_user_train].wagon[index_user_wagon].occupited_volume(occupited_volume)
        end
      else puts "У поезда нет вагонов"
      end
    else puts "Нет поезда в вагоне которого можно занять место"
    end
  end
end

interface = Interface.new
interface.menu
    