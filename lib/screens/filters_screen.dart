import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function _saveFilters;
  final Map<String, bool> currentfilters;
  FiltersScreen(this.currentfilters, this._saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vagetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  void initState() {
    _glutenFree = widget.currentfilters['gluten']!;
    _lactoseFree = widget.currentfilters['lactos']!;
    _vegan = widget.currentfilters['vegan']!;
    _vagetarian = widget.currentfilters['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactos': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vagetarian
                };
                widget._saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
            child: ListView(
          children: <Widget>[
            SwitchListTile(
                title: const Text(
                  'Gluten-free',
                  style: TextStyle(color: Colors.black),
                ),
                value: _glutenFree,
                subtitle: const Text('only include gluten-free meals'),
                onChanged: (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
            SwitchListTile(
                title: const Text(
                  'Lactos-free',
                  style: TextStyle(color: Colors.black),
                ),
                value: _lactoseFree,
                subtitle: const Text('only include Lactos-free meals'),
                onChanged: (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
            SwitchListTile(
                title: const Text(
                  'Vagetarian',
                  style: TextStyle(color: Colors.black),
                ),
                value: _vagetarian,
                subtitle: const Text('only include vagetarian meals'),
                onChanged: (newValue) {
                  setState(() {
                    _vagetarian = newValue;
                  });
                }),
            SwitchListTile(
                title: const Text(
                  'Vegan',
                  style: TextStyle(color: Colors.black),
                ),
                value: _vegan,
                subtitle: const Text('only include Vegan meals'),
                onChanged: (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
          ],
        ))
      ]),
    );
  }
}
