# 1

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

begin
  File.open(file_name, 'r') do |file|
    puts file.read
  end
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 2

puts "Введите текст для записи в файл:"
text = gets.chomp

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

begin
  File.open(file_name, 'w') do |file|
    file.write(text)
  end
  puts "Текст успешно записан в файл '#{file_name}'."
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 3

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

begin
  File.readlines(file_name).each_with_index do |line, index|
    puts "#{index + 1}: #{line.chomp}"
  end
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 4

puts "Введите имя исходного файла:"
source_file = gets.chomp

puts "Введите имя целевого файла:"
target_file = gets.chomp

begin
  File.open(source_file, 'r') do |source|
    File.open(target_file, 'w') do |target|
      target.write(source.read)
    end
  end
  puts "Копирование завершено успешно!"
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 5

puts "Введите текст для добавления в файл:"
text = gets.chomp

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

begin
  File.open(file_name, 'a') do |file|
    file.puts(text)
  end
  puts "Текст успешно добавлен в файл '#{file_name}'."
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 6

def read_file(file_name)
  if File.exist?(file_name)
    File.foreach(file_name).with_index(1) do |line, index|
      puts "#{index}: #{line.chomp}"
    end
  else
    puts "Ошибка: файл '#{file_name}' не найден."
  end
end

def append_to_file(file_name)
  puts "Введите текст для добавления в файл:"
  text = gets.chomp
  File.open(file_name, 'a') do |file|
    file.puts(text)
  end
  puts "Текст успешно добавлен в файл '#{file_name}'."
end

def file_statistics(file_name)
  if File.exist?(file_name)
    line_count = File.readlines(file_name).size
    char_count = File.size(file_name)
    puts "Количество строк: #{line_count}"
    puts "Количество символов: #{char_count}"
  else
    puts "Ошибка: файл '#{file_name}' не найден."
  end
end

def main_menu
  file_name = ""

  loop do
    puts "\nВыберите действие:"
    puts "1. Прочитать файл"
    puts "2. Добавить строку в файл"
    puts "3. Вывести количество строк и символов в файле"
    puts "4. Выйти из программы"
    
    choice = gets.chomp.to_i

    case choice
    when 1
      puts "Введите имя файла (с расширением):"
      file_name = gets.chomp
      read_file(file_name)
    when 2
      puts "Введите имя файла (с расширением):"
      file_name = gets.chomp
      append_to_file(file_name)
    when 3
      puts "Введите имя файла (с расширением):"
      file_name = gets.chomp
      file_statistics(file_name)
    when 4
      puts "Выход из программы."
      break
    else
      puts "Неверный выбор."
    end
  end
end

main_menu

# 7 

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

if File.exist?(file_name)
  puts "Файл '#{file_name}' существует."
  puts "Вы хотите удалить этот файл? (да/нет)"
  choice = gets.chomp.downcase

  if choice == 'да'
    File.delete(file_name)
    puts "Файл '#{file_name}' был успешно удален."
  else
    puts "Файл '#{file_name}' не был удален."
  end
else
  puts "Ошибка: файл '#{file_name}' не найден."
end

# 7

puts "Введите имя файла (с расширением):"
file_name = gets.chomp

if File.exist?(file_name)
  puts "Файл '#{file_name}' существует."
  puts "Вы хотите удалить этот файл? (да/нет)"
  choice = gets.chomp.downcase

  if choice == 'да'
    File.delete(file_name)
    puts "Файл '#{file_name}' был успешно удален."
  else
    puts "Файл '#{file_name}' не был удален."
  end
else
  puts "Ошибка: файл '#{file_name}' не найден."
end

# 8

puts "Введите имя исходного файла:"
source_file = gets.chomp

puts "Введите имя целевого файла:"
target_file = gets.chomp

begin
  content = File.read(source_file)
  reversed_content = content.reverse

  File.open(target_file, 'w') do |target|
    target.write(reversed_content)
  end

  puts "Реверсирование завершено успешно!"
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# 9

def play_game
  loop do
    choices = { 1 => "камень", 2 => "ножницы", 3 => "бумага" }
    user_wins = 0
    computer_wins = 0

    puts "Начинаем новую игру! Первый до 3 побед!"
    
    while user_wins < 3 && computer_wins < 3
      puts "Выберите:\n1. Камень\n2. Ножницы\n3. Бумага\n0. Выход"
      user_input = gets.chomp.to_i

      break if user_input == 0

      unless choices[user_input]
        puts "Неверный выбор. Пожалуйста, выберите 1, 2, 3 или 0."
        next
      end

      user_choice = choices[user_input]
      computer_choice = choices.values.sample
      puts "Компьютер выбрал: #{computer_choice}"

      if user_choice == computer_choice
        puts "Ничья!"
      elsif (user_choice == "камень" && computer_choice == "ножницы") ||
            (user_choice == "ножницы" && computer_choice == "бумага") ||
            (user_choice == "бумага" && computer_choice == "камень")
        puts "Вы выиграли этот раунд!"
        user_wins += 1
      else
        puts "Вы проиграли этот раунд!"
        computer_wins += 1
      end

      puts "Счет: Вы #{user_wins} - Компьютер #{computer_wins}\n\n"
    end

    if user_wins == 3
      puts "Поздравляю! Вы - общий победитель!"
    elsif computer_wins == 3
      puts "Извините, компьютер выиграл в общем."
    end

    puts "Хотите сыграть еще раз?\n1. Да\n2. Нет"
    play_again = gets.chomp
    return unless play_again == '1'
  end
end
