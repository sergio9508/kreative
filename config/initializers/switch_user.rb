SwitchUser.setup do |config|
  # provider may be :devise, :authlogic, :clearance, :restful_authentication, :sorcery, or {name: :devise, store_sign_in: true}
  config.provider = :devise

  # available_users is a hash,
  # key is the model name of user (:user, :admin, or any name you use),
  # value is a block that return the users that can be switched.
  config.available_users = { admin: -> { Admin.order(:email) } } # use User.scoped instead for rails 3.2

  # available_users_identifiers is a hash,
  # keys in this hash should match a key in the available_users hash
  # value is the name of the identifying column to find by,
  # defaults to id
  # this hash is to allow you to specify a different column to
  # expose for instance a username on a User model instead of id
  config.available_users_identifiers = { admin: :id }

  # available_users_names is a hash,
  # keys in this hash should match a key in the available_users hash
  # value is the column name which will be displayed in select box
  config.available_users_names = { admin: :email }

  # controller_guard is a block,
  # if it returns true, the request will continue,
  # else the request will be refused and returns "Permission Denied"
  # if you switch from "admin" to user, the current_user param is "admin"
  config.controller_guard = ->(current_admin, request) { Rails.env.development? || Rails.env.production? }

  # view_guard is a block,
  # if it returns true, the switch user select box will be shown,
  # else the select box will not be shown
  # if you switch from admin to "user", the current_user param is "user"
  config.view_guard = ->(current_admin, request) { Rails.env.development? || Rails.env.production? }

  # redirect_path is a block, it returns which page will be redirected
  # after switching a user.
  config.redirect_path = ->(request, params) { '/latte' }

  config.helper_with_guest = false

  # config.switch_back = true
  # config.controller_guard = -> (current_admin, request, original_user) { current_admin && current_admin.admin? }
end
