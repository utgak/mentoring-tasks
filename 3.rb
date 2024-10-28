require_relative '2.rb'

CLASSES_FILE = 'classes.txt'
STUDENTS_FILE = 'students.txt'
SUBJECTS_FILE = 'subjects.txt'
GRADES_FILE = 'grades.txt'

def main_menu
  loop do
    puts "\n=== Main Menu: Classes ==="
    print_classes

    puts "\nSelect a class by number, or choose an action:"
    puts "a) Add class"
    puts "d) Delete class"
    puts "e) Edit class"
    puts "q) Quit"
    choice = request_input("Enter your choice")

    case choice
    when 'q' then exit
    when 'a' then add_class
    when 'd' then delete_class
    when 'e' then edit_class
    else
      class_id = choice.to_i
      if valid_class_id?(class_id)
        class_menu(class_id)
      else
        puts "Invalid class ID."
      end
    end
  end
end

def class_menu(class_id)
  puts "\n=== Class Menu for Class ID #{class_id} ==="
  print_students(class_id)

  puts "\nSelect a student by number, or choose an action:"
  puts "a) Add student"
  puts "d) Delete student"
  puts "e) Edit student"
  puts "b) Back to Main Menu"
  choice = request_input("Enter your choice")

  case choice
  when 'b' then return
  when 'a' then add_student(class_id)
  when 'd' then delete_student(class_id)
  when 'e' then edit_student(class_id)
  else
    student_id = choice.to_i
    if valid_student_id?(class_id, student_id)
      student_menu(class_id, student_id)
    else
      puts "\nInvalid student ID."
      class_menu(class_id)
    end
  end
end

def student_menu(class_id, student_id)
  puts "\n=== Student Menu ==="
  display_subjects_with_avg(class_id, student_id)

  puts "\nSelect a subject by number, or choose an action:"
  puts "a) Add subject"
  puts "d) Delete subject"
  puts "e) Edit subject"
  puts "b) Back to Class Menu"
  choice = request_input("Enter your choice")

  case choice
  when 'b'
    class_menu(class_id)
  when 'a'
    add_subject(class_id, student_id)
  when 'd'
    delete_subject(class_id, student_id)
  when 'e'
    edit_subject(class_id, student_id)
  else
    subject_id = choice.to_i
    if valid_subject_id?(subject_id)
      subject_menu(class_id, student_id, subject_id)
    else
      puts "\nInvalid subject ID."
      student_menu(class_id, student_id)
    end
  end
end

def valid_subject_id?(id)
  subject_ids = handle_file(SUBJECTS_FILE, 'r') do |file|
    file.readlines.map { |line| line.split(',').first.to_i }
  end
  true if subject_ids.include?(id)
end

def subject_menu(class_id, student_id, subject_id)
  puts "\n=== Subject Menu ==="

  grades_hash = load_grades
  display_grades(student_id, subject_id, grades_hash)

  puts "\nChoose an action:"
  puts "a) Add grade"
  puts "d) Delete grade"
  puts "e) Edit grade"
  puts "b) Back to Student Menu"
  choice = request_input("Enter your choice")

  case choice
  when 'b'
    student_menu(class_id, student_id)
  when 'a'
    add_grade(class_id, student_id, subject_id)
  when 'd'
    delete_grade(grades_hash, class_id, student_id, subject_id)
  when 'e'
    edit_grade(grades_hash, class_id, student_id, subject_id)
  else
    puts "\n Invalid input"
    subject_menu(class_id, student_id, subject_id)
  end
end

def print_classes
  each_line(CLASSES_FILE) do |line|
    id, name = line.split(',')
    puts "#{id}). #{name.strip}"
  end
end

def print_students(class_id)
  puts "\nStudents in Class #{class_id}:"
  each_line(STUDENTS_FILE) do |line|
    student_id, student_class_id, name = line.split(',')
    if student_class_id.to_i == class_id
      puts "#{student_id}). #{name.strip}"
    end
  end
end

def display_grades(student_id, subject_id, grades_hash)
  my_each_with_index(grades_hash[student_id][subject_id]) do |line, index|
    puts "#{index}). #{line}"
  end
end

def display_subjects_with_avg(class_id, student_id)
  grades_hash = load_grades
  puts "\nSubjects for Class ID #{class_id}, Student ID #{student_id}:"

  each_line(SUBJECTS_FILE) do |line|
    subject_id, name = line.split(',')
    if grades_hash[student_id] && grades_hash[student_id][subject_id.to_i]
      avg = average_for_subject(grades_hash[student_id][subject_id.to_i])
      puts "#{subject_id}) #{name.strip} - Average: #{avg}"
    end
  end
end

def average_for_subject(grades)
  return 0 if grades.empty?
  grades.sum / grades.size.to_f
end

def valid_class_id?(id)
  each_line(CLASSES_FILE) { |line| return true if line.start_with?("#{id},") }
  false
end

def valid_student_id?(class_id, student_id)
  each_line(STUDENTS_FILE) do |line|
    sid, cid, = line.split(',')
    return true if sid.to_i == student_id && cid.to_i == class_id
  end
  false
end

def delete_subject(class_id, student_id)
  subject_id = request_input("Enter the ID of the subject to delete").to_i

  update_file(SUBJECTS_FILE) do |lines|
    lines.reject do |line|
      line.start_with?("#{subject_id},")
    end
  end

  grades_hash = load_grades
  grades_hash.each { |student, subjects| subjects.delete(subject_id) }
  save_grades(grades_hash)
  
  puts "Subject with ID #{subject_id} has been deleted."
  student_menu(class_id, student_id)
end

def edit_subject(class_id, student_id)
  subject_id = request_input("Enter the ID of the subject to edit").to_i
  
  update_file(SUBJECTS_FILE) do |lines|
    lines.map do |line|
      if line.start_with?("#{subject_id},")
        new_name = request_input("Enter the new name for the subject")
        "#{subject_id},#{new_name}"
      else
        line
      end
    end
  end
  
  puts "Subject with ID #{subject_id} has been updated."
  student_menu(class_id, student_id)
end


def add_class
  name = request_input("Enter the new class name")
  id = next_id(CLASSES_FILE)
  write_to_file(CLASSES_FILE, "#{id},#{name}", 'a')
end

def delete_class
  class_id = request_input("Enter the ID of the class to delete").to_i
  update_file(CLASSES_FILE) { |lines| lines.reject { |line| line.start_with?("#{class_id},") } }
end

def edit_class
  class_id = request_input("Enter the ID of the class to edit").to_i
  update_file(CLASSES_FILE) do |lines|
    lines.map do |line|
      if line.start_with?("#{class_id},")
        new_name = request_input("Enter the new name for the class")
        "#{class_id},#{new_name}"
      else
        line
      end
    end
  end
end

def update_file(file_name)
  lines = File.readlines(file_name).map(&:chomp)
  updated_lines = yield(lines)
  File.open(file_name, 'w') { |file| updated_lines.each { |line| file.puts(line) } }
end


def add_student(class_id)
  name = request_input("Enter the student's full name")
  id = next_id(STUDENTS_FILE)
  write_to_file(STUDENTS_FILE, "#{id},#{class_id},#{name}", 'a')
  puts "Student '#{name}' added with ID #{id}."

  class_menu(class_id)
end

def delete_student(class_id)
  student_id = request_input("Enter the ID of the student to delete").to_i
  lines = []
  handle_file(STUDENTS_FILE, 'r') { |file| lines = file.readlines }

  updated_lines = lines.reject do |line|
    line.start_with?("#{student_id},#{class_id},")
  end

  if lines.size == updated_lines.size
    puts "Student with ID #{student_id} in class #{class_id} not found."
  else
    handle_file(STUDENTS_FILE, 'w') { |file| updated_lines.each { |line| file.print(line) } }
    puts "Student with ID #{student_id} in class #{class_id} has been deleted."
  end

  class_menu(class_id)
end

def edit_student(class_id)
  student_id = request_input("Enter the ID of the student to edit").to_i
  lines = []
  handle_file(STUDENTS_FILE, 'r') { |file| lines = file.readlines.map(&:chomp) }

  updated_lines = lines.map do |line|
    if line.start_with?("#{student_id},#{class_id},")
      student_id, class_id, current_name = line.split(',')
      new_name = request_input("Enter the new name for the student (current: '#{current_name}')")
      "#{student_id},#{class_id},#{new_name}" # Update the line with the new name
    else
      line
    end
  end

  if lines == updated_lines
    puts "Student with ID #{student_id} in class #{class_id} not found."
  else
    handle_file(STUDENTS_FILE, 'w') { |file| updated_lines.each { |line| file.puts(line) } }
    puts "Student with ID #{student_id} in class #{class_id} has been updated."
  end

  class_menu(class_id)
end

def add_subject(class_id, student_id)
  name = request_input("Enter the subject name")
  id = next_id(SUBJECTS_FILE)
  write_to_file(SUBJECTS_FILE, "#{id},#{name}", 'a')
  puts "Subject '#{name}' added with ID #{id}."
  student_menu(class_id, student_id)
end

def add_grade(class_id, student_id, subject_id)
  grade = request_input("Enter the grade")
  write_to_file(GRADES_FILE, "#{student_id},#{subject_id},#{grade}", 'a')
  subject_menu(class_id, student_id, subject_id)
end

def edit_grade(grades_hash, class_id, student_id, subject_id)
  grade_index = request_input("Enter the ID of the grade to edit").to_i
  new_grade = request_input("Enter new grade").to_i
  if grades_hash[student_id][subject_id][grade_index] && new_grade >=0 && new_grade <= 5
    grades_hash[student_id][subject_id][grade_index] = new_grade
    save_grades(grades_hash)
  else
    puts "Grade at index #{grade_index} not found for student #{student_id}, subject #{subject_id}."
  end

  subject_menu(class_id, student_id, subject_id)
end

def delete_grade(grades_hash, class_id, student_id, subject_id)
  grade_index = request_input("Enter the ID of the grade to delete").to_i
  if grades_hash[student_id][subject_id][grade_index]
    grades_hash[student_id][subject_id].delete_at(grade_index)
    save_grades(grades_hash)
  else
    puts "Grade at index #{grade_index} not found for student #{student_id}, subject #{subject_id}."
  end

  subject_menu(class_id, student_id, subject_id)
end


def save_grades(grades_hash)
  lines = []
  grades_hash.each do |student_id, subjects|
    subjects.each do |subject_id, grades|
      grades.each { |grade| lines << "#{student_id},#{subject_id},#{grade}" }
    end
  end

  handle_file(GRADES_FILE, 'w') do |file|
    lines.each { |line| file.puts(line) }
  end
end

def load_grades
  grades_hash = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = [] } }

  handle_file(GRADES_FILE, 'r') do |file|
    file.each_line do |line|
      student_id, subject_id, grade = line.chomp.split(',')
      grades_hash[student_id.to_i][subject_id.to_i] << grade.to_i
    end
  end

  grades_hash
end

def each_line(file_name)
  with_error_handling do
    File.readlines(file_name).each { |line| yield(line.chomp) }
  end
end


def next_id(file_name)
  ids = []
  handle_file(file_name, 'r') do |file|
    file.each_line { |line| ids << line.split(',').first.to_i }
  end
  ids.max.to_i + 1
end

main_menu
