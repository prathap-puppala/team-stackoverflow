Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "xxxx", "xxxx",{hd: 'freshworks.com' }
end
