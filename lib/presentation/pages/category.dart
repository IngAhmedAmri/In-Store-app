// category.dart
import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryWidget extends StatelessWidget {
  final List<Category> categories;
  final Function(int) onCategoryTap;

  CategoryWidget({
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kToolbarHeight + 67),
      color: Colors.transparent,
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onCategoryTap(index);
                },
                child: Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    categories[index].name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void showSubCategories(
    BuildContext context, int index, List<Category> categories) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Sub-categories for ${categories[index].name}'),
        content: Text('List of sub-categories for ${categories[index].name}'),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
