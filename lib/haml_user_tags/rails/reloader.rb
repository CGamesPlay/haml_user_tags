module HamlUserTags
  class Reloader < Rails::Railtie
    initializer "haml_user_tags.enable_reloading" do
      watcher = ActiveSupport::FileUpdateChecker.new([], "#{Rails.root}/app/views/helpers" => %w{haml}) {}
      Rails.application.reloaders << watcher
      reloader_class.to_prepare do
        watcher.execute_if_updated
      end
    end

    private

    def reloader_class
      # Rails 5.0 says:
      # DEPRECATION WARNING: to_prepare is deprecated and will be removed from Rails 5.1
      # (use ActiveSupport::Reloader.to_prepare instead)
      if ActiveSupport::VERSION::MAJOR >= 5
        ActiveSupport::Reloader
      else
        ActionDispatch::Reloader
      end
    end
  end
end
