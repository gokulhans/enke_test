import 'package:enketest/model/employee.dart';
import 'package:enketest/screens/view_employee/widget/view_employee_body.dart';
import 'package:flutter/material.dart';

class ViewEmployeeScreen extends StatefulWidget {
  final Employee employee;
  const ViewEmployeeScreen({super.key, required this.employee});

  @override
  State<ViewEmployeeScreen> createState() => _ViewEmployeeScreenState();
}

class _ViewEmployeeScreenState extends State<ViewEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewEmployeeBody(
      employee: widget.employee,
    );
  }
}
