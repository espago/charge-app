ESPAGO_SETTINGS = YAML.load_file("#{::Rails.root.to_s}/config/espago.yml")[::Rails.env.to_s]

Espago.app_id       = ESPAGO_SETTINGS['app_id']
Espago.app_password = ESPAGO_SETTINGS['app_password']
Espago.public_key   = ESPAGO_SETTINGS['public_key']
Espago.production   = ESPAGO_SETTINGS['production']