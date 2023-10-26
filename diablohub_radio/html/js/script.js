$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('https://diablohub_radio/join', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();
    $.post('https://diablohub_radio/leave');
});

$(document).on('click', '#volumeUp', function(e){
    e.preventDefault();

    $.post('https://qb-radio/volumeUp', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#volumeDown', function(e){
    e.preventDefault();

    $.post('https://qb-radio/volumeDown', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#poweredOff', function(e){
    e.preventDefault();

    $.post('https://diablohub_radio/leave');
});

Open = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 250);
}

Close = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "open") {
            Open()
        }

        if (event.data.type == "close") {
            Close()
        }

        if (event.data.type == "update") {
            if (event.data.show){
                $(".users-list").html("");
                $(".channel-users").html(event.data.number);
                $(".channel-name").html(event.data.name);
                $(".radiolist").fadeIn();
                let users = event.data.users
                users.forEach(element => {
                    if (element !== null && element.label !== null){
                        $(".users-list").append(`
                            <div class="user `+ (element.active && "active" || "") +`">`+ element.label +`</div>
                        `);
                    }
                });
            } else {
                $(".radiolist").fadeOut();
            }
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://diablohub_radio/close', JSON.stringify({}));
            Close()
        } else if (data.which == 13) {
            $.post('https://diablohub_radio/join', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});