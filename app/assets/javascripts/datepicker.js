$(function() {
  $('.date').datepicker({
      format: "dd-mm-yyyy",
      startDate: new Date(),
      endDate: "01/01/2017",
      todayBtn: "linked",
      autoclose: true,
      todayHighlight: true
  });
});