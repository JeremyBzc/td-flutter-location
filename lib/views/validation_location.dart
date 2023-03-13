import 'package:flutter/material.dart';
import 'package:location/views/share/bottom_navigation_bar_widget.dart';

class ValidationLocation extends StatefulWidget {
  static const String routeName = "/validation-location";

  const ValidationLocation({Key? key}) : super(key: key);

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes locations",
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
      body: const Center(
        child: Text(
            "Confirmation OK"
        ),
      ),
    );
  }
}
