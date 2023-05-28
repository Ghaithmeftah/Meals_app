import 'package:flutter/material.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screnn.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './dummy_data.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactos': false,
    'vegan': false,
    'vegetarian': false
  };
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactos']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: const ColorScheme.light(
            primary: Colors.pinkAccent, onSecondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(25, 51, 51, 1)),
              bodySmall: const TextStyle(color: Color.fromRGBO(25, 51, 51, 1)),
              titleLarge: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                fontSize: 21.0,
              ),
            ),
      ),
      home: const CategoriesScreen(),
      initialRoute: '',
      routes: {
        '': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDatailScrenn.routeName: (ctx) =>
            MealDatailScrenn(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        //if(settings.name == '/meal-detail'){
        //return ...;

        //}else if (settings.name == '/something-else'){
        //return ...;
        //}
        //return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: ((settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesScreen())),
    );
  }
}
