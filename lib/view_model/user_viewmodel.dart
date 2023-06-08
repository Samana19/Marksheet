import 'package:depinflutter/model/user.dart';
import 'package:depinflutter/state/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var userViewModelProvider =
    StateNotifierProvider<UserViewModel, UserState>((ref) {
  return UserViewModel();
});

class UserViewModel extends StateNotifier<UserState> {
  UserViewModel()
      : super(
          UserState.initialState(),
        ) {
    getUsers();
  }

  // AddUsers
  void addUsers(User user) {
    state = state.copyWith(
      isLoading: true,
    );
    state = state.copyWith(
      users: [...state.users, user],
    );
    state = state.copyWith(
      isLoading: false,
    );
  }

  // Get Users
  void getUsers() {
    state = state.copyWith(
      isLoading: true,
    );
    state.users.add(
      User(
        id: 1,
        fname: "John",
        lname: "Doe",
        moduleMarks: {
          "Flutter": 90,
          "Web Dev": 80,
          "IoT": 70,
          "Design Thinking": 60,
        },
      ),
    );
    state.users.add(
      User(
        id: 2,
        fname: "Jane",
        lname: "Doe",
        moduleMarks: {
          "Flutter": 90,
          "Web Dev": 80,
          "IoT": 70,
          "Design Thinking": 60,
        },
      ),
    );
    state = state.copyWith(
      isLoading: false,
    );
  }

  // Delete Users
  void deleteUser(User user) {
    state = state.copyWith(
      isLoading: true,
    );
    state = state.copyWith(
      users: state.users.where((element) => element != user).toList(),
    );
    state = state.copyWith(
      isLoading: false,
    );
  }

  // User Exits
  bool userExists(int userId) {
    return state.users.any((element) => element.id == userId);
  }

  bool moduleExists(int id, String module) {
    return state.users
        .where((element) => element.id == id)
        .first
        .moduleMarks
        .containsKey(module);
  }

  // Update User Marks
  void updateUserMarks(int id, String module, double marks) {
    state = state.copyWith(
      isLoading: true,
    );
    state.users.where((element) => element.id == id).first.moduleMarks[module] =
        marks;
    state = state.copyWith(
      isLoading: false,
    );
  }

  // Add Module and Marks
  void addModuleAndMarks(int id, String module, double marks) {
    state = state.copyWith(
      isLoading: true,
    );
    state.users
        .where((element) => element.id == id)
        .first
        .moduleMarks
        .addAll({module: marks});
    state = state.copyWith(
      isLoading: false,
    );
  }

  // void searchUser(String fName) {
  //   state = state.copyWith(
  //     isLoading: true,
  //   );
  //   List<User> searchResults = state.users
  //       .where((element) =>
  //           element.fname.toLowerCase().contains(fName.toLowerCase()))
  //       .toList();
  //   state = state.copyWith(
  //     searchResults: searchResults,
  //     isLoading: false,
  //   );
  // }
}
