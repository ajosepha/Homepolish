# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Homepolish::Application.initialize!

Rails::Initializer.run do |config|

  config.gem 'javan-whenever', :lib => false, :source => 'gems.github.com' 

end