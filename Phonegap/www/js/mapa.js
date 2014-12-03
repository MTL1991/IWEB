function showMap(current_latitude,current_longitude){
console.log("Mostrando mapa centrado en " + current_latitude + "    " + current_longitude );
    $("#mapita").attr("src",
        "https://maps.googleapis.com/maps/api/staticmap" +
        "?center=" + current_latitude + "," + current_longitude +
        "&zoom=14" + 
        "&size=288x388" + 
        "&markers=" + current_latitude + "," + current_longitude +
        "&sensor=false");
    $.mobile.changePage("#pag2");
}

