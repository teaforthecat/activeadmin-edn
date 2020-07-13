module ActiveAdmin
  module Edn
    # Extends the resource controller to respond to edn requests
    module ResourceControllerExtension
      def self.prepended(base)
        # base.send :respond_to, :edn, only: :index
        base.send :respond_to, :edn, only: [:index, :show]
      end

      # Patches index to respond to requests with edn mime type by
      # sending a generated edn document serializing the current
      # collection
      def index
        super do |format|
          format.edn do
            stream_enum = Enumerator.new do |lines|
              lines << "[\n"
              edn_collection.find_each(batch_size: 500).map do |obj|
                lines << obj.to_edn
                lines << ",\n"
              end
              lines << "]\n"
            end
            self.status = 200
            render_streaming stream_enum
            yield(format) if block_given?
          end
        end
      end

      def show
        super do |format|
          format.edn do
            send_data resource.to_edn,
                      filename: resource.display_name.parameterize + ".edn",
                      type: Mime::Type.lookup_by_extension(:edn)
            yield(format) if block_given?
          end
        end
      end

      def render_streaming(enumerator)
        # Delete this header so that Rack knows to stream the content.
        headers.delete("Content-Length")
        # Do not cache results from this action.
        headers["Cache-Control"] = "no-cache"
        # Let the browser know that this file is a CSV.
        headers['Content-Type'] = Mime::Type.lookup_by_extension(:edn)
        # Do not buffer the result when using proxy servers.
        headers['X-Accel-Buffering'] = 'no'
        # Set the filename
        headers['Content-Disposition'] = "attachment; filename=\"#{edn_filename}\""
        # Set the response body as the enumerator
        self.response_body = enumerator
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
