import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime dateDebut;
  final DateTime dateFin;

  const DateWidget(this.dateDebut, this.dateFin, {Key? key}) : super(key: key);

  Widget _buildDatePart(DateTime date) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Colors.grey
        ),
        SizedBox(width: 30),
        Text(DateFormat('dd MMM yyyy', 'fr').format(date),
            style: const TextStyle(
              fontSize: 16
            ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildDatePart(dateDebut),
        CircleAvatar(
          backgroundColor: Colors.blue.shade900,
          child: Icon(Icons.arrow_right),
        ),
        _buildDatePart(dateFin),
      ],
    );
  }
}