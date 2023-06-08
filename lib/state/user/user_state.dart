import '/model/user.dart';

class UserState {
  bool isLoading;
  List<User> users;
  List<User> searchResults;

  UserState({
    required this.isLoading,
    required this.users,
    required this.searchResults,
  });

  UserState.initialState()
      : this(
          isLoading: false,
          users: [],
          searchResults: [], 
        );

  UserState copyWith({
    bool? isLoading,
    List<User>? users,
    List<User>? searchResults,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
