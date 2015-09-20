def read_csv
  print "Enter CSV file to import: "
  file_name = gets.chomp

  if file_name.empty?
    system "clear"
    puts "No CSV file read"
    main_menu
  end

  begin
    entry_count = @address_book.import_from_csv(file_name).count
    system "clear"
    puts "#{entry_count} new entries added from #{file_name}"
  rescue
    puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
    read_csv
  end
end

def delete_entry(entry)
  @address_book.entries.delete(entry)
  puts "#{entry_name} has been deleted"
end

def edit_entry(entry)
  print "Updated name: "
  name = gets.chomp
  print "Updated phone number: "
  phone_number = gets.chomp
  print "Updated email: "
  email = gets.chomp

  entry.name = name if !name.empty?
  entry.phone_number = phone_number if !phone_number.empty?
  entry.email = email if !email.empty?
  system "clear"

  puts "Updated entry:"
  puts entry
end

def entry_submenu
  puts "\nn - next entry"
  puts "d - delete entry"
  puts "e - edit this entry"
  puts "m - return to main menu"

  selection = $stdin.gets.chomp

  case selection
  when "n"
  when "d"
    delete_entry(entry)
  when "e"
    edit_entry(entry)
    entry_submenu(entry)
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    puts "#{selection} is not a valid input"
    entry_submenu(entry)
  end
end

def search_entries
  print "Search by name: "
  name = gets.chomp
  match = @address_book.binary_search(name)
  system "clear"
  if match
    puts match.to_s
    search_subment(match)
  else
    puts "No match found for #{name}"
  end
end

def search_submenu
  puts "\nd - delete entry"
  puts "e - edit this entry"
  puts "m - return to the main menu"
  selection = gets.chomp

  case selection
  when "d"
    system "clear"
    delete_entry(entry)
    main_menu
  when "e"
    edit_entry(entry)
    system "clear"
    main_menu
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    puts "#{selection} is not a valid input"
    puts entry.to_s
    search_submenu(entry)
  end
end
end