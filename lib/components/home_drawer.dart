import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget headerDrawer = Container(
      color: Colors.green[700],
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          width: 200,
          height: 200,
          child: CircleAvatar(
            backgroundImage: AssetImage("img/profile.png"),
          ),
        ),
      ]),
    );
    Widget listDrawer = Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
            size: 24.0,
          ),
          title: Text('Settings'),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
            size: 24.0,
          ),
          title: Text('Settings2'),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
            size: 24.0,
          ),
          title: Text('Settings3'),
        ),
      ],
    );
    return Drawer(
      child: Column(
        children: [
          headerDrawer,
          const Text("Name"),
          const Text("Good1001@gmail.com"),
          Expanded(child: listDrawer)
        ],
      ),
    );
  }
}
