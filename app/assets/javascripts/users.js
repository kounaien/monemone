//= require Chart.min

$(document).on('turbolinks:load', function() {
    $('#nav-tab').on('click', function() {
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
});

// $(document).on('turbolinks: load', function(){
//     $("img").on(click, function(){
//         $("#modal").fadeIn(300);
//     });
//     $("img").on(click, function(){
//         $("#modal").fadeOut(300);
//     });
// });
