$(document).ready(function () {
  var background = false;

  /**
   * Authorization page
   */
  $(".scope-list li").each(function(){
    if($(this).children().find('input[type=text]').length < 1){
      $(this).children().eq(1).hide();
      $(this).children().eq(0).toggleClass("open");
    }
  });

  $(".scope-list li h2").click(function () {
    $(this).toggleClass("open");
    $(this).parent().children().eq(1).slideToggle();
  });

  $(".scope-list input[type='checkbox']").click(function (e) {
    // if something is checked, abort
    if ($(this).is(":checked")) {
      // if the empty alert is visible, hide it
      if ($("#scopes-alert-none").is(":visible")) {
        $("#scopes-alert-none").slideToggle({ complete: function() {
          $("#scopes-alert-none").addClass('hidden');
        }});
      }
      return;
    }
    var checkboxes = $(".scope-list input[type='checkbox']");
    var checked = false;
    // check if any of the checkboxes are check
    for (var i = 0; i < checkboxes.length; i++) {
      if ($(checkboxes[i]).is(":checked") === true) {
        checked = true;
        break;
      }
    }
    // if none are checked, show the alert message
    if (checked === false) {
      $("#scopes-alert-none").slideToggle().removeClass('hidden');
    }
  });

  $(".more-options").show();
  // hide or show the sign in buttons
  $(".more-options").click(function (e) {
    $(".hidden-buttons").show(400);
    $(".more-options").hide();
    $(".less-options").show();
  });
  $(".less-options").click(function (e) {
    $(".hidden-buttons").hide(400);
    $(".less-options").hide();
    $(".more-options").show();
  });

  // toggle sign in and sign up forms
  $("#cta-signin").click(function (e) {
    console.log(e);
    $("#cta-signin").hide();
    $("#cta-signup").show();
    $(".content-signup").hide();
    $(".content-signin").show();
  });
  $("#cta-signup").click(function (e) {
    console.log(e);
    $("#cta-signup").hide();
    $("#cta-signin").show();
    $(".content-signin").hide();
    $(".content-signup").show();
  });

  // DEBUG functions
  $("#debug-hide").click(function (e) {
    $(".debug").hide(400);
  });
  $("#debug-toggle").click(function (e) {
    // non-white buttons showing
    if ($($(".content-signin .btn")[0]).hasClass('btn-google')) {
      var buttons = ["btn-google", "btn-paypal", "btn-symantec"];
      for (var i = 0; i < buttons.length; i++) {
        var b = $($("." + buttons[i])[0]);
        b.removeClass(buttons[i]);
        b.addClass(buttons[i]+"-white");        
      }
    }
    // white buttons showing
    else {
      var buttons = ["btn-google", "btn-paypal", "btn-symantec"];
      for (var i = 0; i < buttons.length; i++) {
        var b = $($("." + buttons[i] + "-white")[0]);
        b.removeClass(buttons[i] + "-white");
        b.addClass(buttons[i]);        
      }
    }
  });
});
