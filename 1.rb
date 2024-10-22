# 1
i = 1
while i <= 10 do
  puts i
  i += 1
end

i = 1
until i > 10 do
  puts i
  i += 1
end

for i in 1..10 do
  puts i
end

for i in 1..10 do
  puts i
end

(1..10).each do |i|
  puts i
end


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
  day = day.capitalize
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

def translate_day_if(day)
  day = day.capitalize
  if day == "Monday"
    "понедельник"
  elsif day == "Tuesday"
    "вторник"
  elsif day == "Wednesday"
    "среда"
  elsif day == "Thursday"
    "четверг"
  elsif day == "Friday"
    "пятница"
  elsif day == "Saturday"
    "суббота"
  elsif day == "Sunday"
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

i = 1
while i <= 10 do
  puts "#{i} x #{number} = #{i * number}"
  i += 1
end

until i > 10 do
  puts "#{i} x #{number} = #{i * number}"
  i += 1
end

for i in 1..10 do
  puts "#{i} x #{number} = #{i * number}"
end

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

def month_to_number_if(month)
  month = month.capitalize

  if month == "January"
    1
  elsif month == "February"
    2
  elsif month == "March"
    3
  elsif month == "April"
    4
  elsif month == "May"
    5
  elsif month == "June"
    6
  elsif month == "July"
    7
  elsif month == "August"
    8
  elsif month == "September"
    9
  elsif month == "October"
    10
  elsif month == "November"
    11
  elsif month == "December"
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
  middle_index = (length - 1) / 2
  str[middle_index]
end

puts middle_character("abc") # => "b"
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

# 16

def fizz_buzz(n)
  (1..n).each do |i|
    if i % 15 == 0
      puts "FizzBuzz"
    elsif i % 3 == 0
      puts "Fizz"
    elsif i % 5 == 0
      puts "Buzz"
    else
      puts i
    end
  end
end

number = 30
fizz_buzz(number)

# 17

def find_words_by_first_letter(words, letter)
  matched_words = []

  letter.downcase!

  words.each do |word|
    if word.downcase[0] == letter
      matched_words << word
    end
  end

  matched_words
end

words_list = ["apple", "banana", "age", "avocado", "blueberry", "cherry", "date", "fig", "grape", "kiwi"]

print "Input letter for search: "
input_letter = gets.chomp

puts find_words_by_first_letter(words_list, input_letter)

# 18

def reverse_string(str)
  reversed = ""
  index = str.length - 1

  while index >= 0
    reversed += str[index]
    index -= 1
  end

  reversed
end

puts reverse_string('hello')

# 19

def palindrome?(str)
  compare_strings(str, reverse_string(str))
end

# 20

def check_numbers(numbers)
  numbers.each do |number|
    if number > 0
      puts "#{number} is positive."
    elsif number < 0
      puts "#{number} is negative."
    else
      puts "#{number} is zero."
    end
  end
end

numbers_list = [1, -1, 0, 5, -3, 2, -7, 4, 0, -2]

check_numbers(numbers_list)

# 21

def range(num1, num2)
  if num1 < num2
    current = num1
    while current <= num2
      puts current
      current += 1
    end
  else
    current = num1
    while current >= num2
      puts current
      current -= 1
    end
  end
end

num1 = 10
num2 = 1

puts "Numbers from #{num1} to #{num2}:"
range(num1, num2)

# 22

def sum(numbers)
  total = 0
  numbers.each do |number|
    total += number
  end
  total
end

numbers_array = [-10, 10, 5, 5, 50]

result = sum(numbers_array)
puts result

# 23

def print_full_pyramid(height)
  (1..height).each do |i|
    numbers = (1..i).to_a.join("")
    stars = "*" * i

    puts "#{numbers}#{stars}"
  end
end

height = 6
print_full_pyramid(height)

# 24

def longest_sequence(arr)
  max_sequence = []
  current_sequence = []

  arr.each do |num|
    if current_sequence.empty? || current_sequence.last == num
      current_sequence << num
    else
      if current_sequence.length > max_sequence.length
        max_sequence = current_sequence
      end
      current_sequence = [num]
    end
  end

  max_sequence = current_sequence if current_sequence.length > max_sequence.length

  max_sequence
end

numbers = [1, 2, 3, 1, 1, 1, 2, 2, 4, 5, 6, 5, 5]

result = longest_sequence(numbers)
puts "Longest number subsequence: #{result.inspect}"

# 25

def longest_letter_sequence(str)
  max_sequence = []
  current_sequence = []

  str.split('') do |char|
    if current_sequence.empty? || current_sequence.last == char
      current_sequence << char
    else
      max_sequence = current_sequence if current_sequence.length > max_sequence.length
      current_sequence = [char]
    end
  end

  max_sequence = current_sequence if current_sequence.length > max_sequence.length

  max_sequence
end

input_string = "aaabbccddddeeefffggghhh"
result = longest_letter_sequence(input_string).join
puts "Longest letter subsequence: '#{result}'"

# 27

def play_game
  loop do
    choices = { 1 => "rock", 2 => "scissors", 3 => "paper" }
    
    puts "Choose:\n1. Rock\n2. Scissors\n3. Paper\n0. Exit"
    user_input = gets.chomp.to_i

    break if user_input == 0
    
    unless choices[user_input]
      puts "Invalid choice. Please choose 1, 2, 3 or 0."
      next
    end

    user_choice = choices[user_input]
    computer_choice = choices.values.sample
    puts "Computer chose: #{computer_choice}"

    if user_choice == computer_choice
      puts "It's a tie!"
    elsif (user_choice == "rock" && computer_choice == "scissors") ||
          (user_choice == "scissors" && computer_choice == "paper") ||
          (user_choice == "paper" && computer_choice == "rock")
      puts "You win!"
    else
      puts "You lose!"
    end
    puts "\n" * 3
  end
end

# 28

def boom(number)
  while number > 0
    sleep(1)
    puts number
    puts 'Explosion coming soon' if number == 3
    puts 'Boom' if number == 1
    number -= 1
  end
end

print "Enter the time in seconds for the countdown: "
input_number = gets.to_i

boom(input_number)

# 29

def calculator(a, b, operator)
  return unless %w[+ - * % /].include? operator

  result = a.to_f.public_send(operator, b.to_f)
  puts a.to_s + operator + b.to_s + '=' + result.to_s
end

# 30

def number_guessing_game
  secret_number = rand(1..100)
  attempts = 3
  guessed = false

  puts "Guess a number between 1 and 100. You have 3 attempts."

  (1..attempts).each do |i|
    print "Attempt #{i}: Enter your guess: "
    guess = gets.to_i

    if guess == secret_number
      puts "Congratulations! You guessed the number #{secret_number}!"
      guessed = true
      break
    elsif guess < secret_number
      puts "Higher!"
    else
      puts "Lower!"
    end
  end

  puts "You've run out of attempts. The secret number was #{secret_number}." unless guessed
end

number_guessing_game
