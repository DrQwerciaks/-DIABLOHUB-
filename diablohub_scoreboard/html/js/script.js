$(function () {
  window.addEventListener(
    "message",
    function (event) {
      switch (event.data.action) {
        case "updateJob":
          $(".main-job").html("Praca główna: " + event.data.praca);
          $(".dual-job").html("Organizacja: " + event.data.org);
          break;
        case "toggle":

          if (event.data.state == true) {
            $("body").fadeIn();
          } else {
            $("body").fadeOut();
          }
          break;

        case "close":
          $("body").fadeOut();
          break;
        case "updatePlayerJobs":
          var jobs = event.data.jobs;

          $("#player_count").html(jobs.players + "/64");

          $("#ems").html(jobs.ambulance);

          $("#police").html(jobs.police);

          $("#mechanik").html(jobs.mechanik);

          $("#fire").html(jobs.fire);

          break;
        case "updateCode":
          $("#city-code").html("Kod zagrożenia: " + event.data.code);
        default:
          break;
      }
    },
    false
  );
});
