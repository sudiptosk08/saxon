abstract class ReviewState {
  const ReviewState();
}

class ReviewInitialState extends ReviewState {
  const ReviewInitialState();
}

class ReviewLoadingState extends ReviewState {
  const ReviewLoadingState();
}

class ReviewSuccessState extends ReviewState {
  const ReviewSuccessState();
}

class ReviewErrorState extends ReviewState {
  const ReviewErrorState();
}
