import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_base_project_full/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_base_project_full/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_base_project_full/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_base_project_full/core/error/failure.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testUser = UserEntity(
    id: '1',
    email: testEmail,
    name: 'Test User',
  );

  test('should return UserEntity when login is successful', () async {
    // Arrange
    when(() => mockAuthRepository.login(testEmail, testPassword))
        .thenAnswer((_) async => const Right(testUser));

    // Act
    final result = await useCase(testEmail, testPassword);

    // Assert
    expect(result, const Right(testUser));
    verify(() => mockAuthRepository.login(testEmail, testPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when login fails', () async {
    // Arrange
    const failure = ServerFailure(message: 'Login failed');
    when(() => mockAuthRepository.login(testEmail, testPassword))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(testEmail, testPassword);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockAuthRepository.login(testEmail, testPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
