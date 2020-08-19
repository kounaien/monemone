//= require Chart.min
//= require_self

$(document).on('turbolinks:load', function() {
    var ctx = document.getElementById('myChart');
    var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: JSON.parse(ctx.dataset.label),
        datasets: [{
            label: '円',
            data:JSON.parse(ctx.dataset.data),
            backgroundColor: "rgba(10, 100, 10, 0.1)",
            borderColor: "rgba(10, 150, 10, 1)",
            borderWidth: 1
        }]
    },
    });
});

$(document).on('turbolinks: load', function(){
    $("img").on(click, function(){
        $("#modal").fadeIn(300);
    });
    $("img").on(click, function(){
        $("#modal").fadeOut(300);
    });
});



$(document).on('turbolinks: load', function(){
    $(document).on('keyup', function(e){
        e.preventDefault();
        var input = $.trim($(this).val());
        $.ajax({
            url: '/users/search',
            type: 'GET',
            data: ('keyword=' + input),
            processData: false,
            contentType: false,
            dataType: 'json'
        })
        .done(function(data){
            $('#result').find('li').remove();
            $(data).each(function(i, user){
                $('#result').append('<li>' + user.name +'</li>')
            });
        })
    });
});

