#YOUR CODE GOES HERE

require 'pg'
require 'pry'
require 'csv'

def print_output
  csv_to_db
  output = []
  get_db_data.each do |line|
    output << "#{line["id"]}. #{line["ingredient"]}"
  end
  output.join("\n")
end

def csv_to_db
  read_csv.each do |ingredient|
    write_db(ingredient)
  end
end

def read_csv
  list = []
  CSV.foreach('ingredients.csv') do |row|
    list << row[1]
  end
  list
end

def write_db(string_to_write)
  db_connection do |conn|
    sql_query = %(
    INSERT INTO csvdata (ingredient)
    VALUES ($1)
    )
    data = [string_to_write]
    conn.exec_params(sql_query, data)
  end
end

def  get_db_data
  data = nil
  db_connection do |conn|
    data = conn.exec("SELECT * FROM csvdata")
  end
  data
end

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

puts print_output
