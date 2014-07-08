module HamlUserTags
  class Reloader < Rails::Railtie
    initializer "haml_user_tags.enable_reloading" do
      watcher = ActiveSupport::FileUpdateChecker.new([], "#{Rails.root}/app/views/helpers" => %w{haml}) {}
      Rails.application.reloaders << watcher
      ActionDispatch::Reloader.to_prepare do
        watcher.execute_if_updated
      end
    end
  end
end
