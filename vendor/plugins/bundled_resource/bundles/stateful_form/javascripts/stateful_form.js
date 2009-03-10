function remember_visible_state_of(element) {
  var visible_state = (Element.visible(element) ? 1 : 0);
  // Allow optional second argument to override the state
  if (arguments.length > 1) visible_state = (arguments[1] == true || arguments[1] == 1) ? 1 : 0;

  // See if the element has a hidden field where we will store its state
  element = $(element);
  var hidden_field_id = 'visible_state_' + element.id
  var hidden_field = $(hidden_field_id);
  
  if (hidden_field)
    hidden_field.value = visible_state;
  else
    new Insertion.Top(element,
      "<input id='" + hidden_field_id + "' " +
      "name='visible_state[" + element.id + "]' " +
      "type='hidden' value='" + visible_state + "'>");
}
