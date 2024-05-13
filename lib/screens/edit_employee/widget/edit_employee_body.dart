import 'package:enketest/components/build_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enketest/model/employee.dart';
import 'package:enketest/screens/employee_list/employee_list_screen.dart';

class EmployeeEditBody extends StatefulWidget {
  final Employee employee;

  const EmployeeEditBody({super.key, required this.employee});

  @override
  State<EmployeeEditBody> createState() => _EmployeeEditBodyState();
}

class _EmployeeEditBodyState extends State<EmployeeEditBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();

  late String _selectedTitle;

  late String _gender;
  late String _education;
  late bool _agreementChecked;
  late List<String> _selectedInterests;

  @override
  void initState() {
    super.initState();
    _selectedTitle = widget.employee.title;
    _firstNameController.text = widget.employee.firstName;
    _lastNameController.text = widget.employee.lastName;
    _emailController.text = widget.employee.email;
    _phoneController.text = widget.employee.phone;
    _gender = widget.employee.gender;
    _education = widget.employee.education;
    _specializationController.text = widget.employee.specialization;
    _agreementChecked = widget.employee.agreementAccepted;
    _selectedInterests = List.from(widget.employee.interests);
  }

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
        title: const Text('Edit Employee'),
      ),
      body: SingleChildScrollView(
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a title';
                  }
                  return null;
                },
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
                decoration: const InputDecoration(
                  labelText: 'Education',
                ),
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
                      _formKey.currentState!.save();
                      _submitForm();
                    }
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    EmployeeData.updateEmployee(
        widget.employee.id,
        Employee(
          id: widget.employee.id,
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
          isActive: widget.employee.isActive,
        ));

    Get.offAll(() => const EmployeeListScreen());
  }
}
