let NotificationNumber = 0;
let AddNotification = (time, image, color, title, message) => {
    NotificationNumber++;
    let notif = NotificationNumber;
    $(".notification-box").append(`
    <div class="notification number-`+ notif +`">
        <div class="notification-image">
            <i class="`+ image +`" style="color: `+ color +`;"></i>
        </div>
        <div class="notification-items">
            <div class="title">`+ title +`</div>
            <div class="message">`+ message +`</div>
        </div>
        <div class="pasek"></div>
    </div>
    `)
    setTimeout(() => {
        new Audio('intuition.mp3').play()
        $(".notification.number-"+ notif).css("opacity", "1");
        $(".notification.number-"+ notif + " > .pasek").animate({
            "width": "0%"
        }, time, function(){
            $(".notification.number-"+ notif).css("opacity", "0");
            $(".notification.number-"+ notif).remove();
        })
    }, 100)
}

window.addEventListener('message', function(event) {
    if (event.data.action == "AddNotification") {
        AddNotification(event.data.time, event.data.image, event.data.color, event.data.title, event.data.message);
    } else if (event.data.action == "SetPosition") {
        $(".notification-box").css("bottom", (event.data.inCar && "13.5vh" || "8.5vh"))
    }
})