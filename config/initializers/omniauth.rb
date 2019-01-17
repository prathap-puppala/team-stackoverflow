Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "162666659638-cfedm9obknvhh2tmmfnsb7hd9ilab7eu.apps.googleusercontent.com", "EHsN7zzyVZs1sT1R4V_O5T2h",{hd: 'freshworks.com' }
end