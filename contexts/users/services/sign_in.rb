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
        @user = ::User.all.where(email: params['email'], encrypted_password: password).to_a.first
      end

      def password
        BCrypt::Password.create(params['password'])
      end

      def create_jwt
        @jwt = JWT.encode(user, ::SecureRandom.uuid, 'HS256')
      end
    end
  end
end
