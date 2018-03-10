Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  root to: "intranet#dashboard"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  resources :homeworks
  get '/intranet/admin/dashboard' => "admin#dashboard", as: :admin_dashboard
  get '/intranet/members'
  get '/intranet/members/:id' => "intranet#personal", as: :member
  get '/intranet/dashboard'
  get '/intranet/notice'
  get '/intranet/freeboard'
  get '/intranet/gallery'
  get '/intranet/gallery/new' => "intranet#imgUpload", as: :new_image
  post '/intranet/gallery/new' => "intranet#imgUpload", as: :create_image
  get '/intranet/events', as: :event
  get '/intranet/events/new' => "intranet#newEvent", as: :new_event
  post '/intranet/events/save' => "intranet#createEvent", as: :create_event
  get '/intranet/events/data' => "intranet#getEventJSON", as: :event_json
  get '/intranet/events/:id' => "intranet#viewEvent", as: :view_event
  get '/intranet/events/:id/edit' => "intranet#editEvent", as: :edit_event
  patch '/intranet/events/:id/edit' => "intranet#editEvent", as: :update_event
  delete '/intranet/events/:id/remove' => "intranet#removeEvent", as: :remove_event
  get '/intranet/homework', as: :homework_status
  get '/intranet/homework/:id/submission' => "intranet#submitHomework", as: :submission
  post '/intranet/homework/:id/submission' => "intranet#createSubmission", as: :submit_homework
  get '/intranet/search', as: :search
  get '/intranet/notice/write' => 'intranet#editor', as: :nedit
  get '/intranet/freeboard/write' => 'intranet#editor', as: :fedit
  get '/intranet/post/edit/:id' => "intranet#editPost", as: :pedit
  patch '/intranet/post/edit/:id' => "intranet#editPost", as: :mod_post
  post '/intranet/post/save' => 'intranet#savePost', as: :create_post
  get '/intranet/post/view/:id' => 'intranet#viewPost', as: :view
  post '/intranet/post/view/:id/reply/create' => "intranet#saveReply", as: :replies
  delete '/intranet/post/view/:id/reply/remove' => "intranet#removeReply", as: :remove_reply
  delete '/intranet/post/remove/:id' => "intranet#removePost", as: :remove_post
  
end
