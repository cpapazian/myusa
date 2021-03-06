require 'rails_helper'

describe SessionsController do
  let(:email) { 'testy@test.gov' }
  let(:date) { Date.new(1999, 12, 31) }

  before :each do
    Timecop.freeze(date)
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  after :each do
    Timecop.return
  end

  describe '#new' do
    it 'renders a template' do
      get :new
      expect(response).to render_template(:new)
    end

    context 'email and token are present' do
      let(:user) { User.create(email: email) }

      context 'and are valid' do
        before :each do
          token = AuthenticationToken.generate(
            user_id: user.id,
            remember_me: self.respond_to?(:remember_me) ? remember_me : nil,
            return_to: self.respond_to?(:return_to) ? return_to : nil
          )

          get :new,
            :email => user.email,
            :token => token.raw
        end

        it 'logs in the user' do
          expect(controller.current_user).to be
          expect(controller.current_user.email).to eq(user.email)
        end

        it 'expires the token' do
          expect(AuthenticationToken.find_by_user_id(user.id)).to_not be_valid
        end

        context 'return to path is not set' do
          it 'redirects to the root path' do
            expect(response).to redirect_to(root_path)
          end
        end
        context 'return to path is set' do
          let(:return_to) { secret_path }

          it 'redirects to the return path' do
            expect(response).to redirect_to(return_to)
          end
        end

        context 'remember_me is set' do
          let(:remember_me) { true }

          it 'sets the remember cookie' do
            expect(response.cookies).to have_key('remember_user_token')
          end
        end

        context 'remember_me is not set' do
          it 'does not set the remember cookie' do
            expect(response.cookies).to_not have_key('remember_user_token')
          end
        end

      end
    end
  end

  describe '#create' do
    shared_examples "token creation" do

      it 'creates a token' do
        expect(AuthenticationToken.find_by_user_id(@user.id)).to be
      end

    end

    context 'when user does not exist' do
      before :each do
        expect(User.find_by_email(email)).to be_nil

        post :create, :user => {
          email: email
        }

        @user = User.find_by_email(email)
      end

      it 'creates a new user' do
        expect(@user).to be
      end

      include_examples "token creation"

    end

    context 'when user already exists' do
      before :each do
        @user = User.create(email: email)

        post :create, :user => {
          email: email
        }

        @user.reload
      end

      include_examples "token creation"
    end
  end

end
