import '../entities/feed.dart';
import '../repositories/feed_repository.dart';

class GetFeedUseCase {
  const GetFeedUseCase(this.repository);

  final FeedRepository repository;

  Future<Feed> call() => repository.fetchFeed();
}
