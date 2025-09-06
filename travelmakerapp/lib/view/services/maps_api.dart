import 'get_api_key.dart';

String staticMapURL(num latitude, num longitude) {
  final value = 'https://maps.googleapis.com/maps/api/staticmap'
      '?size=1800x300'
      '&zoom=12'
      '&center=${latitude}, ${longitude}'
      '&key= ${getAPIKey()}';

  return value;
}
