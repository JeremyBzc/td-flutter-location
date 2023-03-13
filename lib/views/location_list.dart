import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/views/share/bottom_navigation_bar_widget.dart';
import '../models/location.dart';
import '../services/habitation_service.dart';
import '../services/location_service.dart';
import '../share/location_style.dart';
import '../share/location_text_style.dart';

class LocationList extends StatefulWidget {
  static const String routeName = "/location-list";
  final LocationService locationService = LocationService();
  final HabitationService habitationService = HabitationService();
  late List<Location> _locations;

  LocationList({Key? key}) : super(key: key) {
    _locations = locationService.getLocations();
  }

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes locations",
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemBuilder: (context, index) =>
              _buildRow(widget._locations[index], context),
          itemCount: widget._locations.length,
          itemExtent: 170,
        ),
      ),
    );
  }

  _buildRow(Location location, BuildContext context) {
    return Container(
        child: Column(
          children: [
            _buildHabitat(location),
            _buildDates(location),
            _buildFacture(location),
            const Divider(height: 10, thickness: 1.5,)
          ],
        )
    );
  }

  _buildHabitat(Location location) {
    var format = NumberFormat("### €");
    var habitation = widget.habitationService.getHabitationById(location.id);
    return Row(
      children: [
        // Right
        Expanded(
          flex: 3,
          child: ListTile(
            title: Text(habitation.libelle),
            subtitle: Text(habitation.adresse),
          ),
        ),
        // Left
        Expanded(
          flex: 1,
          child: Text(
            format.format(500.00),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  _buildDates(Location location) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.date_range_outlined),
            Text(
              DateFormat.yMMMd("fr_FR").format(location.dateDebut),
              style: LocationTextStyle.boldTextStyle,
            ),
          ],
        ),
        const CircleAvatar(
          //backgroundColor: LocationStyle.backgroundColorPurple,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.date_range_outlined),
            Text(
              DateFormat.yMMMd("fr_FR").format(location.dateFin),
              style: LocationTextStyle.boldTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  _buildFacture(Location location) {
    return Row(
      children: [
        const SizedBox(
          height: 40,
        ),
        location.facture != null ? Text("Facture délivrée le ${DateFormat.yMMMd("fr_FR").format(location.facture!.date)}.") : const Text("Impossible de fournir la date.")
      ],
    );
  }
}