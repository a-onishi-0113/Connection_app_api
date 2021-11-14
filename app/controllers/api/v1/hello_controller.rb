class Api::V1::HelloController < ApplicationController

    def index
        render json: "Hello"
    end
    
    def create
        @hello = Hello.new(hello_params)
        render json: @hello
    end

    private
        def hello_params
            params.require(:hello).permit(:title)
        end
end
