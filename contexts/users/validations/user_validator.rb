module Users
  module Validations
    class UserValidator
      attr_reader :params
      attr_accessor :errors

      def initialize(params)
        @params = params
        @errors = []
      end

      def validate!
        valid?
      end

      private

      def valid?
        email_not_used? && attributes_present?
      end

      def email_not_used?
        return true if User.all.where(email: params['email']).to_a.empty?

        @errors << 'Email used'
        false
      end

      def attributes_present?
        params.key?('email') && params.key?('password')
      end
    end
  end
end
