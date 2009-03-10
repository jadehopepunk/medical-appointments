require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/red_hill_consulting/cascading_javascripts'

module RedHillConsulting
  module CascadingJavascripts
    RAILS_ROOT = File.dirname(__FILE__) + "/.."
  end
  
  class CascadingJavascriptsTest < Test::Unit::TestCase
    def setup
      @controller = self
    end

    def controller_name
      "controller"
    end

    def action_name
      method_name
    end
    
    def javascript_include_tag(*sources)
      sources.join(", ")
    end

    def test_no_defaults
      output = javascript_include_tag("a", "b", "c")
      assert_equal "a, b, c", output
    end
    
    def test_defaults_with_javascript_for_action
      output = javascript_include_tag(:defaults)
      assert_equal "defaults, controller/#{method_name}", output
    end
    
    def test_defaults_without_javascript_for_action
      output = javascript_include_tag(:defaults)
      assert_equal "defaults", output
    end

    include CascadingJavascripts::Base
  end
end
