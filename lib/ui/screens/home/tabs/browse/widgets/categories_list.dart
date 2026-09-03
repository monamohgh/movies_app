import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoriesList extends StatefulWidget {
  final List<String> categories;
  final Function(int) onCategorySelected;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return CategoryItem(
            title: widget.categories[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(index);
            },
          );
        },
      ),
    );
  }
}