import 'package:flutter/material.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/repository/user_profile_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  UserViewModel({required this.userRepository});

  // Fetch users from Firebase or Hive
  void fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Ensure Hive is initialized before accessing it
    await userRepository.initHive();

    // Check if data exists in Hive
    if (await userRepository.hasLocalData()) {
      _users = userRepository.getUsersFromHive(); // Load from Hive
    } else {
      // Fetch data from Firebase and store it in Hive
      await userRepository.fetchDataAndStoreInHive();
      _users = userRepository.getUsersFromHive(); // Load after syncing
    }

    // Always sync Firebase data to Hive
    await userRepository.syncFirebaseDataWithHive();

    _isLoading = false;
    notifyListeners();
  }

  // Add a user to Firebase and Hive
  Future<void> addUser(UserModel user) async {
    try {
      await userRepository.addUser(user);
      fetchUsers(); // Refresh the list after adding
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a user in Firebase and Hive
  Future<void> updateUser(String userId, UserModel user) async {
    try {
      await userRepository.updateUser(userId, user);
      fetchUsers(); // Refresh the list after updating
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a user from Firebase and Hive
  Future<void> deleteUser(String userId) async {
    try {
      await userRepository.deleteUser(userId);
      fetchUsers(); // Refresh the list after deleting
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
