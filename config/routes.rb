Rails.application.routes.draw do
  resources :blogs do
  	collection do 
  		get :port 
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', :to => redirect('/blogs')


end
