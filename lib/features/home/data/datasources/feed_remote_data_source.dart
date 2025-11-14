import '../../../../core/network/api_client.dart';
import '../models/feed_model.dart';

abstract class FeedRemoteDataSource {
  Future<FeedModel> fetchFeed();
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  FeedRemoteDataSourceImpl(this.client);

  final ApiClient client;

  @override
  Future<FeedModel> fetchFeed() async {
    final response = await client.getJson('/v1/feed');
    return FeedModel.fromJson(response);
  }
}
