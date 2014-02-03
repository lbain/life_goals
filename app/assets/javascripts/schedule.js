function get_day(task) {
  return task.closest('.day')
}

function get_date_from_day(day) {
  return day.find('.date')[0].getAttribute('date')
}

function get_date(task){
  day = get_day(task)
  return get_date_from_day($(day))
}

function update_date(task) {
  var date = get_date(task)
  task.find('#task_due_date').val(date)
}

function submit_task_form(form) {
  $.ajax({
         type: 'PUT',
         url: form.attr('action'),
         data: form.serialize()
       });
}

$(function() {
  $( ".tasks" ).sortable({
    connectWith: ".tasks",
    stop : function (e) {
      var task = $(e.toElement).closest('.task')[0]
      update_date($(task))
      submit_task_form($(task).find('form'))
    }
  }).disableSelection();

  $('form.task :input').each(function() {
    $(this).change(function(){
      submit_task_form($(this).closest('form'))
    })
  })
});