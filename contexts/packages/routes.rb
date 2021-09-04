# frozen_string_literal: true

class App
  hash_branch 'packages' do |r|
    r.on 'set_list' do
      r.post do
        params = JSON.parse(r.body.read)
        result = ::Packages::Services::FillList
                 .new(params.merge(current_user: r.get_header('HTTP_AUTHORIZATION').delete_prefix('Bearer ')))
                 .call
        response.status = result.success? ? 201 : 422
        { result: result.object }.to_json
      end
    end

    r.on 'get_list' do
      r.get do
        params = JSON.parse(r.body.read)
        result = ::Packages::Services::GetList.new(
          params.merge(current_user: r.get_header('HTTP_AUTHORIZATION').delete_prefix('Bearer '))
        ).call
        response.status = result.success? ? 200 : 422
        { result: result.object }.to_json
      end
    end
  end
end
