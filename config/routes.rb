Rails.application.routes.draw do
  #root 'ringi#index'
  root 'test#index'

  #login users
  get	'/login'		  => 'users#login'
  post	'/login/complete'	  => 'users#login_complete'
  get	'/logout'		  => 'users#logout_complete'

  #ringi system
  get	'/ringi'		  => 'ringi#index'
  post	'/ringi/info'		  => 'ringi#info'
  post	'/ringi/email'		  => 'ringi#create_email'
  post	'/ringi/complete'	  => 'ringi#complete'
  get	'/ringi/history/:user_id' => 'ringi#history'

  #user registration
  get	'/register'		=> 'users#create'
  post	'/register/confirm'	=> 'users#create_confirm'
  post	'/register/complete'	=> 'users#create_complete'
  get	'/user/edit/:id'	=> 'users#edit'
  post	'/user/edit/confirm'	=> 'users#edit_confirm'
  post	'/user/edit/complete'	=> 'users#edit_complete'

  #admin tools login 
  get	'/tools'		  => 'history#index'
  get	'/tools/login'		  => 'admins#login'
  post	'/tools/login/complete'	  => 'admins#login_complete'
  get	'/tools/logout'		  => 'admins#logout'

  #admin registration for tools
  get	'/tools/register'		  => 'admins#create'
  post	'/tools/register/confirm'	  => 'admins#create_confirm'
  post	'/tools/register/complete'	  => 'admins#create_complete'
  get	'/tools/admin/edit/:id'		  => 'admins#edit'
  post	'/tools/admin/edit/confirm'	  => 'admins#edit_confirm'
  post	'/tools/admin/edit/complete'	  => 'admins#edit_complete'

  #users and history tool
  get	'/tools/history'	    => 'history#index'
  get	'/tools/users/:id/history'  => 'users#history'
  get	'/tools/users'		    => 'users#index'
  get	'/tools/admins'		    => 'admins#index'

  #affiliate tool
  get	'/tools/affiliates'			=> 'affiliates#index'
  get	'/tools/affiliates/create'		=> 'affiliates#create'
  post	'/tools/affiliates/create/complete'	=> 'affiliates#create_complete'
  get	'/tools/affiliates/edit/:id'		=> 'affiliates#edit'
  post	'/tools/affiliates/edit/complete'	=> 'affiliates#edit_complete'	
  post	'/tools/affiliates/delete/complete'	=> 'affiliates#delete_complete'
end
