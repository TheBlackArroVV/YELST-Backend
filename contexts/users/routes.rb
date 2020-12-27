# frozen_string_literal: true

class App
  hash_branch 'users' do |r|
    r.on 'sign_up' do
      r.post do
        params = JSON.parse(r.body.read)
        result = ::Users::Forms::UserForm.new(params).call
        response.status = result.success? ? 201 : 422
        { result: result.object }.to_json
      end
    end

    r.on 'sign_in' do
      r.post do
        params = JSON.parse(r.body.read)
        result = ::Users::Services::SignIn.new(params).call
        response.status = result.success? ? 201 : 422
        { result: result.object }.to_json
      end
    end
  end
end
