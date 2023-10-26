var canShow = true
var type = 1
function dokument(imie, nazwisko, nrtel, oby, nrd, data, stopien, type2){
    if (canShow == true) {
        canShow = false
        type = type2
        if (type == 1) {   
            document.getElementById('imie').innerHTML = imie;
            document.getElementById('nazwisko').innerHTML = nazwisko;
            document.getElementById('obywatelstwo').innerHTML = oby;
            document.getElementById('numerdowodu').innerHTML = nrd;
            document.getElementById('datawystawienia').innerHTML = data;
            document.getElementById('podpis').innerHTML = imie + " " + nazwisko;
            document.getElementById('dokument').style =" transform: scale(0.7) translateX(0%);"
            setTimeout(() => {
                document.getElementById('dokument').style =" transform: scale(0.7) translateX(-1000%);"
            }, 5000);  
            setTimeout(() => {
                canShow = true
            }, 5250);
        } else if (type == 2) {
            document.getElementById('imieW').innerHTML = imie;
            document.getElementById('nrTel').innerHTML = nrtel;
            document.getElementById('datawystawienia2').innerHTML = data;
            document.getElementById('dokument2').style =" transform: scale(0.7) translateX(0%);"
            setTimeout(() => {
                document.getElementById('dokument2').style =" transform: scale(0.7) translateX(-5000%);"
            }, 5000); 
            setTimeout(() => {
                canShow = true
            }, 5250);
        } else if (type == 3) {
            document.getElementById('imieO').innerHTML = imie;
            document.getElementById('nazwiskoO').innerHTML = nazwisko;
            document.getElementById('stopienO').innerHTML = stopien;
            document.getElementById('dokument3').style =" transform: scale(0.7) translateX(0%);"
            setTimeout(() => {
                document.getElementById('dokument3').style =" transform: scale(0.7) translateX(-5000%);"
            }, 5000); 
            setTimeout(() => {
                canShow = true
            }, 5250);
        }
    } else {
        setTimeout(() => {
            dokument(imie, nazwisko, nrtel, oby, nrd, data, stopien, type2)
        }, 5300);
    }
}

window.addEventListener("message", function (event) {
    switch (event.data.action) {
        case "showID":
            dokument(event.data.imie, event.data.nazwisko, null, event.data.obywatelstwo, event.data.numerdowodu, event.data.datawystawienia, null, 1);
            break;
        case "showWIZ":
            dokument(event.data.imie, null, event.data.telefon, null, event.data.numerdowodu, event.data.datawystawienia, null, 2);
            break;
        case "showODZ":
            dokument(event.data.imie, event.data.nazwisko, null, null, null, null, event.data.stopien, 3);
            break;
    }
})