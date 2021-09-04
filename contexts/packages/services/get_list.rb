module Packages
  module Services
    class GetList
      Result = Struct.new(:success?, :object)

      attr_reader :params, :user_id
      attr_accessor :package

      def initialize(params)
        @params = params
      end

      def call
        find_user_id
        find_or_create_package

        Result.new(true, @package.first[:list]&.delete_suffix("\"}")&.delete_prefix("{\""))
      end

      private

      def find_user_id
        @user_id = ::JWT.decode(params[:current_user], nil, false).first['id']
      end

      def find_or_create_package
        @package = Package.all.where(user_id: user_id, hostname: params['hostname'])

        return unless @package.to_a.empty?

        @package = Package.all.where(id: Package.all.insert(list: [], user_id: user_id, hostname: params['hostname']))
      end
    end
  end
end
