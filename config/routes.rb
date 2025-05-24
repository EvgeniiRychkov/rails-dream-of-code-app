Rails.application.routes.draw do
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses do
    resources :submissions
  end
  resources :coding_classes
  resources :trimesters, only: %i[index show edit update]
  get '/dashboard', to: 'admin_dashboard#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
