import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_profile/model/user_model.dart';

class UserRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late Box<UserModel> _userBox;

  // Reference to the Firebase collection
  CollectionReference<UserModel> get userCollection =>
      _fireStore.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  // Initialize Hive box
  Future<void> initHive() async {
    if (!Hive.isBoxOpen('userBox')) {
      try {
        _userBox = await Hive.openBox<UserModel>('userBox');
        print('Hive box opened successfully');
      } catch (e) {
        print('Error opening Hive box: $e');
      }
    }
  }

  // Check if there are any users in Hive
  Future<bool> hasLocalData() async {
    if (!Hive.isBoxOpen('userBox')) {
      await initHive();
    }
    return _userBox.isNotEmpty;
  }

  // Fetch users from Firebase and sync with Hive (only if data changes)
  Stream<List<UserModel>> getUsersFromFirebase() {
    return userCollection.snapshots().map((snapshot) {
      List<UserModel> firebaseUsers =
          snapshot.docs.map((doc) => doc.data()).toList();

      firebaseUsers.forEach((user) async {
        var existsInHive =
            _userBox.values.any((existingUser) => existingUser.id == user.id);
        if (!existsInHive) {
          await _userBox.add(user); // Add user to Hive if not already present
        } else {
          var index =
              _userBox.values.toList().indexWhere((u) => u.id == user.id);
          if (index != -1) {
            await _userBox.putAt(
                index, user); // Update user in Hive if data changes
          }
        }
      });

      return firebaseUsers;
    });
  }

  // Fetch users from Hive (return cached data)
  List<UserModel> getUsersFromHive() {
    if (!Hive.isBoxOpen('userBox')) {
      initHive();
    }
    return _userBox.values.toList();
  }

  // Add a user to Firebase and Hive
  Future<void> addUser(UserModel user) async {
    await userCollection.add(user); // Add to Firebase
    await _userBox.add(user); // Add to Hive
  }

  // Update a user in Firebase and Hive
  Future<void> updateUser(UserModel user) async {
    await userCollection.doc(user.id).update(user.toJson()); // Update Firebase
    var userIndex = _userBox.values.toList().indexWhere((u) => u.id == user.id);
    if (userIndex != -1) {
      await _userBox.putAt(userIndex, user); // Update Hive
    }
  }

  // Delete a user from Firebase and Hive
  Future<void> deleteUser(String userId) async {
    await userCollection.doc(userId).delete(); // Delete from Firebase
    var userIndex = _userBox.values.toList().indexWhere((u) => u.id == userId);
    if (userIndex != -1) {
      await _userBox.deleteAt(userIndex); // Delete from Hive
    }
  }

  // Fetch data on the first app launch and store in Hive if empty
  Future<void> fetchDataAndStoreInHive() async {
    await initHive(); // Ensure Hive is initialized before usage

    if (!await hasLocalData()) {
      // Fetch users from Firebase and store them in Hive
      var firebaseUsers = await userCollection.get();
      for (var doc in firebaseUsers.docs) {
        var user = doc.data();
        // Check if the user already exists in Hive
        bool existsInHive =
            _userBox.values.any((existingUser) => existingUser.id == user.id);
        if (!existsInHive) {
          await _userBox.add(user);
        }
      }
      print(
          'Users fetched from Firebase and stored in Hive ${_userBox.values.toList()}');
    }
  }

  // Sync Firebase data with Hive
  Future<void> syncFirebaseDataWithHive() async {
    // Always check for updates from Firebase when the app is opened
    var firebaseUsers = await userCollection.get();
    firebaseUsers.docs.forEach((doc) async {
      var user = doc.data();
      var existsInHive =
          _userBox.values.any((existingUser) => existingUser.id == user.id);
      if (!existsInHive) {
        await _userBox.add(user);
      } else {
        var index = _userBox.values.toList().indexWhere((u) => u.id == user.id);
        if (index != -1) {
          await _userBox.putAt(index, user); // Update if changes detected
        }
      }
    });
  }
}
