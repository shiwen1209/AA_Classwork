class Api::BenchesController < ApplicationController
    def index
        @benches = Bench.all
        render json: @benches
    end

    def create
        @bench = Bench.new(bench_params)
        if @bench.save!
            render json: @bench
        else
            render json: @bench.errors.full_messages, status: 404
        end
    end

    def bench_params
        params.require(:bench).permit(:description, :lat, :lng)
    end
end
