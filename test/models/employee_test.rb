require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "save employee without name" do
    employee = Employee.new
    employee.name = "123"
    employee.password = "123"
    employee.dob = "1991-09-21"
    employee.phone = "123"
    employee.email = "123"
    assert employee.save, "save employee without name"
  end

  test "should check varibale undefined" do
    assert_raises(NameError) do
      abc
    end  
  end    
end
