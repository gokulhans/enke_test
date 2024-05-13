import 'package:enketest/components/build_custom_text_field.dart';
import 'package:enketest/model/employee.dart';
import 'package:enketest/screens/employee_list/employee_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeRegistrationBody extends StatefulWidget {
  const EmployeeRegistrationBody({super.key});

  @override
  State<EmployeeRegistrationBody> createState() =>
      _EmployeeRegistrationBodyState();
}

class _EmployeeRegistrationBodyState extends State<EmployeeRegistrationBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();

  String _selectedTitle = 'Mr';
  String _gender = '';
  String _education = '10';
  bool _agreementChecked = false;
  final List<String> _selectedInterests = [];
  final List<String> _titles = ['Mr', 'Miss', 'Mrs', 'Dr'];
  final List<String> _educations = [
    '10',
    '12 (HSE)',
    'Diploma',
    'Degree',
    'Post Graduate',
    'Doctorate'
  ];
  final List<String> _interests = ['Travel', 'Reading', 'Drawing', 'Driving'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Registration'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedTitle,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTitle = newValue!;
                  });
                },
                items: _titles.map((title) {
                  return DropdownMenuItem(
                    value: title,
                    child: Text(title),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              BuildCustomTextFormField(
                controller: _firstNameController,
                labelText: 'First Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              BuildCustomTextFormField(
                controller: _lastNameController,
                labelText: 'Last Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              BuildCustomTextFormField(
                controller: _emailController,
                labelText: 'Email',
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              BuildCustomTextFormField(
                controller: _phoneController,
                labelText: 'Phone',
                validator: (value) {
                  if (value!.isEmpty || value.length < 8 || value.length > 12) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Gender: '),
                  Radio(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text('Education:',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _education,
                onChanged: (newValue) {
                  setState(() {
                    _education = newValue!;
                  });
                },
                items: _educations.map((education) {
                  return DropdownMenuItem(
                    value: education,
                    child: Text(education),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your education';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              BuildCustomTextFormField(
                controller: _specializationController,
                labelText: 'Specialization',
              ),
              const SizedBox(height: 16.0),
              const Text('Interested In',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                children: _interests.map((interest) {
                  return FilterChip(
                    label: Text(interest),
                    selected: _selectedInterests.contains(interest),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedInterests.add(interest);
                        } else {
                          _selectedInterests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: _agreementChecked,
                    onChanged: (value) {
                      setState(() {
                        _agreementChecked = value!;
                      });
                    },
                  ),
                  const Text('Accept Agreement'),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_agreementChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please accept the agreement')),
                      );
                    } else {
                      _submitForm();
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    String generatedId = EmployeeData.generateId();
    EmployeeData.employees.add(Employee(
      id: generatedId,
      title: _selectedTitle,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      gender: _gender,
      education: _education,
      specialization: _specializationController.text,
      interests: _selectedInterests,
      agreementAccepted: _agreementChecked,
      isActive: true,
    ));
    _formKey.currentState!.reset();
    Get.offAll(() => const EmployeeListScreen());
  }
}
