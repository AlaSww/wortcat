import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  const Drawerr({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Icon(Icons.fire_hydrant_alt),
        ListTile(
          onTap: () {
            
          },
          title: Text(
            "dasboard"
          ),
        ),
        ListTile(
          onTap: () {
            
          },
          title: Text(
            "achievements"
          ),
        )
      ],
    );
  }
}