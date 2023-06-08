import 'package:flutter/material.dart';
import '/view_model/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

class ResultView extends ConsumerStatefulWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  ConsumerState<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends ConsumerState<ResultView> {
  final search = TextEditingController();
  String? selectedModules;

  //dialog box
  Future<void> confirmDeleteUser(User user) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${user.fname} ${user.lname}?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                ref.read(userViewModelProvider.notifier).deleteUser(user);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users = ref.watch(userViewModelProvider).users;
    // var data = ref.watch(userViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final User user = users[index];

          return Dismissible(
            key: Key(user.id.toString()),
            onDismissed: (_) {
              ref.read(userViewModelProvider.notifier).deleteUser(user);
            },
            child: ListTile(
              title: Text("${user.fname} ${user.lname}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    "Module Marks:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...user.moduleMarks.entries.map(
                    (entry) => Text(
                      "${entry.key}: ${entry.value}",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Total Marks: ${user.moduleMarks.values.reduce((value, element) => value + element)}",
                  ),
                  Text(
                    "Result: ${user.moduleMarks.length == 4 && !user.moduleMarks.values.any((mark) => mark < 40) ? "Pass" : "Fail"}",
                  ),
                  Text(
                    "Percentage: ${user.moduleMarks.length == 4 ? user.moduleMarks.values.reduce((value, element) => value + element) / user.moduleMarks.length : "NA"}",
                  ),
                  Text(
                    "Division: ${user.moduleMarks.length == 4 ? calculateDivision(user.moduleMarks) : "NA"}",
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  confirmDeleteUser(user);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String calculateDivision(Map<String, double> moduleMarks) {
    final double totalMarks =
        moduleMarks.values.reduce((value, element) => value + element);
    final double percentage = totalMarks / moduleMarks.length;

    if (percentage >= 80) {
      return "First";
    } else if (percentage >= 60) {
      return "Second";
    } else if (percentage >= 50) {
      return "Third";
    } else if (percentage >= 40) {
      return "Fourth";
    } else {
      return "Fail";
    }
  }
}
