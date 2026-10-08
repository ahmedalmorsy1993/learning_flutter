import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:first_app/components/app_text_field.dart';
import 'package:first_app/components/custom_dropdown_list.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _languageController = TextEditingController();
  final _namesController = TextEditingController();

  final _cities = ['Cairo', 'Alexandria', 'Giza', 'Dubai', 'London', 'Paris'];
  final _languages = ['Arabic', 'English', 'French', 'German', 'Spanish'];

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  /// Opens a bottom sheet with [items] and writes the picked one into [controller].
  void _pick(
    String title,
    List<String> items,
    TextEditingController controller,
  ) {
    DropDownState<String>(
      dropDown: DropDown<String>(
        bottomSheetTitle: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        data: items
            .map((item) => SelectedListItem<String>(data: item))
            .toList(),
        onSelected: (selected) {
          if (selected.isNotEmpty) {
            setState(() => controller.text = selected.first.data);
          }
        },
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        CustomDropdownList(
          textEditingController: _namesController,
          title: 'Names',
          items: const ['Ahmed', 'Sara', 'Omar', 'Mona'],
          inputDecoration: const InputDecoration(hintText: 'choose name'),
        ),
        AppTextField(
          textEditingController: _nameController,
          title: 'Name',
          hint: 'Enter your name',
        ),
        AppTextField(
          textEditingController: _cityController,
          title: 'City',
          hint: 'Choose your city',
          isReadOnly: true,
          onTextFieldTap: () => _pick('Cities', _cities, _cityController),
        ),
        AppTextField(
          textEditingController: _languageController,
          title: 'Language',
          hint: 'Choose your language',
          isReadOnly: true,
          onTextFieldTap: () =>
              _pick('Languages', _languages, _languageController),
        ),
        ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                '${_nameController.text} - ${_cityController.text} - ${_languageController.text}',
              ),
            ),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
