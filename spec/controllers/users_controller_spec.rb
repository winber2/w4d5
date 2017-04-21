require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders sign up page' do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'redirects to the user page' do
        post :create, params: { user: { username: 'degen_man', password: 'killme'} }

        expect(response).to redirect_to(user_url(User.find_by(username: 'degen_man')))
      end

      it 'logs the user in' do
        post :create, params: { user: { username: 'logmein_baby', password: 'i_dont_bite' } }

        expect(User.find_by(session_token: session[:session_token]).id)
          .to eq(User.find_by(username: 'logmein_baby').id)
      end
    end

    context 'with invalid params' do
      it 'validates the presence of username and password' do
        post :create, params: { user: { username: 'fukboi' } }

        expect(response).to redirect_to(new_user_url)
      end
    end
  end

  describe 'GET #show' do
    it 'renders the user page' do
      User.create!(username: 'not_popular', password: 'but_still_shown')
      get :show, params: { id: 1 }

      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'redirects to the editing page' do
      User.create!(username: 'my_password_sucks', password: 'but_not_anymore')
      get :edit, params: { id: 1 }

      expect(response).to render_template(:edit)
    end
  end

end
