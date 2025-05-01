Rails.application.routes.draw do
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses
  resources :coding_classes
  resources :trimesters, only: %i[index show]
  get '/dashboard', to: 'admin_dashboard#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
