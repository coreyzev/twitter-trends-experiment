// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}

$(document).ready(function () {
    var locationInput = document.querySelector('.location-input');
    autocomplete = new google.maps.places.Autocomplete(locationInput, {types: ['(cities)']});

    autocomplete.addListener('place_changed', function() {
        var address = autocomplete.getPlace().formatted_address;
    });
});