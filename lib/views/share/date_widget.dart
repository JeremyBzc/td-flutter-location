import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../share/location_style.dart';
import '../../share/location_text_style.dart';

class DateWidget extends StatelessWidget {
  final DateTime dateDebut;
  final DateTime dateFin;

  const DateWidget(this.dateDebut, this.dateFin, {Key? key}) : super(key: key);

  Widget _buildDatePart(DateTime date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Colors.black
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(DateFormat('dd MMM yyyy', 'fr').format(date),
              style: LocationTextStyle.boldTextStyle,

          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDatePart(dateDebut),
        const SizedBox(width: 30),
        CircleAvatar(
          backgroundColor: LocationStyle.backgroundColorPurple,
          child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
          ),
        ),
        const SizedBox(width: 30),
        _buildDatePart(dateFin),
      ],
    );
  }
}