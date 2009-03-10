require File.dirname(__FILE__) + '/../test_helper'
require 'appointments_controller'

# Re-raise errors caught by the controller.
class AppointmentsController; def rescue_action(e) raise e end; end

class AppointmentsControllerTest < Test::Unit::TestCase
  def setup
    @controller = AppointmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
