require 'sinatra/base'
require './perfect_squares.rb'
require './rectangle_triangles.rb'
require './projectile.rb'
require './skyscraper_puzzle.rb'
module Wkn_Exercises
  class Web < Sinatra::Base
    get '/index' do
      erb :index
    end
    
    post '/perfectSquare' do
     if params.fetch('num').to_i >30
     "can't be grater than 30"
      else
      a =PerfectSquares.new
      a.call(params.fetch('num').to_i).to_json
     end
    end

    post '/skyscraper' do
      a=SkyscraperPuzzle.new
      a.get_skyscr_config
      a.solve_puzzle(eval(params.fetch('clues'))).to_json
    end

    post '/rectangleTriangles' do
      a =RectangleTriangles.new
      a.count_rect_triang(eval(params.fetch('points'))).to_json
    end

    post '/projectile' do
      param=params.fetch('sides').split(",")
      a =Projectile.new(*param.first(3).map { |s| s.to_i })
      "height_eq  :#{ a.height_eq} , horiz_eq : #{ a.height_eq}, height : #{a.height(param.last.to_i)}, horiz : #{a.horiz(param.last.to_i)} ,landing :#{a.landing} ".to_json
    end
  end
end