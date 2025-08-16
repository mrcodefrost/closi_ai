import 'package:ai_closet_flutter/features/common/nested_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NestedAppBar(title: NestedAppBarTitles.myCloset),
      body: Column(children: []),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
