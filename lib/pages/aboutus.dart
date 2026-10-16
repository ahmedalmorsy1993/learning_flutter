import 'dart:async';
import 'dart:isolate';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:first_app/components/app_text_field.dart';
import 'package:first_app/components/custom_dropdown_list.dart';
import 'package:first_app/timer_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  Timer? _countdownTimer;
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _languageController = TextEditingController();
  final _namesController = TextEditingController();

  final _cities = ['Cairo', 'Alexandria', 'Giza', 'Dubai', 'London', 'Paris'];
  final _languages = ['Arabic', 'English', 'French', 'German', 'Spanish'];

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _nameController.dispose();
    _cityController.dispose();
    _languageController.dispose();
    _namesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final timerInfo = context.read<TimerInfo>();
      timerInfo.updateRemainingTime();
      if (timerInfo.remainingTime == 0) return;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timerInfo.updateRemainingTime();
        if (timerInfo.remainingTime == 0) timer.cancel();
      });
    });
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
        ElevatedButton(
          onPressed: () async {
            final receivePort = ReceivePort();
            await Isolate.spawn(complexTask, receivePort.sendPort);
            receivePort.listen((total) {
              debugPrint("result: $total");
            });
          },
          child: Text('run complex task'),
        ),
        Consumer<TimerInfo>(
          builder: (context, timerInfo, child) => Center(
            child: Text(
              timerInfo.remainingTime.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ],
    );
  }
}

void complexTask(SendPort sendPort) {
  int total = 0;
  for (var i = 0; i < 100000; i++) {
    total += i;
  }
  sendPort.send(total);
}
