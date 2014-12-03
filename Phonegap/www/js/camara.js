 var pictureSource;   // picture source
    var destinationType; // sets the format of returned value

    // Wait for device API libraries to load
    //
    document.addEventListener("deviceready",onDeviceReady,false);

    // device APIs are available
    //
    function onDeviceReady() {
        pictureSource=navigator.camera.PictureSourceType;
        destinationType=navigator.camera.DestinationType;
    }

    // Called when a photo is successfully retrieved
    //
    function onPhotoDataSuccess(imageData) {
      // Uncomment to view the base64-encoded image data
      // console.log(imageData);
    
      // Get image handle
      //
     // var smallImage = document.getElementById('myImage');

      // Unhide image elements
      //
      //smallImage.style.display = 'block';

      // Show the captured photo
      // The in-line CSS rules are used to resize the image
      //
      //smallImage.src = "data:image/jpeg;base64," + imageData;
     navigator.geolocation.getCurrentPosition(onSuccess, onError);

      function onSuccess(position){

        console.log("Tengo la posicion");

        current_latitude=position.coords.latitude;
        current_longitude=position.coords.longitude;
        /*
        var foto = "<img style='width:60px;height:60px;'  src='" +imageURI+"' onclick='showMap(current_latitude,current_longitude);' />";
        
        console.log(foto);
        $("#imagenes").append($(foto));
        */

        var foto = $("img style='width:90px;height:90px;'  src='data:image/jpeg;base64, "+ imageData+"'");

        console.log("foto ="+foto);

        function ocm() {
          return "showMap(" + current_latitude + "," + current_longitude + ");";
        }

        foto.attr("onclick",ocm());

        console.log("antes de pintar");

        $("#imagenes").append(foto);
        console.log("despues de pintar");

      }
      function onError(msg){
        setTimeout(function(){alert(msg)},0);
      }


    }

    // Called when a photo is successfully retrieved
    //
    function onPhotoURISuccess(imageURI) {
      
       console.log("Tengo la foto");
      
      
    //  var largeImage = document.getElementById('largeImage');

      // Unhide image elements
      //
     // largeImage.style.display = 'block';

      // Show the captured photo
      // The in-line CSS rules are used to resize the image
      //
     // largeImage.src = imageURI;
    
      navigator.geolocation.getCurrentPosition(onSuccess, onError);

      function onSuccess(position){

        console.log("Tengo la posicion");

        current_latitude=position.coords.latitude;
        current_longitude=position.coords.longitude;
        /*
        var foto = "<img style='width:60px;height:60px;'  src='" +imageURI+"' onclick='showMap(current_latitude,current_longitude);' />";
        
        console.log(foto);
        $("#imagenes").append($(foto));
        */

        var foto = $("<img style='width:90px;height:90px;'  src='" +imageURI+"'/>");

        console.log("foto ="+foto);

        function ocm() {
          return "showMap(" + current_latitude + "," + current_longitude + ");";
        }

        foto.attr("onclick",ocm());

        
        $("#imagenes").append(foto);
        

      }
      function onError(msg){
        setTimeout(function(){alert(msg)},0);
      }

    }

    // A button will call this function
    //
    function capturePhoto() {
      // Take picture using device camera and retrieve image as base64-encoded string
      navigator.camera.getPicture(onPhotoDataSuccess, onFail, { quality: 50,
        destinationType: destinationType.DATA_URL });
    }

    // A button will call this function
    //
    function capturePhotoEdit() {
      // Take picture using device camera, allow edit, and retrieve image as base64-encoded string
      navigator.camera.getPicture(onPhotoDataSuccess, onFail, { quality: 20, allowEdit: true,
        destinationType: destinationType.DATA_URL });
    }

    // A button will call this function
    //
    function getPhoto(source) {
      // Retrieve image file location from specified source
      navigator.camera.getPicture(onPhotoURISuccess, onFail, { quality: 50,
        destinationType: destinationType.FILE_URI,
        sourceType: source });
    }

    // Called if something bad happens.
    //
    function onFail(message) {
      alert('Failed because: ' + message);
    }
