let start = [50, 100, 150, 200, 250];
let speed = [0.25, 0.3, 0.35, 0.4, 0.5];

function doOpen() {

    let location = Math.floor(Math.random() * 5);
    let level = Math.floor(Math.random() * 5);
    // console.log(location);
    // console.log(level)

    let time_left = 15000;

    $('body').css('display', 'block');
    $("#start").css({"left": start[location]});
    $("#end").css({"left": start[location] + 50});

    clearInterval(id2);
    var id2 = setInterval(niebieski, 10)
    function niebieski(){
        if ($("#color").width() >= (start[location] - 10) && $("#color").width() <= (start[location] + 40)){
            $("#progress-bar-color").width($("#progress-bar-color").width() + 1.0)
        }
        else{
            $("#progress-bar-color").width($("#progress-bar-color").width() - 1.5)
        }
        $("#color").width($("#color").width() - speed[level] )
        if($("#progress-bar-color").width() >= 350){
            clearInterval(id2)
            fetch(`https://diablohub_fishing/fishingStatus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    result: 'true'
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
            window.location.reload(true);

        }
        else if (time_left <= 10){
            clearInterval(id2)
            fetch(`https://diablohub_fishing/fishingStatus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    result: 'false'
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
            window.location.reload(true);
        }

        time_left = (time_left - 10);
        timer = time_left / 10;

        let seconds = Math.floor(timer / 100);
        let miliseconds = Math.floor(timer % 100)
        let display = (seconds + ":" + miliseconds)
        if (miliseconds < 10){
            display = (seconds + ":0" + miliseconds)
        }
        $("#timer").text(display)
    }

    //tutaj klikanie X
    $(document).on("keyup", function(e) {
        if(e.which == 88){ //<- to jest wybieranie jaki przycisk
            clearInterval(id2)
            fetch(`https://diablohub_fishing/fishingStatus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    result: 'cancel'
                    
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
            window.location.reload(true);
        }
    })
}

$(document).on("keyup", function(e) {
    if(e.which == 32){
        $("#color").width($("#color").width() + 10);
    }
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        doOpen();
    }
});
