import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/views/share/date_widget.dart';

import '../share/location_text_style.dart';


class ResaLocation extends StatefulWidget {

  final Habitation _habitation;

  const ResaLocation(this._habitation, {Key? key}) : super(key: key);


  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  //int prixTotal = 0;
  List<OptionPayanteCheck> optionPayanteChecks = [];

  final TextEditingController startDateController = TextEditingController(),
      endDateController = TextEditingController();

  var format = NumberFormat("### €");

  // get prixTotal => null;


  @override
  Widget build(BuildContext context) {
    //_loadOptionPayantes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          //_buildNbPersonnes(),
          //_buildOptionsPayantes(context),
          //TotalWidget(prixTotal),
          //_buildRentButton(),
        ],
      ),
    );
  }
  _buildResume() {
    return Container(
      margin: EdgeInsets.all(2),
      child: Material(
        child: ListTile(
          leading: Icon(Icons.house_rounded),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._habitation.libelle,
                style: LocationTextStyle.boldTextStyle,
              ),
              Text(
                widget._habitation.adresse,
                style: LocationTextStyle.baseTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
  _buildDates() {
    return Container(
      margin: EdgeInsets.all(10),
      padding:  EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: const Color(0xFFFFFFFF)),
      ),
      child: GestureDetector (
        onTap:() {
          dateTimeRangePicker();
        },
        child: DateWidget(dateDebut, dateFin),
      ),
    );
  }
  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
        //DateFormat('dd MMM yyyy', 'fr').format(dateDebut)
      });
    }
  }


}


