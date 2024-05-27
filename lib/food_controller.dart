import 'package:get/get.dart';

class FoodController extends GetxController {
  var searchQuery = ''.obs;
  var displayedItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    displayedItems.addAll(foodItems);
  }

  void searchFood(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.value.isEmpty) {
      displayedItems.assignAll(foodItems);
    } else {
      displayedItems.assignAll(
        foodItems.where((item) {
          final itemName = (item['name'] as String?)?.toLowerCase() ?? '';
          final itemDescription = (item['description'] as String?)?.toLowerCase() ?? '';
          return itemName.contains(searchQuery.value) ||
              itemDescription.contains(searchQuery.value) ||
              searchQuery.value.contains('spicy');
        }).toList(),
      );
    }
  }
}

const foodItems = [
  {
    'name': 'Oni Sandwich',
    'description': 'Spicy chicken sandwich',
    'price': 6.72,
    'calories': 69,
    'imageUrl': 'assets/sandwich1.png',
  },
  {
    'name': 'Dan Noodles',
    'description': 'Spicy fruit mixed',
    'price': 8.86,
    'calories': 120,
    'imageUrl': 'assets/danNoodels1.png',
  },
  {
    'name': 'Chicken Dimsum',
    'description': 'Spicy chicken dimsum',
    'price': 6.99,
    'calories': 65,
    'imageUrl': 'assets/chickendimsum.png',
  },
  {
    'name': 'Egg Pasta',
    'description': 'Spicy chicken pasta',
    'price': 9.80,
    'calories': 78,
    'imageUrl': 'assets/eggpasta.png',
  },
  {
    'name': 'Pizza',
    'description': 'Spicy Pizza',
    'price': 9.80,
    'calories': 78,
    'imageUrl': 'assets/PIZZA.png',
  },
];
