module ActiveAdmin
  module Edn
    # Extends the resource controller to respond to edn requests
    module ResourceControllerExtension
      def self.prepended(base)
        base.send :respond_to, :edn, only: :index
      end

      # Patches index to respond to requests with edn mime type by
      # sending a generated edn document serializing the current
      # collection
      def index
        super do |format|
          format.edn do
            edn = active_admin_config.edn_builder.serialize(edn_collection,
                                                            view_context)
            send_data(edn,
                      filename: edn_filename,
                      type: Mime::Type.lookup_by_extension(:edn))
          end

          yield(format) if block_given?
        end
      end

      # Patches rescue_active_admin_access_denied to respond to edn
      # mime type. Provides administrators information on how to
      # configure activeadmin to respond propertly to edn requests
      #
      # param exception [Exception] unauthorized access error
      def rescue_active_admin_access_denied(exception)
        if request.format == Mime::Type.lookup_by_extension(:edn)
          respond_to do |format|
            format.edn do
              flash[:error] = "#{exception.message} Review download_links in initializers/active_admin.rb"
              redirect_backwards_or_to_root
            end
          end
        else
          super(exception)
        end
      end

      # Returns a filename for the edn file using the collection_name
      # and current date such as 'my-articles-2011-06-24.edn'.
      #
      # @return [String] with default filename
      def edn_filename
        timestamp = Time.now.strftime('%Y-%m-%d')
        "#{resource_collection_name.to_s.tr('_', '-')}-#{timestamp}.edn"
      end

      # Returns the collection to use when generating an edn file.
      def edn_collection
        find_collection except: :pagination
      end
    end
  end
end
