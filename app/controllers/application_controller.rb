require "application_responder"

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  self.responder = ApplicationResponder

  respond_to :json


end
