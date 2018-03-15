class FiguresController < ApplicationController

	get '/figures/new' do
		erb :'/figures/new'
	end

	post '/figures' do
		figure= Figure.create(params[:figure])

		if !params[:title][:name].empty?
			title = Title.create(params[:title])
			title.figures << figure
		end
		
		if !params[:landmark][:name].empty?
			landmark = Landmark.create(params[:landmark])
			figure.landmarks << landmark
		end
	end
	
	get '/figures' do
		@figures = Figure.all
		erb :'/figures/index'
	end
	
	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'/figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'/figures/edit'
	end
	
	post '/figures/:id' do
		@figure = Figure.find(params[:id])
		if !params[:title][:name].empty?
			@figure.update(params[:title])
		end
		
		if !params[:landmark][:name].empty?
			landmark = Landmark.create(params[:landmark])
			@figure.landmarks << landmark
		end

		if !params[:figure][:name].empty?
			@figure.name = params[:figure][:name]
		end
		
		@figure.save
		erb :'/figures/show'
	end
		
end