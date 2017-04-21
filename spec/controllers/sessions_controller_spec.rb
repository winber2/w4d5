require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the sign in page' do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'redirects to the user page' do
        User.create!(username: 'i_am_real', password: 'at_least_for_now')
        post :create, params: { user: { username: 'i_am_real', password: 'at_least_for_now' } }

        expect(response).to redirect_to(user_url(User.find_by(username: 'i_am_real')))
      end

      it 'logs the user in' do
        User.create!(username: 'logmein_baby', password: 'i_dont_bite')
        post :create, params: { user: { username: 'logmein_baby', password: 'i_dont_bite' } }

        expect(User.find_by(session_token: session[:session_token]).id)
          .to eq(User.find_by(username: 'logmein_baby').id)
      end
    end

    context 'with invalid params' do
      it 'validates the presence of username and password' do
        post :create, params: { user: { username: 'fukboi' } }

        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
