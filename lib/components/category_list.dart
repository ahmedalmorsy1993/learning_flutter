import 'package:flutter/material.dart';

class CategoryItem {
  final String label;
  final IconData icon;

  const CategoryItem({required this.label, required this.icon});
}

/// Horizontal row of circular category buttons.
/// The parent owns the selection: pass [selectedIndex] and update it in [onSelected].
class CategoryList extends StatelessWidget {
  final List<CategoryItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color activeColor;
  final double size;

  const CategoryList({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.activeColor = Colors.deepOrangeAccent,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (_, i) => _CategoryButton(
          item: items[i],
          selected: i == selectedIndex,
          onTap: () => onSelected(i),
          activeColor: activeColor,
          size: size,
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.activeColor,
    required this.size,
  });

  final CategoryItem item;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          spacing: 6,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? activeColor : Colors.grey[200],
              ),
              child: Icon(
                item.icon,
                size: size * 0.45,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected ? activeColor : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
