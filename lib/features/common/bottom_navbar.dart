import 'package:ai_closet_flutter/features/home/views/my_closet_screen.dart';
import 'package:ai_closet_flutter/features/outfits/views/outfits_screen.dart';
import 'package:ai_closet_flutter/features/profile/views/profile_screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../virtual_try_on/views/virtual_try_on_screen.dart';

// class BottomNavbar extends StatefulWidget {
//   const BottomNavbar({super.key});
//
//   @override
//   State<BottomNavbar> createState() => _BottomNavbarState();
// }
//
// class _BottomNavbarState extends State<BottomNavbar> {
//   int _currentIndex = 0;
//   final List<int> _navigationStack = [0];
//
//   // IMP : Flutter will create the widgets in list eagerly resulting in controller
//   // initialization without navigation when bottom navbar is created,
//   // to avoid use a conditional widget building ( switch case ) and getters
//
//   Widget _getScreen(int index) {
//     switch (index) {
//       case 0:
//         return MyClosetScreen();
//       case 1:
//         return OutfitsScreen();
//       case 2:
//         return VirtualTryOnScreen();
//       case 3:
//         return ProfileScreen();
//       default:
//         return Container();
//     }
//   }
//
//   final List<NavItem> _navItems = [
//     NavItem(Icons.home_outlined, 'Closets'),
//     NavItem(Icons.card_travel_outlined, 'Outfits'),
//     NavItem(Icons.auto_fix_high_outlined, 'Try - on'),
//     NavItem(Icons.person_outline, 'Profile'),
//   ];
//
//   List<IconData> get _icons => _navItems.map((item) => item.icon).toList();
//   List<String> get _labels => _navItems.map((item) => item.label).toList();
//
//   Future<bool> _onWillPop() async {
//     if (_navigationStack.length > 1) {
//       _navigationStack.removeLast();
//       setState(() {
//         _currentIndex = _navigationStack.last;
//       });
//       return false;
//     }
//     return true;
//   }
//
//   void _onItemTapped(int index) {
//     if (_currentIndex != index) {
//       setState(() {
//         _navigationStack.add(index);
//         _currentIndex = index;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: _getScreen(_currentIndex),
//         bottomNavigationBar: Container(
//           height: 75,
//           padding: EdgeInsets.symmetric(vertical: 8),
//           color: Colors.white,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 4,
//             itemBuilder: (context, index) {
//               bool isSelected = _currentIndex == index;
//               return Material(
//                 color: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(200),
//                 ),
//                 clipBehavior: Clip.hardEdge,
//                 child: InkWell(
//                   splashColor: Colors.yellowAccent,
//                   onTap: () {
//                     _onItemTapped(index);
//                   },
//                   child: SizedBox(
//                     width:
//                         MediaQuery.of(context).size.width /
//                         4, // Display 4 items at once
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 4,
//                             horizontal: 20,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.amber
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Icon(
//                             _icons[index],
//                             color: isSelected ? Colors.blue : Colors.black,
//                             size: 26,
//                           ),
//                         ),
//                         SizedBox(height: 1),
//                         Text(
//                           _labels[index],
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: isSelected ? Colors.grey : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class NavItem {
//   final IconData icon;
//   final String label;
//
//   NavItem(this.icon, this.label);
// }

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget? child = MyClosetScreen();

  void handleIndexChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          child = MyClosetScreen();
          break;
        case 1:
          child = OutfitsScreen();
          break;
        case 2:
          child = VirtualTryOnScreen();
          break;
        case 3:
          child = ProfileScreen();
          break;
      }
      child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.home),
          FluidNavBarIcon(icon: Icons.storefront_outlined),
          FluidNavBarIcon(icon: Icons.auto_fix_high),
          FluidNavBarIcon(icon: Icons.person_outline),
        ],
        onChange: handleIndexChange,
        style: FluidNavBarStyle(
          barBackgroundColor: Colors.amber,
          iconBackgroundColor: Colors.amber,
          iconSelectedForegroundColor: Colors.black,
          iconUnselectedForegroundColor: Colors.white70,
        ),
      ),
    );
  }
}
