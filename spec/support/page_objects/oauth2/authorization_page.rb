require 'site_prism'
class OAuth2::AuthorizationPage < SitePrism::Page
  set_url '/oauth/authorize'
  set_url_matcher /\/oauth\/authorize/

  element :scopes, '.scope-list'

  element :profile_email, "input#profile_email"
  element :profile_last_name, "input#profile_last_name"
  element :profile_phone_number, "input#profile_phone_number"

  element :allow_button, "input[value='Allow Access']"
  element :cancel_button, "a[contains('No Thanks')]"

  element :head_back_link, "p[contains('head back to')]/a:first"
  element :error_message, "div.page-header[contains('An error has occurred')] ~ main"

  element :flash_error_message, "div.alert.alert-danger"
  element :oauth_error_message, "div.page-header[contains('An error has occurred')] ~ main"

  element :header, 'header'
  element :footer, 'footer'
  element :sign_in_button, "#myusa-connect"
  element :settings, "#settings"
  element :private_nav, "#private-nav"
  element :public_nav, "#public-nav"
  element :ownership, "footer[contains('MyUSA is an official website of the United States Government')]"
end



html, body {
  font-family: 'Open Sans', 'sans-serif';  
  height: 100%;
}

.container:first-child{
  min-height:100%;
}

.main {
  position: relative;
  margin-top: 5%;
  left: 50%;
  margin-left: -410px;
  padding-left: 150px;
  padding-right: 150px;
  height: auto;
  width: 820px;
  z-index: 10;
  /*box-shadow: 1px 1px 1px #888888;*/
}
