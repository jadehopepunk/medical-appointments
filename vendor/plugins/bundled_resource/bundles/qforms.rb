# == Usage ==
# require_bundle :qforms
#
# 1. Name your form, e.g.
#   <form method="post" action="/user/signup" name="signup_form"> ... </form>
#
# 2. Create a qForms object from the named HTML form:
#   <script>
#     signup_form = new qForm("signup_form");
#
# 3. Use qform validation methods to set up the requirements, e.g.:
#     signup_form['user[login]'].required = true;
#     signup_form['user[login]'].description = "Login name";
#
# 4. Done!
#   </script>
#
# == Full qForms Documentation ==
# http://pengoworks.com/qforms/docs/index.htm

module BundledResource::Qforms
  def bundle
    require_javascript "/bundles/qforms/javascripts/qforms"
    # require_javascript "/bundles/qforms/javascripts/qforms/field"
    # require_javascript "/bundles/qforms/javascripts/qforms/functions"
    # require_javascript "/bundles/qforms/javascripts/qforms/validation"
    require_javascript "/bundles/qforms/javascripts/qforms_init"
  end
end