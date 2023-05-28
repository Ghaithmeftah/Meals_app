import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  //final String categoryId ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals![index].id,
            title: displayMeals![index].title,
            imageUrl: displayMeals![index].imageUrl,
            duration: displayMeals![index].duration,
            complexity: displayMeals![index].complexity,
            affordability: displayMeals![index].affordability,
          );
        },
        itemCount: displayMeals!.length,
      )),
    );
  }
}
