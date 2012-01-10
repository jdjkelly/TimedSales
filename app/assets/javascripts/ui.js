$(document).ready(function() {
	// init Chosen on selects
	$('.chzn-select').chosen();

	// Process AJAX request when product is select
	$("#new-product").bind('ajax:success', function(evt, data, status, xhr){
      var select = $('#new-variant');

      if (data !== null) {
        select.removeAttr('disabled');
        select.children().remove();
        $.each(data.variants, function(index) {
          $("<option/>").appendTo(select);
        	$("<option/>").val(data.variants[index].id).text(data.variants[index].title).appendTo(select);
        });
        select.trigger("liszt:updated");
      } else {
        select.empty();
        select.attr('disabled', 'disabled');
      }
    });

  $('#new-variant').bind('ajax:success', function(evt, data, status, xhr){
      var input = $('#new-price');

      if (data !== null) {
        ... insert it into placeholder
      }
      // var selected = document.getElementById("new-variant").selectedIndex;
  });

  // init date pickers
  $("#start_date, #end_date").datepicker();

  //init time pickers
  $("#start_time, #end_time").timePicker({
	  startTime: "00.00", // Using string. Can take string or Date object.
	  show24Hours: false,
  	separator: '.',
  	step: 15});

});