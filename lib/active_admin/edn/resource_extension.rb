module ActiveAdmin
  # Provides edn functionality to ActiveAdmin resources
  module Edn
    # Extends ActiveAdmin Resource
    module ResourceExtension
      # Sets the EDN Builder
      #
      # @param builder [Builder] the new builder object
      # @return [Builder] the builder for this resource
      def edn_builder=(builder)
        @edn_builder = builder
      end

      # Returns the EDN Builder. Creates a new Builder if none exists.
      #
      # @return [Builder] the builder for this resource
      #
      # @example Localize column headers
      #   # app/admin/posts.rb
      #   ActiveAdmin.register Post do
      #     config.edn_builder.i18n_scope = [:active_record, :models, :posts]
      #   end
      def edn_builder
        @edn_builder ||= ActiveAdmin::Edn::Builder.new(resource_class)
      end
    end
  end
end
