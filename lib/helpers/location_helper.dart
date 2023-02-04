const GOOGLE_API_KEY = 'AIzaSyDqZy0b9HqRmZqIsZaXVv4d-Pel-y-DCsg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
