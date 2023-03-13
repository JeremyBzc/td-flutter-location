import '../models/location.dart';
import '../models/locations_data.dart';

class LocationService {

  var  _locations;

  LocationService() {
    _locations = LocationsData.buildList();
  }

  List<Location> getLocationsByUser(int iduser) {
    return getLocations().where((location) => location.iduser == iduser).toList();
  }

  List<Location> getLocations()  {
    return _locations;
  }
}