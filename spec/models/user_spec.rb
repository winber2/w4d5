require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryGirl.build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe '::ensure_session_token' do
    it 'sets session token if empty' do
      fool = User.create(username: "foolish_being", password: "unrelenting_stupidity")

      expect(fool.session_token).to_not be nil
    end
  end

  describe '#reset_session_token!' do
    it 'gives user a new token' do
      token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(token)
    end
  end

  # describe 'associations' do
  #   it {should have_many}
  # end
end
