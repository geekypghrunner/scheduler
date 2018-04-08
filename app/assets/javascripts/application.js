/*global $*/
/*global jQuery */

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker

$( document ).on('turbolinks:load', function() {
    $("input[id=daily_task]").click(function() {
        if($(this).is(':checked')) {
            $('#todo_date').css('display', 'block');
            $("input[name=todo]").prop("checked","");
        } else {
            $('#todo_date').css('display', 'none');
            $("input[name=todo]").prop("checked","checked");
        }
    });
    $("input[name=todo]").click(function() {
        if($(this).is(':checked')) {
            $("input[id=daily_task]").prop("checked","");
            $('#todo_date').css('display', 'none');
        } else {
            $('#todo_date').css('display', 'block');
            $("input[id=daily_task]").prop("checked","checked");
        }
    });    
    $("#new_task").bind("ajax:complete", function(event,xhr,status){
        $("input[name=summary]").val('');
        $("input[name=date]").val('');
        $("input[name=todo]").prop("checked","checked");
        $("input[id=daily_task]").prop("checked","");
        $('#todo_date').css('display', 'none');
    });
    
    
    $(document).on("click", ".checking", function(event) {
        $(this).siblings("input[value=Update]").trigger("click");
    });
    
});