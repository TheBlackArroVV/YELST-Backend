module Users
  module Services
    class SignIn
      Result = Struct.new(:success?, :object)

      attr_reader :params
      attr_accessor :user, :jwt

      def initialize(params)
        @params = params
        @user = nil
        @jwt = nil
      end

      def call
        find_user
        return Result.new(false, 'User not found') unless user

        create_jwt
        Result.new(true, jwt)
      end

      private

      def find_user
        @user = ::User.all.where(email: params['email']).to_a.first
        return true if ::BCrypt::Password.new(@user[:encrypted_password]) == params['password']

        @user = nil
        false
      end

      def create_jwt
        @jwt = JWT.encode(user, user[:uuid], 'HS256')
      end
    end
  end
end
