//= require Chart.min
//= require_self

$(document).on('turbolinks:load', function() {
    var ctx = document.getElementById('myChart');
    var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: JSON.parse(ctx.dataset.label),
        datasets: [{
            label: 'posts fee',
            data:JSON.parse(ctx.dataset.data),
            borderWidth: 1
        }]
    },
    });
});
