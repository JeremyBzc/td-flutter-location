import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/views/share/date_widget.dart';

import '../share/location_style.dart';
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
  String nbPersonnes = "1";
  List<String> listNbPersonnes = <String>["1", "2", "3", "4", "5", "6", "7", "8"];
  double prixTotal = 0.0;
  List<OptionPayanteCheck> optionPayanteChecks = [];
  bool isAlreadyLoaded = false;

  var format = NumberFormat("### €");

  @override
  Widget build(BuildContext context) {
    _loadOptionsPayantes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          const Divider(indent: 10),
          _buildDates(),
          const Divider(indent: 10),
          _buildNbPersonnes(),
          const Divider(indent: 10),
          _buildOptionsPayantes(context),
          const Divider(indent: 10),
          _TotalWidget(prixTotal),

          _buildRentButton(),
        ],
      ),
    );
  }

  _buildResume() {
    return Container(
      margin: const EdgeInsets.all(2),
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
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          dateTimeRangePicker();
        },
        child: DateWidget(dateDebut, dateFin),
      ),
    );
  }
  _buildNbPersonnes() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text('Nombre de personnes : '),
          DropdownButton<String>(
            value: nbPersonnes,
            underline: Container(
              height: 2,
              color: LocationStyle.backgroundColorPurple,
            ),
            icon: const Icon(Icons.people),
            onChanged: (String? value) {
              setState(() {
                nbPersonnes = value!;
              });
            },
            items: listNbPersonnes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      )
    );
  }
  _loadOptionsPayantes() {
    if (!isAlreadyLoaded) {
      for (var option in widget._habitation.optionpayantes) {
        optionPayanteChecks.add(OptionPayanteCheck(option.id, option.libelle, false, description: option.description, prix: option.prix));
      }
      prixTotal = widget._habitation.prixmois;
      isAlreadyLoaded = true;
    }
  }
  _buildOptionsPayantes(BuildContext context) {
    return Column(
      children: Iterable.generate(
        optionPayanteChecks.length,
            (i) => CheckboxListTile(
          title: Text("${widget._habitation.optionpayantes[i].libelle} (${widget._habitation.optionpayantes[i].prix} €)"),
          subtitle: Text(optionPayanteChecks[i].description),
          value: optionPayanteChecks[i].checked,
          selected: optionPayanteChecks[i].checked,
          onChanged: (bool? value) {
            setState(() {
              optionPayanteChecks[i].checked = value!;
              if (value) {
                prixTotal += optionPayanteChecks[i].prix;
              } else {
                prixTotal -= optionPayanteChecks[i].prix;
              }
            });
          },
        ),
      ).toList(),
    );
  }

  _TotalWidget(prixTotal) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: LocationStyle.backgroundColorPurple,
          width: 2, // épaisseur de la bordure
        ),
      ),
      // padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "TOTAL",
              style: TextStyle(
                color: LocationStyle.backgroundColorPurple,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            format.format(prixTotal),
            style: LocationTextStyle.boldTextStyle,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  _buildRentButton() {

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResaLocation(widget._habitation)));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Text(
                "Louer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
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
      });
    }
  }
}
