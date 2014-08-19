module OauthHelper
  def scope_check_box_tag(scope)
    check_box_tag('scope[]', scope, true,
      id: ('scope_' + scope.gsub(/\./, '_')),
      multiple: true
    )
  end

  def profile_text_field(scope, options={})
    field = Profile.attribute_from_scope(scope)
    value = current_user.profile.send(field)
    if value.present?
      return current_user.profile.send(field)
    else
      options.merge!(placeholder: t("scopes.#{scope}.placeholder"), disabled: value.present?)
      text_field_tag "profile[#{field}]", current_user.profile.send(field), options
    end
  end

  def select_options(scope)
    return gender_options if scope.match(/gender/)
    return marital_status_options if scope.match(/marital/)
    return title_options    if scope.match(/title/)
    return suffix_options   if scope.match(/suffix/)
    return us_state_options if scope.match(/state/)
    return yes_no_options   if scope.match(/(is_parent|is_student|is_veteran)/)
  end

  def profile_select_menu(scope, options={})
    field = Profile.attribute_from_scope(scope)
    value = current_user.profile.send(field)
    options.merge!(include_blank: true, placeholder: t("scopes.#{scope}.placeholder"), disabled: value.present?)
    select_tag "profile[#{field}]", options_for_select(select_options(scope), value), options
  end

  def oauth_deny_link(pre_auth, text, options={})
    error = Doorkeeper::OAuth::ErrorResponse.new(
      state: pre_auth.state,
      name: :access_denied,
      redirect_uri: pre_auth.redirect_uri
    )
    if error.redirectable?
      link_to text, error.redirect_uri, options
    else
      link_to text, oauth_pre_auth_delete_uri(pre_auth), options.merge(method: :delete)
    end
  end

  def oauth_pre_auth_delete_uri(pre_auth)
    oauth_authorization_path(
      client_id: pre_auth.client.uid,
      redirect_uri: pre_auth.redirect_uri,
      state: pre_auth.state,
      response_type: pre_auth.response_type,
      scope: pre_auth.scope
    )
  end
end
