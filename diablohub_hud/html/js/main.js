const Root = document.querySelector(":root");
var hudsettings = false;

window.onload = function (e) {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "setuphud":
        SetupHud();
        break;
      case "openui":
        OpenUi();
        break;
      case "closeui":
        CloseUi();
        break;
      case "updatewatermark":
        UpdateWatermark(event.data.watermark);
        break;
      case "updatevoice":
        UpdateVoice(event.data.voice);
        break;
      case "updatevehicle":
        UpdateVehicle(event.data.vehicle);
        break;
      case "updatehud":
        UpdateHud(event.data.hud);
        break;
      case "updatestreetlabael":
        UpdateStreetLabael(event.data.label);
        break;
      case "switchhud":
        SwitchHud(event.data.switchHud);
        break;
      case "updatespeedometer":
        UpdateSpeedometer(event.data.car);
        break;
      case "setenginestatus":
        SetEngineStatus(event.data.engine);
        break;
      case "setbeltstatus":
        SetBeltStatus(event.data.belt);
        break;
      case "updatetempomat":
        UpdateTempomatStatus(event.data.status);
        break;
      case "setcam":
        SetCam(event.data.status);
        break;
      default:
        break;
    }
  });
};

document.getElementById("change_primary").addEventListener("input", function () {
  Root.style.setProperty("--primaryColor", this.value);
  localStorage.setItem("change_primary-style", this.value);
});

// document.getElementById("change_secondary").addEventListener("input", function () {
//   Root.style.setProperty("--secondaryColor", this.value);
//   localStorage.setItem("change_secondary-style", this.value);
// });

function SetupHud() {
  if (localStorage.getItem("hud-style") == null) {
    localStorage.setItem("hud-style", "romb");
    ChangeHud('romb')
  } else {
    $('#hud-settings').val(localStorage.getItem("hud-style"));
    ChangeHud(localStorage.getItem("hud-style"))
  }

  if (localStorage.getItem("change_primary-style") == null) {
    localStorage.setItem("change_primary-style", "#fc0303;");
    $('#change_primary').val('#fc0303;');
  } else {
    var color = localStorage.getItem("change_primary-style");
    Root.style.setProperty("--primaryColor", color);
    $('#change_primary').val(color);
  }

  if (JSON.parse(localStorage.getItem("watermark-box")) == null) {
    localStorage.setItem("watermark-box", true);
    SwitchHud({ watermark: true });
    $("#watermark-switch").attr("checked", true);
  } else if (JSON.parse(localStorage.getItem("watermark-box"))) {
    SwitchHud({ watermark: true });
    $("#watermark-switch").attr("checked", true);
  } else {
    SwitchHud({ watermark: false });
    $("#watermark-switch").attr("checked", false);
  }

  if (JSON.parse(localStorage.getItem("allhud-box")) == null) {
    localStorage.setItem("allhud-box", true);
    SwitchHud({ hud: true });
    $("#allhud-switch").attr("checked", true);
  } else if (JSON.parse(localStorage.getItem("allhud-box"))) {
    SwitchHud({ hud: true });
    $("#allhud-switch").attr("checked", true);
  } else {
    SwitchHud({ hud: false });
    $("#allhud-switch").attr("checked", false);
  }

  if (JSON.parse(localStorage.getItem("carhud-box")) == null) {
    localStorage.setItem("carhud-box", true);
    SwitchHud({ streetlabael: true, speedometer: true });
    $("#carhud-switch").attr("checked", true);
  } else if (JSON.parse(localStorage.getItem("carhud-box"))) {
    SwitchHud({ streetlabael: true, speedometer: true });
    $("#carhud-switch").attr("checked", true);
  } else {
    SwitchHud({ streetlabael: false, speedometer: false });
    $("#carhud-switch").attr("checked", false);
  }

  setTimeout(() => {
    $(".main").fadeIn();
  }, "500");
}

function SetCam(status) {
  if (status) {
    $("#cam-switch").attr("checked", true);
    SwitchHud({ hud: false, watermark: false ,streetlabael: false, speedometer: false });
    $('#cam').fadeIn();
  } else {
    $("#cam-switch").attr("checked", false);
    SwitchHud({ hud: true, watermark: true ,streetlabael: true, speedometer: true });
    $('#cam').fadeOut();
  }
}

function UpdateTempomatStatus(value) {
  if (value) {
    $(".tempomat-icon").css("color", "var(--primaryColor)");
  } else {
    $(".tempomat-icon").css("color", "#747474");
  }
}

function SetBeltStatus(belt) {
  if (belt) {
    $(".belt-icon").css("color", "var(--primaryColor)");
  } else {
    $(".belt-icon").css("color", "#747474");
  }
}

function SetEngineStatus(engine) {
  if (engine) {
    $(".engine-icon").css("color", "var(--primaryColor)");
  } else {
    $(".engine-icon").css("color", "#747474");
  }
}

function UpdateSpeedometer(data) {
  $("#progressbar_server-table-947").css(
    "stroke-dasharray",
    "calc(97.6754 + " +
      data.percentRPM * 95 +
      "), calc(97.6754 + " +
      data.percentRPM * 95 +
      ")"
  );
  $("#speed-1").html(data.speed1);
  $("#speed-2").html(data.speed2);
  $("#speed-3").html(data.speed3);

  $("#fuel").html(data.fuel + "%");
}

function UpdateStreetLabael(label) {
  $(".streetlabael-label").html(label);
}

function UpdateVehicle(vehicle) {
  if (vehicle) {
    SwitchHud({ streetlabael: true, speedometer: true });
  } else {
    SwitchHud({ streetlabael: false, speedometer: false });
  }
}

function UpdateVoice(voice) {
  if (voice) {
    $(".hud__bg--voice").css("background-color", "red");
  } else {
    $(".hud__bg--voice").css("background-color", "var(--primaryColor)");
  }
}

function SwitchHud(data) {
  switch (data.hudstatus) {
    case true:
      $("body").fadeIn();
      break;
    case false:
      $("body").fadeOut();
      break;
    default:
      break;
  }

  switch (data.pausemenu) {
    case true:
      $(".main").fadeIn();
      break;
    case false:
      $(".main").fadeOut();
      break;
    default:
      break;
  }

  switch (data.watermark) {
    case true:
      if (JSON.parse(localStorage.getItem("watermark-box"))) {
        $(".watermark-box").fadeIn();
      }
      break;
    case false:
      $(".watermark-box").fadeOut();
      break;
    default:
      break;
  }

  switch (data.hud) {
    case true:
      if (JSON.parse(localStorage.getItem("carhud-box"))) {
        $(".streetlabael-box").css("bottom", "100px");
      }
      if (JSON.parse(localStorage.getItem("allhud-box"))) {
        $(".hud-box").fadeIn();
      }
      break;
    case false:
      if (JSON.parse(localStorage.getItem("carhud-box"))) {
        setTimeout(() => {
          $(".streetlabael-box").css("bottom", "25px");
        }, "300");
      }
      $(".hud-box").fadeOut();
      break;
    default:
      break;
  }

  switch (data.speedometer) {
    case true:
      if (JSON.parse(localStorage.getItem("carhud-box"))) {
        $(".carhud-box").fadeIn();
      }
      break;
    case false:
      $(".carhud-box").fadeOut();
      break;
    default:
      break;
  }

  switch (data.streetlabael) {
    case true:
      if (JSON.parse(localStorage.getItem("carhud-box"))) {
        $(".streetlabael-box").fadeIn();
      }
      break;
    case false:
      $(".streetlabael-box").fadeOut();
      break;
    default:
      break;
  }
}

function OpenUi() {
  hudsettings = true;
  $("#hudsettings").fadeIn();
}

function CloseUi() {
  hudsettings = false;
  $.post(`https://${GetParentResourceName()}/closemenu`, JSON.stringify({ }));
  $("#hudsettings").fadeOut();

}

function UpdateWatermark(data) {
  $("#watermark-id").html(data.playerId);
  $(".watermark-title").html(data.playerName);
}

function UpdateHud(data) {
  if (data.voice == 1) {
    data.voice = 20;
  } else if (data.voice == 2) {
    data.voice = 50;
  } else if (data.voice == 3) {
    data.voice = 100;
  }

  if (data.armor == 0) {
    $("#armor").fadeOut();
  } else {
    $("#armor").fadeIn();
    $(".hud__bg--armor").css("height", data.armor + "%");
  }

  $(".hud__bg--voice").css("height", data.voice + "%");

  $(".hud__bg--thirst").css("height", data.thirst + "%");
  $(".hud__bg--hunger").css("height", data.hunger + "%");
  if (data.health >= 100) {
    data.health = 90;
  }
  $(".hud__bg--health").css("height", data.health + "%");
}

function ChangeHud(data) {
  if (data == "romb") {
    localStorage.setItem("hud-style", "romb");

    $('.hud ul li').css('transform', 'rotate(45deg)');
    $('.hud ul li i').css('transform', 'rotate(-45deg)');

    $('.hud ul li').css('border-radius', '10%');

  } else if (data == "kwadrat") {
    localStorage.setItem("hud-style", "kwadrat");

    $('.hud ul li').css('transform', 'rotate(0deg)');
    $('.hud ul li i').css('transform', 'rotate(0deg)');

    $('.hud ul li').css('border-radius', '10%');

  } else if (data == "kolo") {
    localStorage.setItem("hud-style", "kolo");

    $('.hud ul li').css('transform', 'rotate(0deg)');
    $('.hud ul li i').css('transform', 'rotate(0deg)');

    $('.hud ul li').css('border-radius', '50%');
  }
}



$("#watermark-switch").change(function () {
  if ($(this).is(":checked")) {
    localStorage.setItem("watermark-box", true);
    SwitchHud({ watermark: true });
  } else {
    localStorage.setItem("watermark-box", false);
    SwitchHud({ watermark: false });
  }
});

$("#allhud-switch").change(function () {
  if ($(this).is(":checked")) {
    localStorage.setItem("allhud-box", true);
    SwitchHud({ hud: true });
  } else {
    localStorage.setItem("allhud-box", false);
    SwitchHud({ hud: false });
  }
});

$("#carhud-switch").change(function () {
  if ($(this).is(":checked")) {
    localStorage.setItem("carhud-box", true);
    SwitchHud({ streetlabael: true, speedometer: true });
  } else {
    localStorage.setItem("carhud-box", false);
    SwitchHud({ streetlabael: false, speedometer: false });
  }
});

$("#cam-switch").change(function () {
    $.post(`https://${GetParentResourceName()}/cam`, JSON.stringify({ 
    cam: $(this).is(":checked")
  }));
})

$("#hud-settings").change(function () {
  ChangeHud($(this).val())
});

document.onkeyup = function (data) {
  if (hudsettings && data.which == 27) {
    CloseUi();
  }
};


// SetupHud();
// OpenUi();