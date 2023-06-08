import '/view_model/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

class AddUserView extends ConsumerStatefulWidget {
  const AddUserView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends ConsumerState<AddUserView> {
  final idController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final marks = TextEditingController();
  final search = TextEditingController();

  List<String> modules = [
    "Flutter",
    "Web Dev",
    "IoT",
    "Design Thinking",
  ];
  String? selectedModules;

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(userViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: data.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16.0),
                  // ID
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Fname
                  TextField(
                    controller: fNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'FName',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Lname
                  TextField(
                    controller: lNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LName',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Dropdown
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Module';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Modules',
                      border: OutlineInputBorder(),
                    ),
                    items: modules
                        .map(
                          (city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedModules = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Marks
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Marks',
                    ),
                    controller: marks,
                  ),
                  const SizedBox(height: 16.0),
                  // Add User Button
                  ElevatedButton(
                    onPressed: () {
                      User user = User(
                        id: int.parse(idController.text.trim()),
                        fname: fNameController.text.trim(),
                        lname: lNameController.text.trim(),
                        moduleMarks: {
                          selectedModules!: double.parse(marks.text.trim()),
                        },
                      );

                      // Check if user ID exists in the database
                      if (ref
                          .read(userViewModelProvider.notifier)
                          .userExists(user.id)) {
                        // Check if module exists in the database for the user
                        if (ref
                            .read(userViewModelProvider.notifier)
                            .moduleExists(user.id, selectedModules!)) {
                          // Update marks for the module
                          ref
                              .read(userViewModelProvider.notifier)
                              .updateUserMarks(user.id, selectedModules!,
                                  user.moduleMarks[selectedModules!]!);
                        } else {
                          // Add module and marks for the user
                          ref
                              .read(userViewModelProvider.notifier)
                              .addModuleAndMarks(user.id, selectedModules!,
                                  user.moduleMarks[selectedModules!]!);
                        }
                      } else {
                        // Add user to the database
                        ref.read(userViewModelProvider.notifier).addUsers(user);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added'),
                        ),
                      );
                    },
                    child: const Text('Add User'),
                  ),
                  const SizedBox(height: 8.0),

                  // View Result Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/result');
                    },
                    child: const Text('View Result'),
                  ),



                  
                ],
              ),
            ),
    );
  }
}
