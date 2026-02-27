import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kawanlama/application/auth_controller.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';

class MockAuthRepository extends Mock implements IAuth {}

void main() {
  late AuthController authController;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authController = AuthController(mockAuthRepository);
  });

  group('AuthController', () {
    test(
        'signInWithGoogle should call signInWithGoogle on IAuth and return its result',
        () async {
      when(() => mockAuthRepository.signInWithGoogle())
          .thenAnswer((_) async => true);

      final result = await authController.signInWithGoogle();

      expect(result, true);
      verify(() => mockAuthRepository.signInWithGoogle()).called(1);
    });

    test('signOut should call signOut on IAuth and return its result',
        () async {
      when(() => mockAuthRepository.signOut()).thenAnswer((_) async => true);

      final result = await authController.signOut();

      expect(result, true);
      verify(() => mockAuthRepository.signOut()).called(1);
    });
  });
}
