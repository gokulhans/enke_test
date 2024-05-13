class Employee {
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String education;
  final String specialization;
  final List<String> interests;
  final bool agreementAccepted;
  bool isActive;

  Employee({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.education,
    required this.specialization,
    required this.interests,
    required this.agreementAccepted,
    required this.isActive,
  });
}

class EmployeeData {
  static List<Employee> employees = [];
  static int _idCounter = 0;

  static String generateId() {
    return (_idCounter++).toString();
  }

  static void addEmployee(Employee employee) {
    employees.add(Employee(
      id: employee.id,
      title: employee.title,
      firstName: employee.firstName,
      lastName: employee.lastName,
      email: employee.email,
      phone: employee.phone,
      gender: employee.gender,
      education: employee.education,
      specialization: employee.specialization,
      agreementAccepted: employee.agreementAccepted,
      interests: employee.interests,
      isActive: employee.isActive,
    ));
  }

  static void deleteEmployee(String id) {
    employees.removeWhere((employee) => employee.id == id);
  }

  static void updateEmployee(String id, Employee updatedEmployee) {
    int index = employees.indexWhere((employee) => employee.id == id);
    if (index != -1) {
      employees[index] = updatedEmployee;
    }
  }

  static void toggleActiveStatus(String id, bool isActive) {
    final index = employees.indexWhere((employee) => employee.id == id);
    if (index != -1) {
      employees[index].isActive = isActive;
    }
  }
}
