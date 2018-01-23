class WelcomeController < ApplicationController
  def index
    @page_title = request.subdomain
  end
end