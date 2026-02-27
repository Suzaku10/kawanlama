import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:kawanlama/infrastructure/repository/item_repository.dart';

class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late ItemRepository itemRepository;
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    when(() => mockDio.options).thenReturn(BaseOptions());
    itemRepository = ItemRepository(mockDio);
  });

  group('ItemRepository', () {
    test('getItems should return list of ItemDTOs', () async {
      final mockResponse = Response<List<dynamic>>(
        requestOptions: RequestOptions(path: ''),
        data: [
          {
            'nama': 'Item 1',
            'keterangan': 'Desc',
            'audio': 'url',
            'nomor': '1',
            'type': 'type',
            'arti': 'mean',
          }
        ],
        statusCode: 200,
      );

      when(() => mockDio.fetch<List<dynamic>>(any()))
          .thenAnswer((_) async => mockResponse);

      final result = await itemRepository.getItems();

      expect(result.length, 1);
      expect(result.first.name, 'Item 1');
      verify(() => mockDio.fetch<List<dynamic>>(any())).called(1);
    });
  });
}
