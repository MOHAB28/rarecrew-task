import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/errors/http_exception.dart';
import '../../../core/services/cache_helper.dart';
import '../model/model.dart';

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
    String urlSegment, [
    String? name,
    String? phone,
  ]) async {
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
      if (name != null && phone != null) {
        await saveEmailData(
          email: email,
          name: name,
          phone: phone,
          token: _token!,
        );
      }
      _setLoader(false);
      CacheHelper.saveDataSharedPreference(key: 'token', value: _token);
    } catch (error) {
      _setLoader(false);
      rethrow;
    }
  }

  bool _isProfileLoading = false;
  bool get isProfileLoading => _isProfileLoading;
  AccountModel? model;

  void setProfileLoading(bool load) {
    _isProfileLoading = load;
    notifyListeners();
  }

  Future<void> getEmailData() async {
    try {
      setProfileLoading(true);
      String token = CacheHelper.getDataFromSharedPreference(key: 'token');
      Uri url = Uri.parse(
        'https://todo-app-48e93-default-rtdb.firebaseio.com/user.json?auth=$token',
      );
      final response = await http.get(url);

      final extractedData = json.decode(response.body);
      String userId = CacheHelper.getDataFromSharedPreference(key: 'userId');
      model = AccountModel.fromJson(extractedData[userId]);
      setProfileLoading(false);
    } catch (error) {
      setProfileLoading(false);
      rethrow;
    }
  }

  Future<void> saveEmailData({
    required String email,
    required String name,
    required String phone,
    required String token,
  }) async {
    Uri url = Uri.parse(
      'https://todo-app-48e93-default-rtdb.firebaseio.com/user.json?auth=$token',
    );
    try {
      AccountModel model = AccountModel(
        email: email,
        name: name,
        phone: phone,
      );
      final response = await http.post(
        url,
        body: json.encode(
          model.toJson(),
        ),
      );
      CacheHelper.saveDataSharedPreference(
        key: 'userId',
        value: json.decode(response.body)['name'],
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    return _authenticate(email, password, 'signUp', name, phone);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}

final authViewmodel =
    ChangeNotifierProvider.autoDispose<AuthViewmodel>((ref) => AuthViewmodel());
