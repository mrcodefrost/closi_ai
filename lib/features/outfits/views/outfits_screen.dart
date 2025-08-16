import 'package:ai_closet_flutter/data/models/product_category.dart';
import 'package:ai_closet_flutter/features/common/nested_app_bar.dart';
import 'package:flutter/material.dart';

class OutfitsScreen extends StatelessWidget {
  const OutfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MOCK DATA
    List<ProductCategory> productCategories = [
      ProductCategory(id: "1", name: 'Summer ☀️', superCategory: 'clothing'),
      ProductCategory(id: "2", name: 'Beach 🏖️', superCategory: 'clothing'),
      ProductCategory(id: "3", name: 'Random 🎲', superCategory: 'clothing'),
      ProductCategory(id: "4", name: 'Winter ❄️', superCategory: 'clothing'),
    ];

    return Scaffold(
      backgroundColor: Color(0xfffbfaf6),
      appBar: NestedAppBar(title: NestedAppBarTitles.myOutfits),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Chip(
                      key: UniqueKey(),
                      backgroundColor: Color(0xfff5f5f5),
                      labelStyle: TextStyle(color: Color(0xff898172)),
                      elevation: 0,
                      surfaceTintColor: Colors.transparent,
                      label: Text(productCategories[index].name.toUpperCase()),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
