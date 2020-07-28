require 'bcrypt'
class EmployeesController < ApplicationController

    HTTP_STATUS_SUCCESS = 200
    HTTP_STATUS_FAIL = 400
    PAGINATION_LIMIT = 10
    def initialize

        # init response fail
        @response = {
            status: HTTP_STATUS_FAIL,
            message: :fail
        }
    end

    def index
        # render json: @response
        begin
            position = params[:page] ? params[:page].to_i * PAGINATION_LIMIT - PAGINATION_LIMIT : 1
            
            @employees = Employee
            if (params[:search])
                @employees = @employees.where(email: params[:search])
                                        .or(Employee.where(name: params[:search]))
            end
            total_rows = @employees.count
            @employees = @employees.limit(PAGINATION_LIMIT).offset(position).order(id: :desc)
            # get all
            

            if @employees
                # @response[:status] = HTTP_STATUS_SUCCESS
                # @response[:message] = :ok
                
                # @response = data_response(@response, @employees)


                #this is test
                @response_2 = {}
                @response_2[:status] = HTTP_STATUS_SUCCESS
                @response_2[:message] = :ok

                @response_2[:total_rows] = total_rows
                @response_2[:data] = @employees
                @response_2[:page] = params[:page]

                @response_2 = data_response_2 @response_2
                
                
            end 
        rescue Exception => e
            # exception
            logger.error e.message
        end                        
        
        render json: @response_2
    end        

    def create

        begin
            @employee = Employee.new(employee_params)

            if @employee.save
                @response[:status] = HTTP_STATUS_SUCCESS
                @response[:message] = :ok
                
                @response[:data] = @employee
            
                @response = data_response @response, @employee
            end
        rescue Exception => e
            # exception
            logger.error e.message
        end   

        render json: @response
                                
    end       

    def update
        
        begin
            @employee = Employee.find(params[:id])
            
            if @employee.update(employee_params)

                @response[:status] = HTTP_STATUS_SUCCESS
                @response[:message] = :ok
                
                @response = data_response(@response, @employee)
            end
        rescue Exception => e
            # exception
            logger.error e.message
        end       

        render json: @response
    end        

    def login

        begin
            @employee = Employee.find_by_email(params[:email])
            
            if BCrypt::Password.new(@employee.password_digest) == params[:password]
                @response[:status] = HTTP_STATUS_SUCCESS
                @response[:message] = :ok
            
                @response = data_response(@response, @employees)
            end
        rescue Exception => e
            # exception
            logger.error e.message
        end                    

        render json: @response

    end   

    def destroy

        begin
            @employee = Employee.find(params[:id])

            if @employee.destroy
                @response[:status] = HTTP_STATUS_SUCCESS
                @response[:message] = :ok
                
                @response = data_response(@response, @employees)
            end
        rescue Exception => e    
            # exception
            logger.error e.message
        end

        render json: @response
    end             

    private
        def employee_params
            params.permit(:name, :phone, :password, :email, :dob) 
        end
        
        def data_response response = {}, data = {}
            {
                status: response[:status],
                message: response[:message],
                data: data
            }
        end
        def data_response_2 data = {}
            @response.merge(data)
        end            
end
