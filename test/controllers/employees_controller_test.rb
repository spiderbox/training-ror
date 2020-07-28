require 'test_helper'
require 'helpers/request_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  include Requests::JsonHelpers
  
  HTTP_STATUS_SUCCESS = 200
  HTTP_STATUS_FAIL = 400

  setup do
    @employee = employees(:one)
  end    


  test "get_page_one" do 
    get employees_url, params: { page: 1 }
    response = json_parse(@response)
    
    assert_equal HTTP_STATUS_SUCCESS, response['status']
    assert_equal 10, response['data'].count
  end

  test 'get page two' do
    get employees_url, params: { page: 2 }
    response = json_parse(@response)

    assert_equal HTTP_STATUS_SUCCESS, response['status'], HTTP_STATUS_SUCCESS
    assert_equal 3, response['data'].count
  end  

  # case nothing
  test 'get page three' do
    get employees_url, params: { page: 3 }
    response = json_parse(@response)

    assert_equal HTTP_STATUS_SUCCESS, response['status'], HTTP_STATUS_SUCCESS
    assert_equal 0, response['data'].count
  end

  # test add employe
  test 'add employee' do
    post employees_url, params: {
      name: 'test',
      phone: 'test',
      email: 'test',
      password: 'test',
      dob: '1991-09-21',
    }
    
    response = json_parse(@response)

    assert_equal HTTP_STATUS_SUCCESS, response['status'], HTTP_STATUS_SUCCESS
    assert_equal "ok", response['message']
  end


  # login
  test 'login fail' do
    post login_url, params: {
      email: 'son@gmail.com',
      password: '123'
    }
    
    response = json_parse(@response)
    assert_equal HTTP_STATUS_FAIL, response['status']
    assert_equal 'fail', response['message']
  end

  test 'login success' do
    
    post login_url, params: {
      email: 'nhson219@gmail.com',
      password: default_password
    }
    
    response = json_parse(@response)
    
    assert_equal HTTP_STATUS_SUCCESS, response['status']
    assert_equal 'ok', response['message']
  end
  # end login

  # delete
  test 'delete employee successfull' do
    employee = employees(:one)
    
    assert_difference('Employee.count', -1) do
      delete employee_url(employee)
    end    
    
    response = json_parse(@response)
    assert_equal HTTP_STATUS_SUCCESS, response['status']
  end    
  # end delete


  test 'update employee successfull' do
    put employee_url(@employee), params: {
      name: 'unit test update employee'
    }
    
    response = json_parse(@response)
    assert_equal HTTP_STATUS_SUCCESS, response['status']
  end 
end
