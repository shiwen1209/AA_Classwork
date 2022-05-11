require_relative "employee.rb"

class Manager < Employee

    attr_reader :name, :title, :salary, :boss
    
    def initialize(name, title, salary, boss)
        @employees = []
        super(name)
    end

    def return_bonus(multiplier)
        return multiplier * self.sub_salaries
    end 

    def sub_salaries
        total_salary = 0

        @employees.each do |emp|
            if emp.is_a?(Manager)
                total_salary += emp.sub_salaries
            else
                total_salary += emp.salary
            end
        end

        return total_salary
    end

    def add_employee(employee)
        @employees << employee
    end

end 