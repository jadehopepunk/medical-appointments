
var max_z_index = 20;

function toggleAppointmentSize(appointment)
{
  var details_child = getDetailsChild(appointment);
  if (Element.hasClassName(appointment, 'collapsed_appointment'))
  {
    // Expand
    Element.addClassName(appointment, 'expanded_appointment'); 
    Element.removeClassName(appointment, 'collapsed_appointment');     
    appointment.style.zIndex = max_z_index++;
    setExpandedAppointmentSize(appointment);   
    new Effect.Appear(details_child, {duration: 0.4});
  }
  else
  {
    // Contract
    Element.addClassName(appointment, 'collapsed_appointment'); 
    Element.removeClassName(appointment, 'expanded_appointment'); 
    setDefaultAppointmentSize(appointment, 0.2);   
    new Effect.Fade(details_child, {duration: 0.2});
  }  
}

function setDefaultAppointmentSize(appointment, duration)
{
  new Effect.ResizeTo(appointment, 175, appointment.getAttribute('duration') - 1, {'duration': duration});  
}

function setExpandedAppointmentSize(appointment)
{
  new Effect.ResizeTo(appointment, 300, 200, {'duration': 0.3});
}

function setInitialAppointmentSize(appointment)
{
  var details_child = getDetailsChild(appointment);
  if (Element.hasClassName(appointment, 'collapsed_appointment'))
  {
    setDefaultAppointmentSize(appointment, 0);
    Element.hide(details_child);
  }
  else
  {
    appointment.style.width = '300px';
    appointment.style.height = '200px';
    Element.show(details_child);
    appointment.style.zIndex = max_z_index++;
  }    
}

function setDefaultSlotSize(slot)
{
  new Effect.ResizeTo(slot, 175, slot.getAttribute('duration'), {duration: 0});  
}

function getDetailsChild(appointment)
{
  var child;
  for (var i = 0; i < appointment.childNodes.length; i++)
  {
    var child = appointment.childNodes[i];
    if (child.className == 'details') return child;
  }
  return null;
}

