import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

   CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category=categories[index];
          /// المقارنة مباشرة بين اسم التصنيف والتصنيف المحدد
          final isSelected=category==selectedCategory;
          return CategoryItem(
            title: category,
            isSelected: isSelected,
            onTap: () {
           onCategorySelected(category);
            },
          );
        },
      ),
    );
  }
}