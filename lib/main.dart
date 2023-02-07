import 'package:basic_flutter/routes/navigate.dart';
import 'package:basic_flutter/viewmodel/partner_view_model.dart';
import 'package:basic_flutter/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => PartnerViewModel()),
      ],
      child: MaterialApp(
        title: 'Basic Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Navigate.routes,
        initialRoute: "/PartnerProfile",
      ),
    );
  }
}
