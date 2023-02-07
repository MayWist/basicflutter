import 'package:basic_flutter/components/home_drawer.dart';
import 'package:basic_flutter/utility/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: const HomeDrawer(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            LOGO_SHOP,
            fit: BoxFit.cover,
            width: 300.0,
            height: 300.0,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/Shop"),
              child: const Text("Go Shop!")),
          OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, "/Partner"),
              child: const Text("Be Partner")),
        ]),
      ),
    );
  }
}
