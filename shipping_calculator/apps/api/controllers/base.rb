module Api
  module Controllers
    class Base
      protected

      def content(status_code, message)
        status status_code, { message: message }.to_json
      end

      def validate_error
        content(400, validator.errors)
      end

      def created
        content(201, 'Created')
      end

      def updated
        content(200, 'Updated')
      end

      def error(message)
        content(422, message)
      end
    end
  end
end
