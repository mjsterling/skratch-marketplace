# frozen_string_literal: true

require 'base64'

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    super
    @just_signed_up = "Please complete your profile to begin using Skratch."
    @balance = Balance.new
    @balance.balance = 0
    @balance.user = current_user
    @balance.save!
  end

  def update
    @just_signed_up = nil
    # encode avatar image to base64 string
    avatar = params[:user][:avatar]
    if avatar
      bin_str = File.read(avatar.tempfile)
      f_type = avatar.headers.match(/jpg|jpeg|png/)
      params[:user][:avatar] = "data:image/#{f_type};base64,#{Base64.encode64(bin_str)}"
    end

    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password current_password password_confirmation
                                               first_name last_name title avatar region])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
