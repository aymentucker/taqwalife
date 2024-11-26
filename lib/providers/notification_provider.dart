import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationProvider with ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => _notifications;

  NotificationProvider() {
    _loadNotifications();
  }

  // Load notifications from shared_preferences
  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getStringList('notifications') ?? [];
    _notifications = storedData.map((item) => json.decode(item)).cast<Map<String, dynamic>>().toList();
    notifyListeners();
  }

  // Save a notification with timestamp and notify listeners
  Future<void> addNotification(String notification, {String? imageUrl}) async {
    final newNotification = {
      'text': notification,
      'imageUrl': imageUrl,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _notifications.add(newNotification);
    await _saveToPreferences();
    notifyListeners();
  }

  // Save all notifications to shared_preferences
  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = _notifications.map((item) => json.encode(item)).toList();
    await prefs.setStringList('notifications', encodedData);
  }

  // Clear all notifications
  Future<void> clearNotifications() async {
    _notifications.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    notifyListeners();
  }
}
