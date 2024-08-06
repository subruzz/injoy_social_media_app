import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/location/domain/repositories/location_repository.dart';

class GetLocationUseCase implements UseCase<UserLocation, NoParams> {
  final LocationRepository _locationRepository;

  GetLocationUseCase({required LocationRepository locationRepository})
      : _locationRepository = locationRepository;
  @override
  Future<Either<Failure, UserLocation>> call(params) async {
    return await _locationRepository.getAddressFromLatLng();
  }
}
