import 'package:ai_closet_flutter/features/common/nested_app_bar.dart';
import 'package:flutter/material.dart';

class VirtualTryOnScreen extends StatelessWidget {
  const VirtualTryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfaf6),
      appBar: NestedAppBar(title: NestedAppBarTitles.virtualTryOn),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Select an outfit and upload your photo to get a virtual try-on!',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xff898172)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xfff3f0e9),
                borderRadius: BorderRadius.circular(40),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: Color(0xff898172),
                  ),
                  Text(
                    '  Try-on tips',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Color(0xff898172)),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Color(0xff898172)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.82,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Color(0xfff3f0e9),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Color(0xff898172),

                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
