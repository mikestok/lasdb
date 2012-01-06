// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function remove_fields(link) {
	$(link).prev("input[type=hidden]").val("1"); // the _destroy field
	$(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
	$(link).parent().before(content.replace(regexp, new_id));
}

// This is used to add an element to the end of an ordered list, where
// we have
// <ol>
//   <li class="fields">
//     <p>
//       ....
//     </p>
//   </li>
// </ol>
// <p>
//   <link to add a field to preceding list />
// </p>
function add_fields_to_list(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
  var old_html = $(link).parent().prev("ul").html();
  var new_html = old_html + content.replace(regexp, new_id);
  $(link).parent().prev("ul").html(new_html);
}
