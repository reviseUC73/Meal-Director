import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';

// Pass data that modify (pass by value)
class FavoriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavoriteMealsNotifier() : super([]);

  /// state is copy by value then we can change something only state variable
  /// state = doSTH..
  bool togleMealFavoriteStatus(MealModel meal) {
    final mealIsFavorited = state.contains(meal);
    if (mealIsFavorited) {
      // ทำให้เหลือแค่อันที่ไม่ใช้ obj id นี้ (เอา meal in paramater ออกจาก list)
      state = state.where((mealModel) => mealModel.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealModel>>((ref) {
  return FavoriteMealsNotifier();
});

/// Note : StateNotifier<List<MealModel>> 
/// We can use it to get our list of favorites, 
/// but then also to trigger this method and change favorite
/// เราสามารถใช้เพื่อรับรายการโปรดของเรา แต่ยังเรียกใช้วิธีนี้และเปลี่ยนรายการโปรดของเรา

// StateNotifier returm new data that monifile or not modifine
// Pass by value (not pass by refer memory)
// variable state meaning is List<MealModel>