# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( one.css)
Rails.application.config.assets.precompile += %w( plugins/bootstrap.min.css)
Rails.application.config.assets.precompile += %w( style.css)
Rails.application.config.assets.precompile += %w( one.style.css)

Rails.application.config.assets.precompile += %w( plugins/line-icons.css)
Rails.application.config.assets.precompile += %w( plugins/font-awesome/css/font-awesome.min.css)
Rails.application.config.assets.precompile += %w( plugins/img-hover.css)
Rails.application.config.assets.precompile += %w( sky-forms.css)
Rails.application.config.assets.precompile += %w( custom-sky-forms.css)

Rails.application.config.assets.precompile += %w( pages/blog.css)
Rails.application.config.assets.precompile += %w( pages/page_log_reg_v1.css)

Rails.application.config.assets.precompile += %w( theme-colors/default.css)
Rails.application.config.assets.precompile += %w( shop.style.css)
Rails.application.config.assets.precompile += %w( plugins/perfect-scrollbar.css)
Rails.application.config.assets.precompile += %w( plugins/owl.carousel.css)
Rails.application.config.assets.precompile += %w( plugins/settings.css)
Rails.application.config.assets.precompile += %w( pages/page_job.css)

Rails.application.config.assets.precompile += %w( custom.css)
Rails.application.config.assets.precompile += %w( common.css)

Rails.application.config.assets.precompile += %w( plugins/jquery-migrate.min.js)
Rails.application.config.assets.precompile += %w( plugins/bootstrap.min.js)

Rails.application.config.assets.precompile += %w( plugins/back-to-top.js)
Rails.application.config.assets.precompile += %w( plugins/owl.carousel.js)
Rails.application.config.assets.precompile += %w( plugins/jquery.mousewheel.js)
Rails.application.config.assets.precompile += %w( plugins/perfect-scrollbar.js)
Rails.application.config.assets.precompile += %w( plugins/jquery.parallax.js)
Rails.application.config.assets.precompile += %w( plugins/jquery.themepunch.tools.min.js)
Rails.application.config.assets.precompile += %w( plugins/jquery.themepunch.revolution.min.js)
Rails.application.config.assets.precompile += %w( plugins/moment-with-locales.js)

Rails.application.config.assets.precompile += %w( custom.js)

Rails.application.config.assets.precompile += %w( shop.app.js)
Rails.application.config.assets.precompile += %w( plugins/owl-carousel.js)
Rails.application.config.assets.precompile += %w( plugins/revolution-slider.js)
Rails.application.config.assets.precompile += %w( plugins/Chart.min.js)


Rails.application.config.assets.precompile += %w( common.js)
