import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/features/location/data/models/location_search_model.dart';

abstract interface class SearchLocationDataSource {
  Future<List<SuggestedLocation>> fetchSugestedLocation(String query);
}

// final response = await get(Uri.https('photon.komoot.io', '/api/', {"q":'ko'}));
class SearchLocationDataSourceImpl implements SearchLocationDataSource {
  @override
  Future<List<SuggestedLocation>> fetchSugestedLocation(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://photon.komoot.io/api/?q=$query&limit=5'),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final photonResponse = PhotonResponse.fromJson(json);
        log(photonResponse.features.toString());
        return photonResponse.features;
      } else {
        throw const MainException();
      }
    } catch (e) {
      log('searchlocation eror ${e.toString()}');
      throw const MainException();
    }
  }
}
