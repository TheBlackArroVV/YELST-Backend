module Packages
  module Services
    class FillList
      Result = Struct.new(:success?, :object)

      attr_reader :params, :user_id
      attr_accessor :package

      def initialize(params)
        @params = params
      end

      def call
        find_user_id
        find_or_create_package
        set_list

        Result.new(true, @package.first)
      end

      private

      def find_user_id
        @user_id = ::JWT.decode(params[:current_user], nil, false).first['id']
      end

      def find_or_create_package
        @package = Package.all.where(user_id: user_id)

        return if @package

        Package.all.insert(list: [], user_id: user_id)
      end

      def set_list
        @package.update(list: "{#{params['list'].join(' ')}}")
      end
    end
  end
end
