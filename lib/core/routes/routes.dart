import 'package:email_detection/core/routes/routes_name.dart';
import 'package:email_detection/ui/screens/cnic_detail_screen/cnic_detail_screen.dart';
import 'package:email_detection/ui/screens/cnic_screen.dart/cnic_screen.dart';
import 'package:email_detection/ui/screens/detail_screen/detail.dart';
import 'package:email_detection/ui/screens/email_screen/email_screen.dart';
import 'package:email_detection/ui/screens/options_screen/options_screen.dart';
import 'package:email_detection/ui/screens/passport_screen/passport_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.emailImageScreen:
        return MaterialPageRoute(builder: (_) => const EmailImageScreen());
      case RoutesName.emaildetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                DetailScreen(imagePath: settings.arguments as String));
      case RoutesName.optionsScreen:
        return MaterialPageRoute(builder: (_) => const OptionsScreen());
      case RoutesName.cnicScreen:
        return MaterialPageRoute(builder: (_) => const CnicScreen());
      case RoutesName.passportScreen:
        return MaterialPageRoute(builder: (_) => const PassportScreen());
      case RoutesName.cnicDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => CnicDetailScreen(
                  cnicData: settings.arguments as Map<String, dynamic>,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route defined.'),
            ),
          ),
        );
    }
  }
}
