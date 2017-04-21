require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe 'GET #new' do
    it 'should render the new goal page' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'should show the new goal show page' do
        current_user = User.new(id: 1)
        post :create, params: { goal: { name: 'lol i ain\' finishing this' } }

        expect(response).to redirect_to(goal_url(1))
      end
    end

    context 'with invalid params' do
      it 'should stay on the new goal page' do
        post :create, params: { goal: { user_id: 1} }

        expect(response).to redirect_to(new_goal_url)
      end
    end
  end

  describe 'GET #edit' do
    it 'should show the goal edit page' do
      User.create(username: 'dumdum', password: 'mudmud')
      Goal.create(user_id: 1, name: 'goodbye cruel world')
      get :edit, params: { id: 1 }

      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'should redirect user to the user show page' do
      User.create(username: 'dumdum', password: 'mudmud')
      Goal.create(user_id: 1, name: 'goodbye cruel world')
      delete :destroy, params: { id: 1 }

      expect(response).to redirect_to(users_url)
    end
  end
end
