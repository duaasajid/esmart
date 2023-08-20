module Users
  class RegistrationsController < Devise::RegistrationsController

    def destroy
      resource.soft_delete
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message :notice, :destroyed
      yield resource if block_given?
      respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
    end

    protected

    def after_sign_up_path_for(resource)
      send_confirmation_instructions
      root_path
    end  
  end
end
