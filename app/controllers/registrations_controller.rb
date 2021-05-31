# frozen_string_literal: true

require 'base64'

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    super

    @balance = Balance.new(balance: 0)
    @balance.user = @user
    @balance.save!
  end

  def update

    # encode avatar image to base64 string
    avatar = params[:user][:avatar]
    if avatar
      bin_str = File.read(avatar.tempfile)
      f_type = avatar.headers.match(/jpg|jpeg|png/)
      params[:user][:avatar] = "data:image/#{f_type};base64,#{Base64.encode64(bin_str)}"
    end

    # normal devise methods
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password first_name last_name region])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password current_password password_confirmation
                                               first_name last_name avatar region])
  end

  def after_sign_up_path_for(resource)
    profile_path
  end

end
