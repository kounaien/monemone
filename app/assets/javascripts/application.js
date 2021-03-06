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
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function() {
    $(document).on('keyup', '#keyword', function(e){
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
            $('#result').show();
            $('#result').find('li').remove();
            $(data).each(function(i, user){
                $('#result').append('<li>' + '<a href="/users/' + user.id + '">' + user.name + '</a>' + '</li>')
            });
            var count = $('#keyword').val().length;
            if ( count == 0 ) {
                $('#result').find('li').remove();
                $('#result').css('display', 'none')
            }
        })
    });
});

$(document).on('turbolinks:load', function(){
    $(document).on('click', function(){
        $('#result').find('li').remove();
        $('#result').css('display', 'none')
    })
})