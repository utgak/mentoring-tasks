# 1
(1..10).each { |i| puts i }

# 2
input = "Hello"
for i in 0...input.length
  puts input[i].upcase
end

for i in 0...input.length
  puts input[i].downcase
end

# 3

numbers = [10, 20, 30, 40, 50]

for i in 0...numbers.length
  puts "#{numbers[i]} -> #{i}"
end

string = "Hello"

for i in 0...string.length
  puts "#{string[i]} -> #{i}"
end

# 4
class Array
  def my_first
    self[0]
  end

  def my_last
    self[-1]
  end
end

numbers = [10, 20, 30, 40, 50]
puts numbers.my_first
puts numbers.my_last

# 5

def compare_strings(str1, str2)
  return false if str1.length != str2.length

  index = 0

  while index < str1.length
    if str1[index] != str2[index]
      return false
    end
    index += 1
  end

  true
end

string1 = "hello"
string2 = "hello"
string3 = "world"

puts compare_strings(string1, string2)  # => true
puts compare_strings(string1, string3)  # => false

# 6

def translate_day_case(day)
  case day
  when "Monday"
    "понедельник"
  when "Tuesday"
    "вторник"
  when "Wednesday"
    "среда"
  when "Thursday"
    "четверг"
  when "Friday"
    "пятница"
  when "Saturday"
    "суббота"
  when "Sunday"
    "воскресенье"
  else
    "Неизвестный день"
  end
end

puts translate_day_case("Tuesday")
puts translate_day_case("Sunday")
puts translate_day_case("Vacation")

# 7

number = 3

(1..10).each do |i|
  puts "#{i} x #{number} = #{i * number}"
end

# 8

(1..5).each do |i|
  puts "* " * i
end

# 9

i = 1

until i > 5
  puts (1..i).to_a.join(" ")
  i += 1
end

# 10

def month_to_number_case(month)
  case month
  when "January"
    1
  when "February"
    2
  when "March"
    3
  when "April"
    4
  when "May"
    5
  when "June"
    6
  when "July"
    7
  when "August"
    8
  when "September"
    9
  when "October"
    10
  when "November"
    11
  when "December"
    12
  else
    "Неизвестный месяц"
  end
end

# 11

def swap_first_and_last_char(str)
  return str if str.length <= 1

  first_char = str[0]
  last_char = str[-1]
  middle = str[1...-1]

  last_char + middle + first_char
end

puts swap_first_and_last_char("hello")

# 12

def middle_character(str)
  length = str.length

  return nil if length == 0

  middle_index = (length - 1) / 2
  str[middle_index]
end

puts middle_character("hello") # => "l"
puts middle_character("abcdef")  # => "c"

# 13

def print_pyramid(height)
  if height < 1 || height > 9
    return
  end

  (1..height).each do |i|
    puts " " * (height - i) + "* " * i
  end
end

number = 8
print_pyramid(number)

# 14

def print_number_pyramid(height)
  if height < 1 || height > 9
    return
  end

  (1..height).each do |i|
    spaces = " " * (height - i)
    numbers = (1..i).to_a.join(" ")
    puts spaces + numbers
  end
end

number = 9
print_number_pyramid(number)

# 15

def leap_year?(year)
  if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    true
  else
    false
  end
end

[1999, 1000, 1600, 1700, 2000, 2024, 2100].each {|y| puts y.to_s + ' ' + leap_year?(y).to_s }

