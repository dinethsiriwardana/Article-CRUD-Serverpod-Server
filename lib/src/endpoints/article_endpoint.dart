import 'package:mypod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ArticleEndpoint extends Endpoint {
  // Fetch articals
  Future<List<Article>> getArticals(Session session, {String? keyword}) async {
    //return 'Hello';
    // return await Article.find(session);
    return await Article.find(session,
        where: (t) =>
            keyword != null ? t.title.like('%keyword%') : Constant(true));
  }

  // Add Article to database
  Future<bool> addArticle(Session session, Article article) async {
    await Article.insert(session, article);
    return true;
  }

  // Update Article to database
  Future<bool> updateArticle(Session session, Article article) async {
    var result = await Article.update(session, article);
    return result;
  }

  //Delete Article from database
  Future<bool> deleteArticle(Session session, int id) async {
    var result = await Article.delete(session, where: (t) => t.id.equals(id));
    return result == 1;
  }
}
