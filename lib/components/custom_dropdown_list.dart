import 'package:flutter/material.dart';

class CustomDropdownList extends StatefulWidget {
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

  @override
  State<CustomDropdownList> createState() => _DropdownList();
}

class _DropdownList extends State<CustomDropdownList> {
  /// Shows [CustomDropdownList.items] in a bottom sheet and returns the tapped one.
  Future<void> _showBottomSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
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
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (_, index) {
                  final item = widget.items[index];
                  return ListTile(
                    title: Text(item),
                    trailing: item == widget.textEditingController.text
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () => Navigator.pop(sheetContext, item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    // null means the sheet was dismissed without picking anything.
    if (selected == null) return;
    widget.textEditingController.text = selected;
    widget.onSelected?.call(selected);
  }

  @override
  Widget build(BuildContext context) {
    // Caller's decoration wins; our defaults only fill what they left empty.
    final decoration = widget.inputDecoration ?? const InputDecoration();

    return TextFormField(
      controller: widget.textEditingController,
      readOnly: true,
      onTap: () {
        FocusScope.of(context).unfocus();
        widget.onInputFieldTab?.call();
        _showBottomSheet();
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
