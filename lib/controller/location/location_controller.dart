import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/location/state/location_state.dart';
import 'package:saxonmarket/models/location_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';

final locationProvider = StateNotifierProvider<LocationController, LocationState>(
  (ref) => LocationController(ref: ref),
);

class LocationController extends StateNotifier<LocationState> {
  final Ref? ref;
  LocationController({this.ref}) : super(LocationInitialState());

  List<LocationModel>? locationModel = [];

  Future fetchLocations() async {
    state = LocationLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.location),
      );
      if (responseBody != null) {
        locationModel = (responseBody as List<dynamic>).map((x) => LocationModel.fromJson(x)).toList();

        state = LocationSuccessState();
      } else {
        state = LocationErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = LocationErrorState();
    }
  }
}
