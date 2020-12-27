# frozen_string_literal: true

class App
  hash_branch 'users' do |r|
    r.on 'sign_up' do
      r.post do
      end
    end
  end
end
