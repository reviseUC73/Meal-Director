import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category_model.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
  });

  final void Function(MealModel meal) onToggleFavorite;

  void _selectCategory(BuildContext context, CategoryModel category) {
    final filterMeal = dummyMealModels
        .where((mealModel) => mealModel.categories.contains(category.id))
        .toList();

    // Same meaing Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filterMeal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 col
        childAspectRatio: 3 / 2, // box ration
        crossAxisSpacing: 20, // spacing verti each grid
        mainAxisSpacing: 20, // spacing hori each grid
      ),
      children: [
        for (final catogory in availableCategories)
          CategoryGridItem(
            categoryModel: catogory,
            onSelectCategory: () {
              _selectCategory(context, catogory);
            },
          )
      ],
    );
  }
}
