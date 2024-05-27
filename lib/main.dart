import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'food_controller.dart';
//import 'food_detail_screen.dart';

void main() {
  runApp(SpiceFoodApp());
}

class SpiceFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchFoodScreen(),
    );
  }
}

class SearchFoodScreen extends StatelessWidget {
  final FoodController controller = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: Center(
          child: Text(
            'Search Food',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/user_avtar.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(),
              onChanged: (value) => controller.searchFood(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for spicy food...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.filter_list),
              ),
            ),
            SizedBox(height: 16),
            Obx(() => Text(
                  'Found ${controller.displayedItems.length} results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: controller.displayedItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.displayedItems[index];
                    return GestureDetector(
                      onTap: () {
                        // Get.to(() => FoodDetailScreen(
                        //   name: item['name'] as String,
                        //   description: item['description'] as String,
                        //   price: item['price'] as double,
                        //   calories: item['calories'] as int,
                        //   imageUrl: item['imageUrl'] as String,
                        // ));
                      },
                      child: FoodItem(
                        name: item['name'] as String,
                        description: item['description'] as String,
                        price: item['price'] as double,
                        calories: item['calories'] as int,
                        imageUrl: item['imageUrl'] as String,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int calories;
  final String imageUrl;

  const FoodItem({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.calories,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(imageUrl,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            SizedBox(height: 8),
            Center(
                child:
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 4),
            Center(
                child: Text(description,
                    style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.normal))),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.yellow, Colors.orange, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.local_fire_department, color: Colors.white),
                ),
                SizedBox(width: 4),
                Text('$calories Calories',
                    style: TextStyle(color: Colors.orange)),
              ],
            ),
            SizedBox(height: 4),
            Center(
                child: Text('\$$price',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
