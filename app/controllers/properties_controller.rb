class PropertiesController < ApplicationController
  before_action :logged_in_user

  def new
    @property = Property.new
  end
  
end
