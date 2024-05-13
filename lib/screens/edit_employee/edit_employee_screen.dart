import 'package:enketest/model/employee.dart';
import 'package:enketest/screens/edit_employee/widget/edit_employee_body.dart';
import 'package:flutter/material.dart';

class EmployeeEditScreen extends StatefulWidget {
  final Employee employee;
  const EmployeeEditScreen({super.key, required this.employee});

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  @override
  Widget build(BuildContext context) {
    return EmployeeEditBody(
      employee: widget.employee,
    );
  }
}
