import 'package:latlong2/latlong.dart';

class LocData {
  String place;
  LatLng pos;
  String link;

  LocData(this.place, this.pos, this.link);
}

LocData kaloor = LocData('Kaloor', const LatLng(10.024164, 76.308341),
    "https://api.mapbox.com/directions/v5/mapbox/driving/76.407752%2C9.964075%3B76.308341%2C10.024164?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoiYW5hbmQxMDYiLCJhIjoiY2x1dXlwMGdiMGFnMjJxbW9jcWo2eXBjMCJ9.gBCavskm54ytN6xsD0CgXQ");

Map<String, dynamic> route = {
  'Kaloor': {
    'pos': LatLng(10.024164, 76.308341),
    'link':
        "https://api.mapbox.com/directions/v5/mapbox/driving/76.407752%2C9.964075%3B76.308341%2C10.024164?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoiYW5hbmQxMDYiLCJhIjoiY2x1dXlwMGdiMGFnMjJxbW9jcWo2eXBjMCJ9.gBCavskm54ytN6xsD0CgXQ"
  }
};
