import 'package:flutter/material.dart';

class CustomDropdownList extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<String> items;
  final String? title;
  final InputDecoration? inputDecoration;
  final VoidCallback? onInputFieldTab;
  final ValueChanged<String>? onSelected;

  const CustomDropdownList({
    super.key,
    required this.textEditingController,
    required this.items,
    this.title,
    this.inputDecoration,
    this.onInputFieldTab,
    this.onSelected,
  });

  Future<void> _showBottomSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _DropdownSheet(
        title: title,
        items: items,
        selectedItem: textEditingController.text,
      ),
    );

    if (selected == null) return;
    textEditingController.text = selected;
    onSelected?.call(selected);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = inputDecoration ?? const InputDecoration();

    return TextFormField(
      controller: textEditingController,
      readOnly: true,
      onTap: () {
        FocusScope.of(context).unfocus();
        onInputFieldTab?.call();
        _showBottomSheet(context);
      },
      decoration: decoration.copyWith(
        border:
            decoration.border ??
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
        filled: decoration.filled ?? true,
        fillColor: decoration.fillColor ?? Colors.grey[300],
        suffixIcon:
            decoration.suffixIcon ?? const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}

class _DropdownSheet extends StatefulWidget {
  const _DropdownSheet({
    required this.items,
    required this.selectedItem,
    this.title,
  });

  final List<String> items;
  final String selectedItem;
  final String? title;

  @override
  State<_DropdownSheet> createState() => _DropdownSheetState();
}

class _DropdownSheetState extends State<_DropdownSheet> {
  final _searchController = TextEditingController();
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.of(widget.items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      _filteredItems = query.isEmpty
          ? List.of(widget.items)
          : widget.items
                .where((item) => item.trim().toLowerCase().contains(query))
                .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterItems('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close),
                      ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (_, index) {
                final item = _filteredItems[index];
                return ListTile(
                  title: Text(item),
                  trailing: item == widget.selectedItem
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => Navigator.pop(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
