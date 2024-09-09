import 'package:flutter/material.dart';
import 'package:easyconference/models/conference.dart';
import 'package:easyconference/services/database_service.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:easyconference/pages/home_page.dart';

class ConferenceFormPage extends StatefulWidget {
  const ConferenceFormPage({Key? key, this.conference}) : super(key: key);
  final Conference? conference;

  @override
  State<ConferenceFormPage> createState() => _ConferenceFormPageState();
}

//retrieve all data in conference form
class _ConferenceFormPageState extends State<ConferenceFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();

  String areaString = '';
  String title = 'Register Conference';
  String specialId = '';

  @override
  void initState() {
    super.initState();
    if (widget.conference != null) {
      title = 'Update Conference';
      _nameController.text = widget.conference!.name;
      _emailController.text = widget.conference!.email;
      _phoneController.text = widget.conference!.phone;
      _roleController.text = widget.conference!.role;
      specialId = widget.conference!.areaId.toString();
    }
  }

  Future<void> _onSave() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String role = _roleController.text;
    int areaId = int.parse(areaString);
    Conference conference = Conference(
        name: name, email: email, phone: phone, role: role, areaId: areaId);

    print(conference);
    // await _databaseService.insertConferenceInfo(conference);

    widget.conference == null
        ? await _databaseService.insertConferenceInfo(
            Conference(
              name: name,
              email: email,
              phone: phone,
              role: role,
              areaId: areaId,
            ),
          )
        : await _databaseService.updateConferenceInfo(
            Conference(
              id: widget.conference!.id,
              name: name,
              email: email,
              phone: phone,
              role: role,
              areaId: areaId,
            ),
          );
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': '1',
      'label': 'Artificial Intelligence',
    },
    {
      'value': '2',
      'label': 'Data Mining',
    },
    {
      'value': '3',
      'label': 'Computer Security',
    },
    {
      'value': '4',
      'label': 'Internet of Things',
    },
    {
      'value': '5',
      'label': 'Software Engineering',
    },
  ];

  //input required from user after button '+' is tapped
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Full Name *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.aod),
                    labelText: 'Phone Number *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Role *',
                    hintText: 'e.g. participant, presenter, reviewer, judges',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  child: SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    initialValue: specialId,
                    icon: const Icon(Icons.engineering),
                    labelText: 'select specialization area',
                    items: _items,
                    onChanged: (val) {
                      areaString = val;
                      print(areaString);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _onSave();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ),
                        );
                        setState(() {});
                        return alert(
                          context,
                          title: const Text('Successful!'),
                          content: const Text('new conference has been registered'),
                          textOK: const Text('Okay'),
                        );
                      }
                    },
                    child: const Text(
                      'Save conference',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
