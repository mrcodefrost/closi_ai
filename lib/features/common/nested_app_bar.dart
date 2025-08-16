import 'package:flutter/material.dart';

enum NestedAppBarTitles { myCloset, myOutfits, virtualTryOn, profile }

class NestedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final NestedAppBarTitles title;

  const NestedAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    String heading = 'Empty Title';
    Widget firstActionIcon = const SizedBox.shrink();
    Widget refreshIcon = const SizedBox.shrink();
    double iconSize = 25;
    Color iconColor = Colors.black;
    bool backButton = false;

    switch (title) {
      case NestedAppBarTitles.profile:
        heading = 'My Profile';
        break;
      case NestedAppBarTitles.myCloset:
        heading = 'My Closet';
        firstActionIcon = IconButton(
          icon: Icon(
            Icons.filter_list_outlined,
            size: iconSize,
            color: iconColor,
          ),
          onPressed: () {},
        );
        break;
      case NestedAppBarTitles.myOutfits:
        heading = 'My Outfits';
        firstActionIcon = IconButton(
          icon: Icon(
            Icons.filter_list_outlined,
            size: iconSize,
            color: iconColor,
          ),
          onPressed: () {},
        );
        break;
      case NestedAppBarTitles.virtualTryOn:
        heading = 'Virtual Try-On';
        break;
    }

    return AppBar(
      title: Text(
        heading,
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
      ),
      backgroundColor: Color(0xfffbfaf6),
      automaticallyImplyLeading: false,
      titleSpacing: backButton
          ? 5
          : 20, // Todo : set padding 20 for main screens
      leading: backButton ? null : null,
      actions: [refreshIcon, firstActionIcon],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(color: Colors.black, thickness: 0.5),
      ),
    );
  }
}
