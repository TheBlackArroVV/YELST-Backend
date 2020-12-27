module Users
  module Forms
    class UserForm
      Result = Struct.new(:success?, :object)

      attr_reader :params
      attr_accessor :user, :jwt

      def initialize(params)
        @params = params
        @user = nil
        @jwt = nil
      end

      def call
        return Result.new(false, validator.errors) unless validator.validate!

        create_user
        create_jwt

        Result.new(true, jwt)
      end

      private

      def validator
        @validator ||= ::Users::Validations::UserValidator.new(params)
      end

      def create_user
        @user = ::User.all.insert(email: params['email'], encrypted_password: password, uuid: ::SecureRandom.uuid)
      end

      def password
        BCrypt::Password.create(params['password'])
      end

      def create_jwt
        @jwt = JWT.encode(user, user.uuid, 'HS256')
      end
    end
  end
end
