import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kawanlama/infrastructure/repository/auth_repository.dart';
import 'package:kawanlama/domain/constant/app_strings.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late AuthRepository authRepository;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockSharedPreferences = MockSharedPreferences();
    authRepository = AuthRepository(mockGoogleSignIn, mockSharedPreferences);
  });

  group('AuthRepository', () {
    test('signInWithGoogle should sign in and save to preferences', () async {
      final mockAccount = MockGoogleSignInAccount();
      when(() => mockAccount.email).thenReturn('test@example.com');
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockAccount);
      when(() => mockSharedPreferences.setBool(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      final result = await authRepository.signInWithGoogle();

      expect(result, true);
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verify(() => mockSharedPreferences.setBool(AppStrings.loginKey, true))
          .called(1);
      verify(() => mockSharedPreferences.setString(
          AppStrings.accountKey, 'test@example.com')).called(1);
    });

    test('signOut should sign out and clear preferences', () async {
      when(() => mockGoogleSignIn.isSignedIn()).thenAnswer((_) async => true);
      when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => null);
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);

      final result = await authRepository.signOut();

      expect(result, true);
      verify(() => mockGoogleSignIn.isSignedIn()).called(1);
      verify(() => mockGoogleSignIn.signOut()).called(1);
      verify(() => mockSharedPreferences.remove(AppStrings.loginKey)).called(1);
      verify(() => mockSharedPreferences.remove(AppStrings.accountKey))
          .called(1);
    });

    test('isLoggedIn should return true if set', () {
      when(() => mockSharedPreferences.getBool(AppStrings.loginKey))
          .thenReturn(true);

      final result = authRepository.isLoggedIn();

      expect(result, true);
    });

    test('userLoggedIn should return user email', () {
      when(() => mockSharedPreferences.getString(AppStrings.accountKey))
          .thenReturn('test@example.com');

      final result = authRepository.userLoggedIn();

      expect(result, 'test@example.com');
    });
  });
}
