import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDatailScrenn extends StatelessWidget {
  static const routeName = 'meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDatailScrenn(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemCount: selectedMeal.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).colorScheme.onSecondary,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index])),
              ),
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                  title: Text(
                    selectedMeal.steps[index],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Divider(
                  color: Colors.pink,
                ),
              ],
            ),
            itemCount: selectedMeal.steps.length,
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
