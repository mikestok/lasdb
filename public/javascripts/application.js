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
  var old_html = $(link).parent().prev("ol").html();
  var new_html = old_html + content.replace(regexp, new_id);
  $(link).parent().prev("ol").html(new_html);
}
