function getGeolocalizacion(){

    // device APIs are available
    //
    
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
    

    // onSuccess Geolocation
    //
    function onSuccess(position) {
        current_latitude = position.coords.latitude;
        current_longitude= position.coords.longitude;
        
        var element = document.getElementById('geolocation');
        element.innerHTML = 'Latitude: '           + position.coords.latitude              + '<br />' +
                            'Longitude: '          + position.coords.longitude             + '<br />'  ;
    }

    // onError Callback receives a PositionError object
    //
    function onError(error) {
        alert('code: '    + error.code    + '\n' +
              'message: ' + error.message + '\n');
    }
}