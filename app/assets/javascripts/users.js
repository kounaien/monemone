//= require Chart.min
//= require_self

$(document).on('turbolinks:load', function() {
    var ctx = document.getElementById('myChart');
    var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: 'posts fee',
            data: [12, 19, 3, 5, 2, 3],
            borderWidth: 1
        }]
    },
    });
});
