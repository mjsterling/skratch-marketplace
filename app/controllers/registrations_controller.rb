# frozen_string_literal: true

require 'base64'

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def update
    # convert image to base64 string

    avatar = params[:user][:avatar]
    bin_str = File.read(avatar.tempfile)
    f_type = avatar.headers.match(/jpg|jpeg|png/)
    params[:user][:avatar] = "data:image/#{f_type};base64,#{Base64.encode64(bin_str)}"

    # normal devise methods

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password current_password password_confirmation
                                               first_name last_name title avatar])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
