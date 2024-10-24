require 'time'

# Вместо each_with_index
def my_each_with_index(array)
  return unless block_given?

  index = 0
  while index < array.length
    yield(array[index], index)
    index += 1
  end
  array
end

# Функция для обработки ошибок
def with_error_handling
  yield
rescue => e
  puts "Произошла ошибка: #{e.message}"
end

# Функция для запроса ввода пользователя
def request_input(prompt)
  print "#{prompt}: "
  gets.chomp
end

# Обработчик операций с файлами
def handle_file(file_name, mode)
  with_error_handling do
    File.open(file_name, mode) { |file| yield(file) if block_given? }
  end
end

# Чтение файла построчно с опциональной индексацией
def read_file(file_name, with_index: false)
  handle_file(file_name, 'r') do |file|
    my_each_with_index(File.readlines(file_name)) do |line, index|
      output = with_index ? "#{index}: #{line.chomp}" : line
      puts output
    end
  end
end

# Запись текста в файл
def write_to_file(file_name, text, mode = 'w')
  handle_file(file_name, mode) { |file| file.puts(text) }
  puts "Операция завершена для файла '#{file_name}'."
end

# Показать статистику файла (количество строк и символов)
def file_statistics(file_name)
  with_error_handling do
    line_count = File.readlines(file_name).size
    char_count = File.size(file_name)
    puts "Количество строк: #{line_count}, Количество символов: #{char_count}"
  end
end

# Копировать содержимое из одного файла в другой
def copy_file(source_file, target_file)
  write_to_file(target_file, read_file(source_file))
  puts "Файл успешно скопирован!"
end

# Удалить файл
def delete_file(file_name)
  if request_input("Вы хотите удалить файл '#{file_name}'? (да/нет)").downcase == 'да'
    with_error_handling do
      File.delete(file_name)
      puts "Файл '#{file_name}' был успешно удален."
    end
  else
    puts "Файл '#{file_name}' не был удален."
  end
end

# Реверс массива
def reverse_array(arr)
  reversed = []
  
  i = arr.length - 1
  while i >= 0
    reversed << arr[i]
    i -= 1
  end
  
  reversed
end

# Реверс содержимого файла
def reverse_file_content(source_file, target_file)
  reversed_content = []

  File.readlines(source_file).each do |line|
    reversed_content << line.reverse
  end

  reversed_content = reverse_array(reversed_content)

  write_to_file(target_file, reversed_content.join)
end

# Сгенерировать уникальное имя файла на основе даты и времени
def generate_unique_filename
  date = Time.now.strftime("%Y-%m-%d")
  time = Time.now.strftime("%H-%M-%S")
  "#{date}_#{time}_note.txt"
end

# Создать новую заметку с текущей датой и уникальным меткой времени
def create_note
  file_name = generate_unique_filename
  content = request_input("Введите содержимое заметки")
  write_to_file(file_name, content)
end

# Показать список заметок с тегом по умолчанию 'note' и предложить пользователю выбрать одну
def show_notes
  selected_file = list_notes_with_selection
  if selected_file
    puts "Показ содержимого '#{selected_file}':"
    read_file(selected_file)
  end
end

# Список заметок и выбор заметки пользователем
def list_notes_with_selection
  note_files = Dir.glob("*_note.txt")

  if note_files.empty?
    puts "Заметки не найдены."
    return nil
  else
    puts "Список заметок:"
    my_each_with_index(note_files) do |file_name, index|
      puts "#{index + 1}. #{file_name}"
    end

    choice = request_input("Выберите заметку по номеру").to_i
    if choice >= 1 && choice <= note_files.size
      return note_files[choice - 1]
    else
      puts "Неверный выбор."
      return nil
    end
  end
end

def files_menu
  loop do
    puts "\nВыберите действие:"
    puts "1. Прочитать файл построчно"
    puts "2. Прочитать файл с номерами строк"
    puts "3. Записать текст в файл"
    puts "4. Добавить текст в файл"
    puts "5. Скопировать файл"
    puts "6. Удалить файл"
    puts "7. Реверс содержимого файла"
    puts "8. Показать количество строк и символов"
    puts "9. Выйти"
    choice = gets.chomp.to_i

    if choice == 1
      read_file(request_input("Введите имя файла"), with_index: false)
    elsif choice == 2
      read_file(request_input("Введите имя файла"), with_index: true)
    elsif choice == 3
      write_to_file(request_input("Введите имя файла"), request_input("Введите текст для записи"))
    elsif choice == 4
      write_to_file(request_input("Введите имя файла"), request_input("Введите текст для добавления"), 'a')
    elsif choice == 5
      copy_file(request_input("Введите исходное имя файла"), request_input("Введите целевое имя файла"))
    elsif choice == 6
      delete_file(request_input("Введите имя файла"))
    elsif choice == 7
      reverse_file_content(request_input("Введите исходное имя файла"), request_input("Введите целевое имя файла"))
    elsif choice == 8
      file_statistics(request_input("Введите имя файла"))
    elsif choice == 9
      puts "Выход из программы."
      exit
    else
      puts "Неверный выбор. Попробуйте снова."
    end
  end
end

# Главное меню программы
def notes_menu
  loop do
    puts "\nВыберите действие:"
    puts "1. Создать новую заметку"
    puts "2. Показать заметки"
    puts "3. Редактировать заметку"
    puts "4. Удалить заметку"
    puts "5. Выйти"

    choice = gets.chomp.to_i

    case choice
    when 1
      create_note
    when 2
      show_notes
    when 3
      file_name = list_notes_with_selection
      if file_name
        new_content = request_input("Введите новое содержимое заметки:")
        write_to_file(file_name, new_content, 'w')
      end
    when 4
      file_name = list_notes_with_selection
      delete_file(file_name) if file_name
    when 5
      puts "Выход из программы."
      exit
    else
      puts "Неверный выбор. Попробуйте снова."
    end
  end
end

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
