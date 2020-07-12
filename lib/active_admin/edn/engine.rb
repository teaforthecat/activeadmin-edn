module ActiveAdmin
  module Edn
    # Extends ActiveAdmin with edn downloads
    class Engine < ::Rails::Engine
      engine_name 'active_admin_edn'

      initializer 'active_admin.edn', group: :all do
        if Mime::Type.lookup_by_extension(:edn).nil?
          Mime::Type.register 'application/edn', :edn
        end

        ActiveAdmin::Views::PaginatedCollection.add_format :edn

        ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::Edn::DSL
        ActiveAdmin::Resource.send :include, ActiveAdmin::Edn::ResourceExtension
        ActiveAdmin::ResourceController.send(
          :prepend,
          ActiveAdmin::Edn::ResourceControllerExtension
        )
      end
    end
  end
end
