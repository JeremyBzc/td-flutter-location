import 'package:location/models/facture.dart';
import 'package:location/models/location.dart';
import 'package:location/models/locations_data.dart';

class LocationService {

  final LocationApiClient locationApiClient;

  LocationService():
        locationApiClient = LocationApiData();

  Future<List<Location>> getLocation() async {
    List<Location> list = await locationApiClient.getLocations();
    return list;
  }

  Future<Location> getLocations(int id) {
    return locationApiClient.getLocation(id);
  }
}

abstract class LocationApiClient {
  Future<List<Location>> getLocations();
  Future<location> getLocation(int id);
}

class LocationApiData implements LocationApiClient {
  @override
  Future<List<Location>> getLocations() {
    return Future.delayed(
        const Duration(seconds: 1),
            () => LocationsData.buildList());
  }

  @override
  Future<Location> getLocation(int id) {
    Location location =
        LocationsData.buildList().where((element) => element.id == id).first;

    return Future.delayed(
      const Duration(seconds: 1),
        () => location);
  }
}