let sirenButtons = [
    'siren1-1',
    'siren1-2',
    'siren1-3',
    // 'siren2-1',
    // 'siren2-2',
    // 'siren2-3',
    'siren3-1',
    'siren3-2',
    'siren4-1',
    'siren4-2',
    'siren4-3',
    'siren-aux'
]

let controllerButtonsState = {
    code: 1,
    horn: 0,
    manual: 0,
    siren1: 0,
    siren2: 0,
    aux: 0
};

function sirenController() {
    for (let x = 0; x < sirenButtons.length; x++) {
        // console.log(sirenButtons[x])
        document.getElementById(sirenButtons[x]).classList.remove('siren-active-green');
        document.getElementById(sirenButtons[x]).classList.remove('siren-active-red');
        document.getElementById(sirenButtons[x]).classList.remove('siren-active-blue');
        document.getElementById(sirenButtons[x]).classList.remove('siren-active-orange');
    }
    document.getElementById("siren4-" + controllerButtonsState.code).classList.add('siren-active-red');
    if (controllerButtonsState.horn) {
        document.getElementById("siren3-1").classList.add('siren-active-red');
    }
    if (controllerButtonsState.manual) {
        document.getElementById("siren3-2").classList.add('siren-active-orange');
    }
    if (controllerButtonsState.aux) {
        document.getElementById("siren-aux").classList.add('siren-active-blue');
    }
    if (controllerButtonsState.siren1) {
        document.getElementById("siren1-" + controllerButtonsState.siren1).classList.add('siren-active-green');
    }
    if (controllerButtonsState.siren2) {
        document.getElementById("siren2-" + controllerButtonsState.siren2).classList.add('siren-active-green');
    }
}

function showHidesirenController(state) {
    if (state == 0) {
        $('#sc').hide();
    } else {
        $('#sc').show();
    }
}

window.addEventListener('message', (event) => {
    let data = event.data

    switch (data.action) {
        case "toggleSirenControl":
            showHidesirenController(data.state)
            break;
        case "sirenControlCode":
            controllerButtonsState['code'] = data.state
            sirenController()
            break;
        case "sirenControlHorn":
            controllerButtonsState['horn'] = data.state
            sirenController()
            break;
        case "sirenControlManual":
            controllerButtonsState['manual'] = data.state
            sirenController()
            break;
        case "sirenControlSiren1":
            controllerButtonsState['siren1'] = data.state
            sirenController()
            break;
        case "sirenControlSiren2":
            controllerButtonsState['siren2'] = data.state
            sirenController()
            break;
        case "sirenControlAux":
            controllerButtonsState['aux'] = data.state
            sirenController()
            break;
        default:
            break;
    }
});