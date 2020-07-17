require 'bcrypt'
class EmployeesController < ApplicationController

    HTTP_STATUS_SUCCESS = 200
    HTTP_STATUS_FAIL = 400

    def initialize

        # init response fail
        @response = {
            status: HTTP_STATUS_FAIL,
            message: :fail
        }
    end

    def index

        begin
            @employees = Employee.all

            if @employees
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

    def create

        begin
            @employee = Employee.new(employee_params)

            if @employee.save
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
end
