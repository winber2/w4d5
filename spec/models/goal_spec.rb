require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:goal_status).in_array([false, true]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#complete!' do
    it 'should set goal status to true' do
      User.create!(username: 'i_have_dreams', password: 'but_no_determination')
      goal = Goal.new(user_id: 1, name: 'no more ice cream!!', body: 'i am too fat')

      expect(goal.goal_status).to be false
      goal.complete!
      expect(goal.goal_status).to be true
    end
  end
end
