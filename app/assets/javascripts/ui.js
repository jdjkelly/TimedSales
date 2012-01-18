$(document).ready(function() {
	// init Chosen on selects
	$('.chzn-select').chosen();

  // Make sure that only integers can be entered in sale field
  $('#sale_price').numeric({ negative: false }, function() { alert("Hey let's keep things positive around here."); });

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

  // Process AJAX request when variant is selected (adds exiting price to price input)
  $('#new-variant').bind('ajax:success', function(evt, data, status, xhr){
      var input = $('#sale_price');

      if (data !== null) {
        input.attr("placeholder", data.price);
      }
      // var selected = document.getElementById("new-variant").selectedIndex;
  });

  //init time pickers
  $("#start_time, #end_time").timePicker({
	  startTime: "00:00", // Using string. Can take string or Date object.
	  show24Hours: false,
  	separator: ':',
  	step: 30});

  //bind login button to form submit
  $(".login-form .form-submit").bind("click", function() {
    $(".login-form").animate(
      {
        "top":  $(document).scrollTop() - 100 + 'px',
        "opacity": 0
      },   
      700 / 2, 
      function ()
      {
        $(".login-form").css({'top': -100, 'opacity': 1, 'visibility': 'hidden'});   
      }
    ).children("form").submit();
  });

  //init date picker
  var dates = $( "#start_date, #end_date" ).datepicker({ 
    onSelect: function( selectedDate ) {
      var option = this.id == "start_date" ? "minDate" : "maxDate",
        instance = $( this ).data( "datepicker" ),
        date = $.datepicker.parseDate(
          instance.settings.dateFormat ||
          $.datepicker._defaults.dateFormat,
          selectedDate, instance.settings );
      dates.not( this ).datepicker( "option", option, date );
    }
  });

  $(".savebutton").bind("click", function() {
    $(this).parents("form").submit();

    $("#new_sale").bind('ajax:success', function(evt, data, status, xhr){

    if (data !== null) {
      // select.removeAttr('disabled');
      // select.children().remove();
      // $.each(data.variants, function(index) {
      //   $("<option/>").appendTo(select);
      //   $("<option/>").val(data.variants[index].id).text(data.variants[index].title).appendTo(select);
      // });
      // select.trigger("liszt:updated");
    // } else {
    //   select.empty();
    //   select.attr('disabled', 'disabled');
    // }
      alert(data)
    }
  });
  })

  $(".deletebutton").live('ajax:success', function(evt, data, status, xhr){
    $(this).closest('tr').fadeOut();
  });
  
  $('.upcoming table').tablesorter({
     sortList: [[2,0]] 
    
  }); 


  
});