import 'package:location/views/share/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:location/models/location.dart';
import 'package:location/services/location_service.dart';
import 'package:location/services/habitation_service.dart';
import 'package:intl/intl.dart';

import '../services/habitation_service.dart';

class LocationList extends StatefulWidget {
  final HabitationService service = HabitationService();
  late List<Location> _locations;

  LocationList( {Key? key}) : super(key: key) {
    //_locations = service.getLocations();
  }

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des locations"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget._locations.length,
          itemBuilder: (context, index) =>
              _buildRow(widget._locations[index]),
          itemExtent: 285,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
  _buildInfo(Location location) {

  }

  _buildRow(Location location) {
    String formattedDateDebut = DateFormat.yMMMEd().format(location.dateDebut);
    String formattedDateFin = DateFormat.yMMMEd().format(location.dateFin);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(formattedDateDebut),
                  subtitle: Text(formattedDateFin),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}