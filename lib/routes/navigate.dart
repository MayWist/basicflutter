import 'package:basic_flutter/views/home.dart';
import 'package:basic_flutter/views/partner.dart';
import 'package:basic_flutter/views/partner_profile.dart';
import 'package:basic_flutter/views/product_detail.dart';
import 'package:basic_flutter/views/shop.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (BuildContext context) => Home(),
    '/ProductDetail': (BuildContext context) => ProductDetail(),
    '/Shop': (BuildContext context) => Shop(),
    '/Partner': (BuildContext context) => Partner(),
    '/PartnerProfile': (BuildContext context) => PartnerProfile(),
  };
}
