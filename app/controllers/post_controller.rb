class PostController < ApplicationController

    def create
        @post = Post.new({
            title: [post_params[:title], Time.zone.now.to_i].join(' '),
            description: [post_params[:description], Time.zone.now.to_i].join(' '),
            employee_id: Employee.where({
                email: 'nhson219@gmail.com'
            }).first.id
        })
        @post.save
    end       
    
    

    private
    def post_params
        params.permit(:title, :description)
    end        
end
