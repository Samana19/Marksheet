class User {
  final int id;
  final String fname;
  final String lname;
  final Map<String, double> moduleMarks;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.moduleMarks,
  });

  @override
  String toString() {
    return 'User(FName: $fname, LName: $lname, ModulesAndMarks: $moduleMarks)';
  }
}
