import 'package:enketest/model/employee.dart';
import 'package:flutter/material.dart';

class ViewEmployeeBody extends StatelessWidget {
  final Employee employee;

  const ViewEmployeeBody({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${employee.title} ${employee.firstName} ${employee.lastName}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Email: ${employee.email}'),
            const SizedBox(height: 8.0),
            Text('Phone: ${employee.phone}'),
            const SizedBox(height: 8.0),
            Text('Gender: ${employee.gender}'),
            const SizedBox(height: 8.0),
            Text('Education: ${employee.education}'),
            const SizedBox(height: 8.0),
            Text('Specialization: ${employee.specialization}'),
            const SizedBox(height: 8.0),
            Text('Interests: ${employee.interests.join(', ')}'),
            const SizedBox(height: 8.0),
            Text(
                'Agreement Accepted: ${employee.agreementAccepted ? 'Yes' : 'No'}'),
            const SizedBox(height: 8.0),
            Text('isActive: ${employee.isActive ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
