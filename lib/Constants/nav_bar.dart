import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tot/Api/dog_screen.dart';
import '../Location/geo_map.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({final Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _screens() {
    return [
      DogsPage(),
      LocationTrackingScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: GoogleFonts.beVietnamPro(),
        icon: const Icon(Icons.home_outlined),
        title: "Dogs",
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        textStyle: GoogleFonts.beVietnamPro(),
        icon: const Icon(Icons.add_location_alt_outlined),
        title: "Location",
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }


  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _navBarItems(),
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style1,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text("Home Screen"),
    );
  }
}

