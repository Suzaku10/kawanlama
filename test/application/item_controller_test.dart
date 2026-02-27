import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/domain/interface/i_item_data_source.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';
import 'package:kawanlama/infrastructure/core/database_module/dao/favorite_dao.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/infrastructure/core/database_module/database_module.dart';
import 'package:drift/drift.dart' as drift;

class MockItemDataSource extends Mock implements IItemDataSource {}

class MockFavoritesDao extends Mock implements FavoritesDao {}

class MockAuthRepository extends Mock implements IAuth {}

class FakeFavorite extends Fake implements drift.Insertable<Favorite> {}

void main() {
  late ItemController itemController;
  late MockItemDataSource mockItemDataSource;
  late MockFavoritesDao mockFavoritesDao;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(FakeFavorite());
  });

  setUp(() {
    mockItemDataSource = MockItemDataSource();
    mockFavoritesDao = MockFavoritesDao();
    mockAuthRepository = MockAuthRepository();

    when(() => mockAuthRepository.userLoggedIn()).thenReturn('test_user');

    itemController = ItemController(
      mockItemDataSource,
      mockFavoritesDao,
      mockAuthRepository,
    );
  });

  group('ItemController', () {
    final tItemDTO = ItemDTO(
      id: '1',
      name: 'Item 1',
      description: 'Desc',
      audioUrl: 'url',
      number: 1,
      type: 'type',
      mean: 'mean',
      isFavorite: false,
      user: 'test_user',
    );

    test('fetchItem should fetch items and set them', () async {
      when(() => mockItemDataSource.getItems())
          .thenAnswer((_) async => [tItemDTO]);
      when(() => mockFavoritesDao.getAllFavorites(any()))
          .thenAnswer((_) async => []);

      await itemController.fetchItem();

      expect(itemController.items.length, 1);
      expect(itemController.items.first.name, 'Item 1');
      verify(() => mockItemDataSource.getItems()).called(1);
      verify(() => mockFavoritesDao.getAllFavorites('test_user')).called(1);
    });

    test('markAsFavorite should insert favorite and update items list',
        () async {
      when(() => mockFavoritesDao.getAllFavorites(any()))
          .thenAnswer((_) async => []);
      when(() => mockFavoritesDao.insertFavorite(any()))
          .thenAnswer((_) async => 1);

      itemController.items.value = [tItemDTO];

      await itemController.markAsFavorite(tItemDTO);

      verify(() => mockFavoritesDao.insertFavorite(any())).called(1);
      verify(() => mockFavoritesDao.getAllFavorites('test_user')).called(1);
      expect(itemController.items.first.isFavorite, true);
    });

    test('getFavorites should update favoritesItems', () async {
      final tFavorite = Favorite(
        id: '1',
        sourceId: '1',
        name: 'Item 1',
        description: 'Desc',
        audioUrl: 'url',
        number: 1,
        type: 'type',
        mean: 'mean',
        isFavorite: true,
        user: 'test_user',
        createdAt: DateTime.now(),
      );

      when(() => mockFavoritesDao.getAllFavorites(any()))
          .thenAnswer((_) async => [tFavorite]);

      await itemController.getFavorites();

      expect(itemController.favoritesItems.length, 1);
      expect(itemController.favoritesItems.first.name, 'Item 1');
      verify(() => mockFavoritesDao.getAllFavorites('test_user')).called(1);
    });

    test('deleteFavorite should remove favorite and update items list',
        () async {
      when(() => mockFavoritesDao.getAllFavorites(any()))
          .thenAnswer((_) async => []);
      when(() => mockFavoritesDao.deleteFavoriteById(any(), any()))
          .thenAnswer((_) async => 1);

      final faveItem = tItemDTO.copyWith(true);
      itemController.items.value = [faveItem];

      await itemController.deleteFavorite(faveItem);

      verify(() =>
              mockFavoritesDao.deleteFavoriteById(faveItem.id, 'test_user'))
          .called(1);
      verify(() => mockFavoritesDao.getAllFavorites('test_user')).called(1);
      expect(itemController.items.first.isFavorite, false);
    });
  });
}
