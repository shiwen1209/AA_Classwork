require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        '#{self.table_name}'
      LIMIT
        0
    SQL
    cols2 = cols[0].map!(&:to_sym)
    @columns = cols2
  end


  def self.finalize!

    self.columns.each do |column|
      define_method(column) do 
        self.attributes[column]
      end

      column2 = column.to_s + "="
      define_method(column2) do |val|
        self.attributes[column] = val
      end
  
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    var = self.name.tableize
    @table_name ||= var
    return @table_name
    # ...
  end

  def self.all
    all_value = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        '#{self.table_name}'
    SQL

    return parse_all(all_value)

  end

  def self.parse_all(results)
    results.map {|result| self.new(result)}
  end

  def self.find(id)
    target = {id: id}
    result = DBConnection.execute(<<-SQL, target)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE id = :id
    SQL
    if result.empty?
      return nil 
    else 
      self.new(result[0])
    end
  end


  def initialize(params = {})
    params.each do |atr, val|
      attr_name = atr.to_sym
      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", val)
      else 
        raise "unknown attribute '#{atr}'" 
      end
    end
  end

  def attributes
    @attributes ||= {}

  end

  def attribute_values

    attributes.values
  end

  def insert
    columns = self.class.columns[1..-1]
    col_names = columns.map {|c| c.to_s}.join(", ")
    question_marks = (["?"] * columns.count).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id



  end

  def update
    set_line = self.class.columns
    .map { |attr| "#{attr} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
        id.nil? ? insert : update
  end
end
