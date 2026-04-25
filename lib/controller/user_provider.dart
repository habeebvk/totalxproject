import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:totalxproject/model/user_model.dart';

enum UserFilter { all, below60, above60 }

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _usersCollection;

  UserFilter _currentFilter = UserFilter.all;
  String _searchQuery = "";
  bool _isLoading = false;
  
  List<UserModel> _users = [];

  UserProvider() {
    debugPrint("Initializing UserProvider...");
    _usersCollection = _firestore.collection('users');
    _listenToUsers();
  }

  void _listenToUsers() {
    debugPrint("Starting Firestore listener for 'users' collection...");
    _usersCollection.snapshots().listen((snapshot) {
      debugPrint("SNAPSHOT RECEIVED: ${snapshot.docs.length} documents");
      _users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        debugPrint("User data: $data");
        return UserModel.fromFirestore(data);
      }).toList();
      notifyListeners();
    }, onError: (error) {
      debugPrint("FIRESTORE ERROR in listener: $error");
    });
  }

  Future<void> refreshUsers() async {
    debugPrint("Manually refreshing users...");
    try {
      final snapshot = await _usersCollection.get();
      debugPrint("MANUAL FETCH SUCCESS: ${snapshot.docs.length} documents");
      _users = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint("MANUAL FETCH ERROR: $e");
    }
  }

  List<UserModel> get users {
    List<UserModel> filtered = List.from(_users);

    // Apply Search Filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((user) =>
        user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        user.phoneNumber.contains(_searchQuery)
      ).toList();
    }

    // Apply Age Filter
    if (_currentFilter == UserFilter.below60) {
      filtered = filtered.where((user) => user.age < 60).toList();
    } else if (_currentFilter == UserFilter.above60) {
      filtered = filtered.where((user) => user.age >= 60).toList();
    }

    return filtered;
  }

  bool get isLoading => _isLoading;
  UserFilter get currentFilter => _currentFilter;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(UserFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    try {
      debugPrint("TRYING TO ADD USER: ${user.name}");
      final data = user.toFirestore();
      final docRef = await _usersCollection.add(data);
      debugPrint("USER ADDED SUCCESSFULLY. Doc ID: ${docRef.id}");
    } catch (e) {
      debugPrint("ADD USER ERROR: $e");
    }
  }
}
