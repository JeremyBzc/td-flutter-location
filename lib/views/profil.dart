import 'package:flutter/material.dart';
import 'package:location/views/share/bottom_navigation_bar_widget.dart';

class Profil extends StatefulWidget {
  static const String routeName = "/profil";

  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profil",
          ),
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(3),
        body: const Text("Profil à faire (WIP)")
    );
  }
}
