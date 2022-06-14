abstract class LocationState {
  const LocationState();
}

class LocationInitialState extends LocationState {
  const LocationInitialState();
}

class LocationLoadingState extends LocationState {
  const LocationLoadingState();
}

class LocationSuccessState extends LocationState {
  const LocationSuccessState();
}

class LocationErrorState extends LocationState {
  const LocationErrorState();
}
