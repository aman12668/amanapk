import 'package:ENEB_HUB/app/screens/auth/screens/AuthManagement.dart';
import 'package:ENEB_HUB/app/screens/main/screens/HomeScreen.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      angle: 0,
      mainScreenScale: 0.1,
      borderRadius: 40,
      menuScreen: HomeScreen(),
      mainScreen: AuthPage(),
    );
  }
}
