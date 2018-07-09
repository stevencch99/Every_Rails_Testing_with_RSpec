require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projects
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add this block to prevent default generator to generates useless files
    config.generators do |g|
      g.test_framework :rspec,

        # 禁止生成便于在测试数据库中创建对象的文件。
        # （進入第四章後再恢復）
        # fixtures: false,

        # To skip view test
        view_specs: false,
        # helper_specs: 生成控制器时不生成对应的辅助方法测试文件。如果你觉得有必要，可以把这个选项设为 true，对辅助方法进行测试。
        helper_specs: false,
        # routing_specs: to skip generation of test files of routing test,
        # we can only skip this test when routes is not very complex
        routing_specs: false,
        request_specs: false
    end
  end
end
