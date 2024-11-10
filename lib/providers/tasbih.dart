import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart'; // Updated import

class TasbihProvider with ChangeNotifier {
  final List<String> phrases = ['سبحان الله', 'الحمدلله', 'الله اكبر'];
  String _selectedPhrase = 'سبحان الله';
  int _count = 0;
  int _targetCount = 33;
  int _currentPhraseIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Updated player

  String get selectedPhrase => _selectedPhrase;
  int get count => _count;
  int get targetCount => _targetCount;

  TasbihProvider() {
    _loadTargetCount();
    _selectedPhrase = phrases[_currentPhraseIndex];
  }

  void _loadTargetCount() async {
    final prefs = await SharedPreferences.getInstance();
    _targetCount = prefs.getInt('targetCount') ?? 33;
    notifyListeners();
  }

  void _saveTargetCount(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('targetCount', value);
  }

  void incrementCount() {
    _count++;
    if (_count >= _targetCount) {
      Vibration.vibrate();
          _moveToNextPhrase();
    }
    notifyListeners();
  }

  void resetCount() {
    _count = 0;
    notifyListeners();
  }

  void changePhrase(String newPhrase) {
    _selectedPhrase = newPhrase;
    notifyListeners();
  }

  void setTargetCount(int newTarget) {
    _targetCount = newTarget;
    _saveTargetCount(newTarget);
    notifyListeners();
  }

  void _moveToNextPhrase() {
    _count = 0;
    _currentPhraseIndex++;

    if (_currentPhraseIndex >= phrases.length) {
      _playCompletionSound();
      _currentPhraseIndex = 0; // Reset to the first phrase
    }

    _selectedPhrase = phrases[_currentPhraseIndex];
    notifyListeners();
  }

  void _playCompletionSound() async {
    try {
      await _audioPlayer.play(
        AssetSource('audios/completion_sound.mp3'),
      );
    } catch (e) {
      // Handle error if audio fails to play
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player when provider is disposed
    super.dispose();
  }
}
