smtp_config = BasicConfig.load_file('config/smtp.yml')

ActionMailer::Base.smtp_settings = smtp_config
