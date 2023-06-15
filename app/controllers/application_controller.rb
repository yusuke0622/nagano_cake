class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_up_path_for(resources)
        my_page_path
    end
    
    def after_sign_in_path_for(resources)
        root_path
    end

    protected
    
    def configure_permitted_parameters
        added_attrs = [ :first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code, :address, :telephone_number ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    end
    
end
