import 'package:findmitter_frontend/data/services/database.dart';
import 'package:findmitter_frontend/domain/db_model.dart';
import 'package:findmitter_frontend/domain/models/post.dart';
import 'package:findmitter_frontend/domain/models/post_content.dart';
import 'package:findmitter_frontend/domain/models/post_model.dart';
import 'package:findmitter_frontend/domain/models/user.dart';

class DataService {
  Future cuUser(User user) async {
    await DB.instance.createUpdate(user);
  }

  Future rangeUpdateEntities<T extends DbModel>(Iterable<T> elems) async {
    await DB.instance.createUpdateRange(elems);
  }

  Future<List<PostModel>> getPosts() async {
    var res = <PostModel>[];
    var posts = await DB.instance.getAll<Post>();
    for (var post in posts) {
      var author = await DB.instance.get<User>(post.authorId);
      var contents =
          (await DB.instance.getAll<PostContent>(whereMap: {"postId": post.id}))
              .toList();
      if (author != null) {
        res.add(PostModel(
            id: post.id,
            author: author,
            contents: contents,
            description: post.description));
      }
    }

    return res;
  }
}
