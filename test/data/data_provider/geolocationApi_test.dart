import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:macca_weather_app/data/data_provider/geolocationApi.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocator extends Mock implements GeolocatorPlatform {}

main() {
  late final MockGeolocator mockGeolocator ;
  late final GeolocationApi geolocationApi ;

  setUp((){
    mockGeolocator = MockGeolocator();
    geolocationApi = GeolocationApi(geolocator: mockGeolocator);
  }) ;

  Position _position = Position(longitude: 1, heading: 1, timestamp: DateTime.now(),
    latitude: 1, altitude: 1, speed: 1, accuracy: 1, speedAccuracy: 1,);

  test(
    'should perform a check location service enabled or not when geolocationApi is called',
        () async {
      //arrange
          when(()=>mockGeolocator.isLocationServiceEnabled())
              .thenAnswer((_) async => true);
           when(()=>mockGeolocator.checkPermission())
              .thenAnswer((_) async =>LocationPermission.always);
          when(()=>mockGeolocator.getCurrentPosition())
              .thenAnswer((_) async => _position);

          // act
      await geolocationApi.currentLocationGetter;
      // final result = await mockGeolocator.isLocationServiceEnabled();
          // assert
      verify(() => mockGeolocator.isLocationServiceEnabled());
      // expect(result, equals(true));
    },
  );

  test(
    'should throw LocationServiceDisabledException when location service disabled',
        () async {
      //arrange
      when(()=>mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => false);
      when(()=>mockGeolocator.checkPermission())
          .thenAnswer((_) async =>LocationPermission.denied);
      when(()=>mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => _position);
      // act
      /// For testing Exception, don't call method in act, but in expect () => ,
      /// so that the program wont throw before expect
      // assert
      expect(() async => await geolocationApi.currentLocationGetter, throwsA(isA<LocationServiceDisabledException>()));
    },
  );

  test(
    'should check Location permission when location service enabled',
        () async {
      //arrange
      when(()=>mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(()=>mockGeolocator.checkPermission())
          .thenAnswer((_) async =>LocationPermission.always);
      // when(()=>mockGeolocator.requestPermission())
      //     .thenAnswer((_) async =>LocationPermission.always);
      when(()=>mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => _position);
      // act
      await geolocationApi.currentLocationGetter;
      // assert
      verify(()=>mockGeolocator.checkPermission());
      // expect(() async => await geolocationApi.currentLocationGetter, throwsA(isA<LocationServiceDisabledException>()));
    },
  );

  test(
    'should request location permission if Location permission denied',
        () async {
      //arrange
      when(()=>mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(()=>mockGeolocator.checkPermission())
          .thenAnswer((_) async =>LocationPermission.denied);
      when(()=>mockGeolocator.requestPermission())
          .thenAnswer((_) async =>LocationPermission.always);
      when(()=>mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => _position);
      // act
      await geolocationApi.currentLocationGetter;
      // assert
      verify(()=>mockGeolocator.requestPermission());
      // expect(() async => await geolocationApi.currentLocationGetter, throwsA(isA<LocationServiceDisabledException>()));
    },
  );

  test(
    'should throw Exception if Location permission request denied',
        () async {
      //arrange
      when(()=>mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(()=>mockGeolocator.checkPermission())
          .thenAnswer((_) async =>LocationPermission.denied);
      when(()=>mockGeolocator.requestPermission())
          .thenAnswer((_) async =>LocationPermission.denied);
      when(()=>mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => _position);
      // act
            // assert
      // verify(()=>mockGeolocator.requestPermission());
      expect(() async => await geolocationApi.currentLocationGetter, throwsA(isA<PermissionDeniedException>()));
    },
  );

  test(
    'should call getCurrentPosition method & return Position object if Location permission granted',
        () async {
      //arrange
      when(()=>mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(()=>mockGeolocator.checkPermission())
          .thenAnswer((_) async =>LocationPermission.denied);
      when(()=>mockGeolocator.requestPermission())
          .thenAnswer((_) async =>LocationPermission.always);
      when(()=>mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => _position);
      // act
      final result = await geolocationApi.currentLocationGetter;
      // assert
      verify(()=>mockGeolocator.getCurrentPosition());
      expect( result, _position );
    },
  );

}