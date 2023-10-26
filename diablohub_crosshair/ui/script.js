function exit(){
    document.querySelector(".content").style.display = "none"
    fetch(`https://${GetParentResourceName()}/closePanel`)
}

window.addEventListener("input", (event)=>{
    let width = document.querySelector("#width").value + "px"
    let thickness = document.querySelector("#thickness").value + "px"
    let gap = document.querySelector("#gap").value + "px"
    let outline = document.querySelector("#outline").value + "px"
    let opacity = document.querySelector("#opacity").value / 10 

    document.documentElement.style.setProperty('--width', width);
    document.documentElement.style.setProperty('--thickness', thickness);
    document.documentElement.style.setProperty('--gap', gap);
    document.documentElement.style.setProperty('--outline', outline);
    document.documentElement.style.setProperty('--opacity', opacity);

    localStorage.setItem("width", width)
    localStorage.setItem("thickness", thickness)
    localStorage.setItem("gap", gap)
    localStorage.setItem("outline", outline)
    localStorage.setItem("opacity", opacity)
    
});

let dotActive = false
document.querySelector("#checkbox").addEventListener("change", function(){
    let checkbox = document.querySelector("#checkbox")
    if(checkbox.checked){
        dotActive = true
        document.querySelector(".crosshair").style.display = "none"
        document.querySelector(".crosshair_dot").style.display = "flex"

        document.querySelector(".crosshair_preview_window").style.display = "none"
        document.querySelector(".crosshair_dot_window").style.display = "flex"
        localStorage.setItem("dotActive", "active")
    }
    else{
        dotActive = false
        document.querySelector(".crosshair").style.display = "flex"
        document.querySelector(".crosshair_dot").style.display = "none"

        document.querySelector(".crosshair_preview_window").style.display = "flex"
        document.querySelector(".crosshair_dot_window").style.display = "none"
        localStorage.setItem("dotActive", "deactive")
    }
});

let defaultActive = false
document.querySelector("#defaultCross").addEventListener("change", function(){
    let checkboxCross = document.querySelector("#defaultCross")
    if(checkboxCross.checked){
        defaultActive = true
        localStorage.setItem("defaultActive", "active")
        fetch(`https://${GetParentResourceName()}/basicCrosshair_enable`)
    }
    else{
        defaultActive = false
        localStorage.setItem("defaultActive", "deactive")
        fetch(`https://${GetParentResourceName()}/basicCrosshair_disable`)
    }
});


window.addEventListener("message", (event)=>{
    let data = event.data;
    if(data.action == "crosshairPanel"){
        document.querySelector(".content").style.display = "block"
    }
    if(data.action == "crosshairEnable"){
        if(document.querySelector("#checkbox").checked){
            document.querySelector(".crosshair_dot").style.display = "flex"
        }
        else{
            document.querySelector(".crosshair").style.display = "flex"
        }
    }
    if(data.action == "crosshairDisable"){
        if(document.querySelector("#checkbox").checked){
            document.querySelector(".crosshair_dot").style.display = "none"
        }
        else{
            document.querySelector(".crosshair").style.display = "none"
        }
    }
});

if(localStorage.getItem("width") != null || localStorage.getItem("thickness") != null || localStorage.getItem("gap") != null || localStorage.getItem("outline") != null || localStorage.getItem("opacity") != null){
    document.querySelector("#width").value = localStorage.getItem("width").replace("px", "")
    document.querySelector("#thickness").value = localStorage.getItem("thickness").replace("px", "")
    document.querySelector("#gap").value = localStorage.getItem("gap").replace("px", "")
    document.querySelector("#outline").value = localStorage.getItem("outline").replace("px", "")
    document.querySelector("#opacity").value = localStorage.getItem("opacity")*10
}
else{
    document.querySelector("#width").value = 10
    document.querySelector("#thickness").value = 3
    document.querySelector("#gap").value = 20
    document.querySelector("#outline").value = 0
    document.querySelector("#opacity").value = 10
}

document.documentElement.style.setProperty('--width', localStorage.getItem("width"));
document.documentElement.style.setProperty('--thickness', localStorage.getItem("thickness"));
document.documentElement.style.setProperty('--gap', localStorage.getItem("gap"));
document.documentElement.style.setProperty('--outline', localStorage.getItem("outline"));
document.documentElement.style.setProperty('--opacity', localStorage.getItem("opacity"));


if(localStorage.getItem("dotActive", dotActive) == "active"){
    document.querySelector("#checkbox").checked = true
    document.querySelector(".crosshair").style.display = "none"
    document.querySelector(".crosshair_dot").style.display = "flex"

    document.querySelector(".crosshair_preview_window").style.display = "none"
    document.querySelector(".crosshair_dot_window").style.display = "flex"
}
else if(localStorage.getItem("dotActive", dotActive) == "deactive"){
    document.querySelector("#checkbox").checked = false
    document.querySelector(".crosshair").style.display = "flex"
    document.querySelector(".crosshair_dot").style.display = "none"

    document.querySelector(".crosshair_preview_window").style.display = "flex"
    document.querySelector(".crosshair_dot_window").style.display = "none"
}

if(localStorage.getItem("defaultActive", defaultActive) == "active"){
    document.querySelector("#defaultCross").checked = true
    fetch(`https://${GetParentResourceName()}/basicCrosshair_enable`)
}
else if(localStorage.getItem("defaultActive", defaultActive) == "deactive"){
    document.querySelector("#defaultCross").checked = false
    fetch(`https://${GetParentResourceName()}/basicCrosshair_disable`)
}