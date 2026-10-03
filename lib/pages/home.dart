import 'package:first_app/app_asset_image.dart';
import 'package:first_app/custom_card.dart';
import 'package:first_app/nav_extensions.dart';
import 'package:flutter/material.dart';

class Employee {
  String firstName;
  String lastName;
  int age;
  Employee({
    required this.firstName,
    required this.lastName,
    required this.age,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> drawerStateKey = GlobalKey();
  final List<Color> myColors = [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple,
  ];
  final List<Employee> employees = [
    Employee(firstName: 'ahmed', lastName: 'ismail', age: 33),
    Employee(firstName: 'hisham', lastName: 'ismail', age: 40),
    Employee(firstName: 'hisham', lastName: 'ismail', age: 40),
    Employee(firstName: 'hany', lastName: 'ismail', age: 52),
    Employee(firstName: 'hany', lastName: 'ismail', age: 52),
    Employee(firstName: 'hany', lastName: 'ismail', age: 52),
    Employee(firstName: 'hany', lastName: 'ismail', age: 52),
    Employee(firstName: 'hany', lastName: 'ismail', age: 52),
  ];
  final List colsData = [
    {"icon": Icons.precision_manufacturing, "type": "prep:", "time": '25 min'},
    {"icon": Icons.watch, "type": "cook:", "time": '1 hr'},
    {"icon": Icons.kitchen, "type": "feeds:", "time": '4-6'},
  ];
  Widget _styledContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.all(10),
      child: Material(color: Colors.transparent, child: child),
    );
  }

  final List<Map<String, dynamic>> links = [
    {'title': 'Home', 'icon': Icons.home, 'path': 'home'},
    {
      'title': 'AboutUs',
      'icon': Icons.online_prediction_rounded,
      'path': 'about',
    },
  ];

  List<String> images = ['ai_me.jpeg', 'ai_me.jpeg', 'ai_me.jpeg'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: drawerStateKey,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              tooltip: "Home",
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              tooltip: "About",
              semanticsLabel: 'test',
              icon: Icon(Icons.production_quantity_limits),
              label: 'About',
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text("my app"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.production_quantity_limits)),
              Tab(icon: Icon(Icons.abc)),
            ],
          ),
        ),
        drawer: Drawer(
          // backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: AppAssetImage(
                        name: 'ai_me.jpeg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('ahmed ismail'),
                        subtitle: Text('Full-stack engineer'),
                      ),
                    ),
                  ],
                ),
                Divider(height: 30),
                Column(
                  spacing: 10,
                  children: [
                    ...links.map(
                      (item) => ListTile(
                        leading: Icon(
                          item['icon'] as IconData,
                          color: Colors.white,
                        ),
                        title: Text(item['title'] as String),
                        tileColor: Colors.blue,
                        textColor: Colors.white,
                        onTap: () {
                          final path = item['path'] as String;
                          drawerStateKey.currentState?.closeDrawer();
                          // Home is already the root page; pushing it again stacks duplicates.
                          if (path == 'home') return;
                          context.push(path);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => drawerStateKey.currentState?.openDrawer(),
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Column(
                    spacing: 12,
                    children: [
                      _styledContainer(
                        child: Text(
                          'First Example for Styling',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _styledContainer(
                        child: Text(
                          "First Example for Styling  welcome in my first app in flutter this is for dummy text for design and hope it will be good",
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          strutStyle: StrutStyle(leading: .4),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _styledContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (_) => const Icon(Icons.star),
                                ),
                              ],
                            ),
                            Text(
                              '170 reviews',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _styledContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...colsData.map(
                              (item) => Column(
                                spacing: 4,
                                children: [
                                  Icon(item['icon'] as IconData),
                                  Text(
                                    item['type'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['time'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _styledContainer(child: PrimaryButton()),
                      _styledContainer(child: Switcher()),
                      _styledContainer(child: Radio()),
                      _styledContainer(child: MyCheckbox()),
                      _styledContainer(child: MyStack()),
                      _styledContainer(child: CustomTextField()),
                      CustomCard(
                        title: 'welcome',
                        description: 'this is a simple description',
                        imageName: 'ai_me.jpeg',
                      ),
                      CustomCard(
                        title: 'welcome',
                        description: 'this is a simple description',
                        imageName: 'ai_me.jpeg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PageView.builder(
              itemCount: images.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  AppAssetImage(name: images[index], fit: BoxFit.cover),
            ),
            PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) =>
                  AppAssetImage(name: images[index], fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class Switcher extends StatefulWidget {
  const Switcher({super.key});

  @override
  State<Switcher> createState() => _Switch();
}

class Radio extends StatefulWidget {
  const Radio({super.key});

  @override
  State<Radio> createState() => _Radio();
}

class MyCheckbox extends StatefulWidget {
  const MyCheckbox({super.key});

  @override
  State<MyCheckbox> createState() => _Checkbox();
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _TextField();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  int count = 0;
  bool isActive = false;
  Widget get starIcon {
    return isActive ? Icon(Icons.star) : Icon(Icons.star_border_outlined);
  }

  void toggleActive() {
    setState(() => isActive = !isActive);
  }

  @override
  Widget build(BuildContext context) => MaterialButton(
    color: Colors.blue,
    textColor: Colors.white,
    onPressed: toggleActive,
    child: starIcon,
  );
}

class _Switch extends State<Switcher> {
  bool switchVal = false;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.lightBlue,
    child: SwitchListTile(
      value: switchVal,
      title: Text('is Free'),
      dense: true,
      subtitle: Text('subTitle'),
      onChanged: (val) => setState(() {
        switchVal = val;
      }),
    ),
  );
}

class _Radio extends State<Radio> {
  List countries = [
    {"name": "Syria", "value": "syria"},
    {"name": "Egypt", "value": "egypt"},
    {"name": "Saudi Arabia", "value": "saudi"},
  ];
  String? country = 'syria';
  @override
  Widget build(BuildContext context) => Column(
    children: [
      RadioGroup<String>(
        groupValue: country,
        onChanged: (value) => setState(() => country = value),
        child: Column(
          children: [
            ...countries.map(
              (el) => RadioListTile<String>(
                value: el['value'],
                title: Text(el['name']),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _Checkbox extends State<MyCheckbox> {
  List countries = [
    {"name": "Syria", "value": "syria"},
    {"name": "Egypt", "value": "egypt"},
    {"name": "Saudi Arabia", "value": "saudi"},
  ];
  String? country = 'syria';
  bool checked = false;
  bool btnToggle = false;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      CheckboxMenuButton(
        value: btnToggle,
        child: Text('click'),
        onChanged: (value) => setState(() => btnToggle = !btnToggle),
      ),
      CheckboxListTile.adaptive(
        value: checked,
        title: Text(checked ? 'checked' : 'unchecked'),
        onChanged: (bool? value) => setState(() => checked = value as bool),
      ),
    ],
  );
}

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Positioned(
          child: Container(height: 300, width: 200, color: Colors.red),
        ),
        Positioned(
          bottom: 10,
          child: Container(height: 100, width: 100, color: Colors.yellow),
        ),
        Positioned(
          child: Container(height: 100, width: 100, color: Colors.green),
        ),
      ],
    );
  }
}

class _TextField extends State<CustomTextField> {
  GlobalKey<FormState> formState = GlobalKey();
  Map<String, String> formValues = {"username": "", "phone": ""};
  final TextEditingController _dateTimeController = TextEditingController();

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: super.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null || !super.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !super.mounted) return;

    _dateTimeController.text =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${time.format(context)}';
  }

  FormFieldValidator<String> _isRequired() => (value) {
    if (value == null || value.trim().isEmpty) {
      return 'this field is required';
    }
    return null;
  };

  FormFieldValidator<String> _minLength(int length) => (value) {
    if ((value ?? '').length < length) {
      return 'this field must be at least $length characters';
    }
    return null;
  };
  // hoc higher order function that return the validator function
  FormFieldValidator<String> _maxLength(int length) => (value) {
    if ((value ?? '').length > length) {
      return 'this field must be at most $length characters';
    }
    return null;
  };

  /// Runs validators in order and returns the first error.
  FormFieldValidator<String> _compose(
    List<FormFieldValidator<String>> validators,
  ) => (value) {
    for (final validate in validators) {
      final error = validate(value);
      if (error != null) return error;
    }
    return null;
  };

  @override
  void dispose() {
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      autovalidateMode: AutovalidateMode.onUserInteraction, // this will make all textFormField the same behave
      child: Column(
        spacing: 12,
        children: [
          Text(formValues['username'].toString()),
          TextFormField(
            onSaved: (newValue) =>
                setState(() => formValues['username'] = newValue!),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: _compose([_isRequired(), _minLength(3), _maxLength(20)]),
            decoration: InputDecoration(
              hint: Text('Pls Enter Your Name'),
              labelText: 'User Name',
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (formState.currentState?.validate() ?? false) {
                formState.currentState?.save();
              }
            },
            color: Colors.red,
            textColor: Colors.white,
            child: Text('valid', style: TextStyle(fontSize: 18)),
          ),

          TextField(
            controller: _dateTimeController,
            readOnly: true,
            onTap: _selectDateTime,
            decoration: const InputDecoration(
              labelText: 'Date and time',
              hintText: 'Select date and time',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
    );
  }
}
