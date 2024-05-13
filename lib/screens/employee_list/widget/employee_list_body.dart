import 'package:enketest/components/build_employee_list_item.dart';
import 'package:enketest/model/employee.dart';
import 'package:enketest/screens/add_employee/add_employee_screen.dart';
import 'package:enketest/screens/edit_employee/edit_employee_screen.dart';
import 'package:enketest/screens/view_employee/view_employee_screen.dart';
import 'package:enketest/utils/text_strings.dart';
import 'package:flutter/material.dart';

class EmployeeListBody extends StatefulWidget {
  const EmployeeListBody({super.key});

  @override
  State<EmployeeListBody> createState() => _EmployeeListBodyState();
}

class _EmployeeListBodyState extends State<EmployeeListBody> {
  void _deleteEmployee(String id) {
    EmployeeData.deleteEmployee(id);
    setState(() {});
  }

  void _toggleActiveStatus(String id, bool isActive) {
    EmployeeData.toggleActiveStatus(id, isActive);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tHomeTitle),
      ),
      body: EmployeeData.employees.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No employees found'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: EmployeeData.employees.length,
              itemBuilder: (BuildContext context, int index) {
                Employee employee = EmployeeData.employees[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BuildEmployeeListItem(
                    employee: employee,
                    onActiveStatusChanged: (isActive) {
                      _toggleActiveStatus(employee.id, isActive!);
                    },
                    onViewPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewEmployeeScreen(employee: employee),
                        ),
                      );
                    },
                    onEditPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployeeEditScreen(employee: employee),
                        ),
                      );
                    },
                    onDeletePressed: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                              'This action will permanently delete this data'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => {
                                _deleteEmployee(employee.id),
                                Navigator.pop(context, true)
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EmployeeRegistrationScreen()),
          );
        },
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ),
    );
  }
}
