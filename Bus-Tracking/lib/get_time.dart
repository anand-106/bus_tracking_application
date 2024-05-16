import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

double hrtime = 0;
Future<String> getTime(
    String link, LatLng sourceLocation, LatLng destinationLocation) async {
  try {
    // Convert the URL string into a Uri object
    Uri url = Uri.parse(link);

    // Make the HTTP request and wait for the response
    http.Response response = await http.get(url);

    // Check if the response status code is successful (200)
    if (response.statusCode == 200) {
      // Extract the response body as a string
      Map<String, dynamic> data = jsonDecode(response.body);

      // Find indices of source and destination based on latitude and longitude
      int sourceIndex = -1;
      int destinationIndex = -1;

      for (int i = 0; i < data["sources"].length; i++) {
        if (data["sources"][i]["location"][0] == sourceLocation.longitude &&
            data["sources"][i]["location"][1] == sourceLocation.latitude) {
          sourceIndex = i;
          break;
        }
      }

      for (int i = 0; i < data["destinations"].length; i++) {
        if (data["destinations"][i]["location"][0] ==
                destinationLocation.longitude &&
            data["destinations"][i]["location"][1] ==
                destinationLocation.latitude) {
          destinationIndex = i;
          break;
        }
      }

      // If source or destination not found, return a default value
      // if (sourceIndex == -1 || destinationIndex == -1) {
      //   return 69; // Return default duration (10 minutes)
      // }

      // Retrieve duration from the matrix
      double durationInSeconds = data["durations"][0][1];
      double time = durationInSeconds / 60;
      // Convert duration from seconds to minutes
      if (time >= 60) {
        print(time);
        int hrTime = (time / 60).truncate();
        double roundMinTime = (time - time.truncate()) * 60;
        int minTime = (roundMinTime).truncate();
        return 'Bus arrives in $hrTime hrs $minTime mins';
      } else {
        int minTime = time.truncate();
        return 'Bus arrives in $minTime mins';
      }
    } else {
      // If the response status code is not successful, throw an exception
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (error) {
    // If an error occurs during the HTTP request, return a default value and log the error
    print('Error fetching data: $error');
    return 'umpi'; // Return default duration (10 minutes)
  }
}
