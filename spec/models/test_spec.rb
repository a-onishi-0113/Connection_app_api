require 'rails_helper'

RSpec.describe Test, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe 'ユーザー作成' do
  subject(:user) { create(:user) }
  post api_v1_users
  it { is_expected.to '作成に成功しました'}
end