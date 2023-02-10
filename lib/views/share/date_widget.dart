import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime dateDebut;
  final DateTime dateFin;

  const DateWidget(this.dateDebut, this.dateFin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Colors.grey,
        ),
        SizedBox(width: 30),
        Text(DateFormat('dd MMM yyyy', 'fr').format(dateDebut),
            style: TextStyle(
              fontSize: 16,
            )
        ),
        CircleAvatar(
          backgroundColor: Colors.blue.shade900,
          child: Icon(Icons.arrow_right),
        ),
        SizedBox(width: 30),
        Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Colors.black,
        ),
        SizedBox(width: 20),
        Text(DateFormat('dd MMM yyyy', 'fr').format(dateFin),
            style: TextStyle(
              fontSize: 16,
            )
        ),
      ],
    );
  }
}