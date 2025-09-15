import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelmakerapp/entities/travel.dart';

import 'get_api_key.dart';

class MapService {
  static List<Marker> generateMarkers(Travel travel) {
    final markers = <Marker>[];

    markers.add(
      Marker(
        markerId: const MarkerId("origin"),
        position: LatLng(travel.origin.latitude.toDouble(), travel.origin.longitude.toDouble()),
        infoWindow: InfoWindow(title: travel.origin.city),
      ),
    );

    for (var i = 0; i < travel.travelStopList.length; i++) {
      final stop = travel.travelStopList[i];
      markers.add(
        Marker(
          markerId: MarkerId("stop_$i"),
          position: LatLng(stop.destination.latitude.toDouble(), stop.destination.longitude.toDouble()),
          infoWindow: InfoWindow(title: stop.destination.city),
        ),
      );
    }

    markers.add(
      Marker(
        markerId: const MarkerId("finish"),
        position: LatLng(travel.finish.latitude.toDouble(), travel.finish.longitude.toDouble()),
        infoWindow: InfoWindow(title: travel.finish.city),
      ),
    );

    return markers;
  }

  static List<LatLng> generateRoute(Travel travel) {
    return [
      LatLng(travel.origin.latitude.toDouble(), travel.origin.longitude.toDouble()),
      ...travel.travelStopList.map(
            (stop) => LatLng(stop.destination.latitude.toDouble(), stop.destination.longitude.toDouble()),
      ),
      LatLng(travel.finish.latitude.toDouble(), travel.finish.longitude.toDouble()),
    ];
  }

  static String staticMapRouteURL(Travel travel) {
    /// Generates a Static Map URL for a Travel object
    /// Includes origin, stops, finish markers and a route polyline
    final apiKey = getAPIKey();

    // Collect all coordinates: origin -> stops -> finish
    final points = <String>[];
    points.add('${travel.origin.latitude.toDouble()},${travel.origin.longitude.toDouble()}');

    for (var stop in travel.travelStopList) {
      points.add('${stop.destination.latitude.toDouble()},${stop.destination.longitude.toDouble()}');
    }

    points.add('${travel.finish.latitude.toDouble()},${travel.finish.longitude.toDouble()}');

    // Create markers string for Static Map (simplified)
    final markers = [
      'markers=color:green|label:O|${travel.origin.latitude.toDouble()},${travel.origin.longitude.toDouble()}',
      ...travel.travelStopList.asMap().entries.map(
            (e) =>
        'markers=color:blue|label:S${e.key + 1}|${e.value.destination.latitude.toDouble()},${e.value.destination.longitude.toDouble()}',
      ),
      'markers=color:red|label:F|${travel.finish.latitude.toDouble()},${travel.finish.longitude.toDouble()}',
    ].join('&');

    // Create polyline string connecting all points
    final path = 'path=color:0x0000ff|weight:5|' + points.join('|');

    // Build final URL
    final url =
        'https://maps.googleapis.com/maps/api/staticmap?size=600x300&$markers&$path&key=$apiKey';

    return url;
  }

  static String staticMapURL(double latitude, double longitude) {
    final value = 'https://maps.googleapis.com/maps/api/staticmap'
        '?size=1800x300'
        '&zoom=12'
        '&center=${latitude}, ${longitude}'
        '&key= ${getAPIKey()}';

    return value;
  }
}
