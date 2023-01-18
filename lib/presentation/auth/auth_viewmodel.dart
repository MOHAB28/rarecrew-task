import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../core/errors/http_exception.dart';
import '../../core/services/cache_helper.dart';

class AuthViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool _isLogin = true;
  String? _token;


  bool get isLoading => _isLoading;
  bool get isLogin => _isLogin;

  void loginToggle() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void _setLoader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBWJMw0GYO5zxLQc9WHr_lLfNZhg39BSyo';
    try {
      _setLoader(true);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      debugPrint(responseData.toString());
      if (responseData['error'] != null) {
        _setLoader(false);
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _setLoader(false);
      CacheHelper.saveDataSharedPreference(key: 'isLoggedIn', value: true);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}

final authViewmodel =
    ChangeNotifierProvider<AuthViewmodel>((ref) => AuthViewmodel());
