# rubocop:disable BlockLength
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  #
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  %w[404 422 500 503].each do |code|
    get code, to: 'errors#show', code: code
  end
  get "/sitemap.xml", to: redirect("sitemap.xml")
  get "/.well-known/acme-challenge/2fsWt3q3qc4QX7PDltZFSqangN6s1yW3GSiQW7fFKkE", to: redirect("/.well-known/acme-challenge/lOURr_67v9P5WTiKw2u8ngy94MLR8lNTZJpnpndDUMU")

  get "/.well-known/acme-challenge/GMf6eLyREExHEVBYny7j3A2LXBDQ2ilnAOm-9JY6Fjg", to: redirect("/.well-known/acme-challenge/THSSs1y4nNMlhxWJJVXbscBniuTtEIO1kz-rRtlap88")

  # scope '(:locale)', locale: /es|en/ do
  root to: 'home#index'
  resources :pages, only: %i[show index]
  resources :contacts, only: %i[create]
  resources :services, only: %i[index]
  resources :service_categories, only: %i[show], path: 'servicecategories'
  resources :portfolios, only: %i[show index]
  resources :articles, only: %i[show index]
  resources :abouts, only: %i[index]

  namespace :latte do
    root to: 'home#index'

    
    resources :activity_logs, only: %i[index show]
    resources :profile,       only: %i[edit update]
    resources :versions,      only: %i[show]
    resources :tags,          only: %i[index]
    resources :contacts,      only: %i[index]

    resources :settings, only: %i[update] do
      get :edit, on: :collection
    end

    resources :home_pages, only: %i[update] do
      get :edit, on: :collection
    end

    resources :admin_settings, only: [] do
      put :table_columns, on: :collection
    end

    resources :habtm, only: [] do
      get :available, on: :collection
      get :enabled, on: :collection
    end

    resources :recycler_docks, only: %i[index show] do
      get :restore, on: :member
    end

    resources :images, only: %i[create update destroy] do
      get ':imageable_type/:imageable_id/',
          to: 'images#list',
          as: :list,
          on: :collection

      put :sort, as: :sort, on: :collection
    end

    resources :attachments, only: %i[create update destroy] do
      get ':attachable_type/:attachable_id/',
          to: 'attachments#list',
          as: :list,
          on: :collection

      put :sort, as: :sort, on: :collection
    end

    resources :abouts, only: %i[update] do
      get :edit, on: :collection
    end

    resources :external_videos, only: %i[create update destroy] do
      get ':external_videoable_type/:external_videoable_id/',
          to: 'external_videos#list',
          as: :list,
          on: :collection

      put :sort, as: :sort, on: :collection
    end

    %i[
      admins
      contacts
      projects
      services
      countries
      service_categories
      portfolios
      brands
      articles
      authors
      tecnologies
      employees
    ].each do |resource|
      resources resource do
        put :updates,  on: :collection
        put :destroys, on: :collection
        get :list,     on: :collection
      end
    end

    namespace :grid do
      %i[
        admins
      ].each do |resource|
        resources resource, only: %i[index new create]
      end
    end
  end
end
