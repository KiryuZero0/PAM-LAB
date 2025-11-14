import '../../domain/entities/feed.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl(this.remoteDataSource);

  final FeedRemoteDataSource remoteDataSource;

  @override
  Future<Feed> fetchFeed() {
    return remoteDataSource.fetchFeed();
  }
}
