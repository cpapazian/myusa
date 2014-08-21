class SessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable

  before_action :authenticate_user_from_token!, only: [:new]

  def new
    if !!find_client_id
      @client = Doorkeeper::Application.find_by_uid(find_client_id)
      flash.now[:success] = "<b>Welcome, #{@client.name} user.</b><br/>" \
                            "Use this form to connect #{@client.name} to a MyUSA account " \
                            "and we'll have you back to #{@client.name} in no time.".html_safe
    end    

    super
  end


  def create
    user = User.find_by_email(params[:user][:email]) ||
           User.create!(email: params[:user][:email])

    token = user.set_authentication_token(remember_me: params[:user][:remember_me] == '1')

    # TODO: template with instructions for completing token authentication.
    render text: "CYM, #{user.email}"
  end

  private

  def find_client_id
    client_id = (session[:user_return_to] || '').match(/[\?&;]client_id=([^&;]+)/).try(:[], 1)
    client_id = @pre_auth.client.try(:uid) if client_id.blank? && @pre_auth
    client_id
  end

  def authenticate_user_from_token!
    user_email = params[:email].presence
    user = user_email && User.find_by_email(user_email)

    return unless user && user.authentication_token

    if user.authentication_token_expired?
      flash[:alert] = 'token expired' # TODO: l10n
    elsif user.verify_authentication_token(params[:token])
      user.expire_authentication_token

      if params[:remember_me]
        remember_me user
      end

      sign_in_and_redirect user
    else
      logger.warn "Invalid token #{user.authentication_token} from user " +
                  user.uid
    end
  end
end
