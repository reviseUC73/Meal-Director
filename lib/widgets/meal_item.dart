import 'package:flutter/material.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final MealModel meal;
  final void Function(MealModel myMealSelected) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toLowerCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toLowerCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      // Stack default ignores shape ไม่สามารถใช้กับ stack ได้
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // Enfore shape: remove any content that outside of shape boundary of card widget : stack ไม่ method shape
      // จะบังคับให้ตัด (clip) เนื้อหาของลูก (child) ให้อยู่ภายในรูปทรงที่กำหนด  ทำให้ shape ส่งผลถึงลูก (children ทุกตัว)
      clipBehavior: Clip.hardEdge,
      elevation: 2, // shadow
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              // load imaga from memory(cache) to MemoryImage() by passing kTransparentImage
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              // Meal.title
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      //อนุญาตให้ขึ้นบรรทัดใหม่ (wrap) โดยอัตโนมัติเมื่อตัวอักษรเกินความกว้างที่กำหนดไว้
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ......
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: "${meal.duration} min",
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
