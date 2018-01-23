# Load the rails application
require File.expand_path('../application', __FILE__)

#Comment out this line on the development server:
#Rails.env = ActiveSupport::StringInquirer.new('production') #Set default environment

# Initialize the rails application
Dandy::Application.initialize!
