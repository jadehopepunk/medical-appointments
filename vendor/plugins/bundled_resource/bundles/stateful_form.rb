# == Usage ==
# require_bundle :stateful_form
#
#
# == Full Stateful Form Documentation ==
# ?

module BundledResource::StatefulForm
  def bundle
    require_javascript "/bundles/stateful_form/javascripts/stateful_form"
  end
  
  module Helper
    # Returns true or false depending on the visible state of the element.
    def visible_state(element_id)
      (params[:visible_state][element_id.to_sym] == '1') rescue visible_state_get_default(element_id)
    end

    # Returns 'block' or 'none' depending on the visible state of the element.
    def css_visible_state(element_id)
      visible_state(element_id) ? 'block' : 'none'
    end

    # Outputs a hidden_state_tag for each element that has a known state.  The element's
    # state is 'known' if,
    #  a) the params[:visible_state] hash includes the element's id, or
    #  b) the element's default state has been stored via a previous all to visible_state_set_default
    #
    # Call perpetuate_visible_states once within of a view's form tags to perpetuate the
    # visible (or hidden) states of sections of the form.
    def perpetuate_visible_states
      buffer = ""
      known_states = []
      known_states |= params[:visible_state].keys if params[:visible_state]
      known_states |= @visible_state_default.keys if @visible_state_default
      for element_id in known_states
        logger.warn "(Stateful Form) Perpetuating visible state #{element_id}: #{visible_state(element_id)}"
        buffer << hidden_state_tag(element_id)
      end
      buffer
    end

    def visible_state_set_default(element_id, state = true)
      @visible_state_default ||= Hash.new
      @visible_state_default[element_id.to_sym] = state
    end

    def visible_state_get_default(element_id)
      @visible_state_default ||= Hash.new
      @visible_state_default[element_id.to_sym] || false
    end

    # Show an html input tag (type='hidden') to preserve state information
    # about some other element's visible state.  Calling hidden_state_tag
    # multiple times on the same element_id will result in only ONE tag being
    # written unless force_write is set to true.
    # If +boolean_value+ is nil, the the current visible_state will be used.
    def hidden_state_tag(element_id, boolean_value = nil, force_write = false)
      @visible_state_perpetuated ||= []
      if boolean_value.nil?
        value = visible_state(element_id) ? 1 : 0
      else
        value = boolean_value ? 1 : 0
      end
      buffer = ""
      if force_write or !@visible_state_perpetuated.include?(element_id)
        buffer = hidden_field_tag("visible_state[#{element_id}]", value, :id => "visible_state_#{element_id}")
        @visible_state_perpetuated << element_id
      end
      buffer
    end
  end
end

