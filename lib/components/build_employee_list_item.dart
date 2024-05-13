import 'package:enketest/model/employee.dart';
import 'package:enketest/utils/color_constants.dart';
import 'package:flutter/material.dart';

class BuildEmployeeListItem extends StatelessWidget {
  final Employee employee;
  final void Function(bool?)? onActiveStatusChanged;
  final void Function()? onViewPressed;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const BuildEmployeeListItem({
    super.key,
    required this.employee,
    this.onActiveStatusChanged,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${employee.title} ${employee.firstName} ${employee.lastName}',
        ),
        subtitle: Text(employee.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              value: true,
              groupValue: employee.isActive,
              onChanged: onActiveStatusChanged,
            ),
            const Text('Active'),
            Radio(
              value: false,
              groupValue: employee.isActive,
              onChanged: onActiveStatusChanged,
            ),
            const Text('Inactive'),
            IconButton(
              icon: const Icon(Icons.visibility),
              color: ColorConstants.greenColor,
              onPressed: onViewPressed,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              color: ColorConstants.blueColor,
              onPressed: onEditPressed,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: ColorConstants.redColor,
              onPressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}
