RailsAdmin.config do |config|

  ### Popular gems integration

  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    member :make_active do
      only ['Promotion']
      link_icon 'icon-volume-up'
      visible do
        !bindings[:object].active
      end
      controller do
        Proc.new do
          @object.update_attributes!(active: true)

          flash[:success] = "#{@model_config.label} is now active."

          redirect_to back_or_index
        end
      end
    end

    member :withdraw do
      only ['Promotion']
      link_icon 'icon-volume-off'
      visible do
        bindings[:object].active
      end
      controller do
        Proc.new do
          @object.update_attributes!(active: false)

          flash[:success] = "#{@model_config.label} is now hidden."

          redirect_to back_or_index
        end
      end
    end
  end

  config.model Promotion do
    list do
      field :active
      field :title
      field :excerpt
      field :updated_at
    end

    edit do
      configure :description, :froala
    end
  end
end
