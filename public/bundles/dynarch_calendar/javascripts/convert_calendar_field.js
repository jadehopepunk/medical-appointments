function convert_date_container_to_dynarch_calendar(object_name, method_name, index, initial_date, initial_display, image_url) {
  ifFormat = "%m/%d/%Y %H:%M";
  daFormat = "%A, %B %d, %Y";

  tag_id   = dynarch_tag_id(object_name, method_name, index);
  
  name_and_id = function(name_multipart, id_postfix) {
    string = "id='";
    string += dynarch_tag_id(object_name, method_name, index) + '_' + id_postfix;
    string += "' name='";
    string += dynarch_tag_name(object_name, method_name + '(' + name_multipart + ')', index);
    string += "'";
    return string;
  }
  
  dynarch_contents  = "";
  // Show the selected date in place of the date_select select boxes:
  dynarch_contents += "<span id='" + tag_id + "_display'>" + initial_display + "</span>\n";
  dynarch_contents += "<img align='absmiddle' alt='Calendar Icon' id='" + tag_id + "_button' src='" + image_url + "' />\n";

  date = Date.parseDate(initial_date, ifFormat);

  // Use a hidden, nameless field to store the date from the dynarch calendar
  dynarch_contents += "<input type='hidden' id='" + tag_id + "_input_field' onChange='update_multiparams(\"" + tag_id + "\", \"" + ifFormat + "\")'>\n";
  
  // Use three hidden, named fields to pass the dates along in a Rails-compatible format
  dynarch_contents += "<input type='hidden' " + name_and_id('1i', 'year') + " value='" + date.getFullYear() + "'>\n";
  dynarch_contents += "<input type='hidden' " + name_and_id('2i', 'month') + " value='" + (date.getMonth() + 1) + "'>\n";
  dynarch_contents += "<input type='hidden' " + name_and_id('3i', 'day') + " value='" + date.getDate() + "'>\n";

  // Replace the default Rails select boxes with our dynarch contents
  //alert("Contents for " + tag_id + '_container' + ": \n" + dynarch_contents);
  container = $(tag_id + '_container');
  container.innerHTML = dynarch_contents;

  Calendar.setup({
    inputField     :    tag_id + '_input_field',
    ifFormat       :    ifFormat,
    displayArea    :    tag_id + '_display',
    daFormat       :    daFormat,
    button         :    tag_id + '_button',
    align          :    "Tl",
    singleClick    :    true,
    cache          :    true
    //showsTime      :    true
  });  
}

function update_multiparams(tag_id, ifFormat) {
  date_string = $(tag_id + '_input_field').value;
  date = Date.parseDate(date_string, ifFormat);
  $(tag_id + '_year').value = date.getFullYear();
  $(tag_id + '_month').value = date.getMonth() + 1;
  $(tag_id + '_day').value = date.getDate();
}

function dynarch_tag_name(object_name, method_name, index) {
  tag_name = object_name.replace('[]', '');
  if (index) tag_name += '[' + index + ']';
  tag_name += '[' + method_name + ']';
  return tag_name;
}

function dynarch_tag_id(object_name, method_name, index) {
  tag_id = object_name.replace('[]', '');
  if (index) tag_id += '_' + index;
  tag_id += '_' + method_name;
  return tag_id;
}