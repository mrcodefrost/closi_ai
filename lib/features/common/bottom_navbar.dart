// import 'package:ai_closet_flutter/features/home/views/my_closet_screen.dart';
// import 'package:ai_closet_flutter/features/outfits/views/outfits_screen.dart';
// import 'package:ai_closet_flutter/features/profile/views/profile_screen.dart';
// import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
// import 'package:flutter/material.dart';
//
// import '../virtual_try_on/views/virtual_try_on_screen.dart';
//
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   Widget? child = MyClosetScreen();
//
//   void handleIndexChange(int index) {
//     setState(() {
//       switch (index) {
//         case 0:
//           child = MyClosetScreen();
//           break;
//         case 1:
//           child = OutfitsScreen();
//           break;
//         case 2:
//           child = VirtualTryOnScreen();
//           break;
//         case 3:
//           child = ProfileScreen();
//           break;
//       }
//       child = AnimatedSwitcher(
//         switchInCurve: Curves.easeOut,
//         switchOutCurve: Curves.easeIn,
//         duration: Duration(milliseconds: 300),
//         child: child,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: FluidNavBar(
//         icons: [
//           FluidNavBarIcon(icon: Icons.home),
//           FluidNavBarIcon(icon: Icons.storefront_outlined),
//           FluidNavBarIcon(icon: Icons.auto_fix_high),
//           FluidNavBarIcon(icon: Icons.person_outline),
//         ],
//         onChange: handleIndexChange,
//         style: FluidNavBarStyle(
//           barBackgroundColor: Colors.amber,
//           iconBackgroundColor: Colors.amber,
//           iconSelectedForegroundColor: Colors.black,
//           iconUnselectedForegroundColor: Colors.white70,
//         ),
//       ),
//     );
//   }
// }
