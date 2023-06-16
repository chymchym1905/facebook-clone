import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SizedBox(
         // Set the desired percentage of the screen width
        child: ListView(
        children: [
          // Drawer content
        ],
      ),
      ),
    );
  }
}