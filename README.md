# mypod_server

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres and Redis. It's easiest to do with Docker.

    docker compose up --build --detach

Then you can start the Serverpod server.

    dart bin/main.dart

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis.

    docker compose stop

## Creating a new endpoint

Go to lib -> src -> endpoints -> and create a new file with the name of your endpoint.

artical_endpoint.dart

```dart
import 'package:serverpod/serverpod.dart';

class ArticalEndpoint extends Endpoint {
  Future<String> getArticals(Session session) async {
    return "Hello Articals";
  }
}
```

## Creating a new protocol file

Go to lib -> src -> protocol -> and create a new file with the name of your protocol.

article_class.yaml

```yaml
class: Article
table: article
fields:
  title: String
  content: String
  publishedOn: DateTime
  isPrime: bool
```

## Generate all the codes

After Create new protocol file, you need to run `serverpod generate --watch` to generate the code.

    serverpod generate --watch

## Example of a new endpoint

### Return all the articles

```dart
class ArticalEndpoint extends Endpoint {
  Future<List<Article>> getArticals(Session session) async {
    //return 'Hello';
    return await Article.find(session);
  }
}
```

### Return select the articles by keyword

```dart
class ArticalEndpoint extends Endpoint {
  Future<List<Article>> getArticals(Session session, {String? keyword}) async {
    return await Article.find(session,
        where: (t) =>
            keyword != null ? t.title.like('%keyword%') : Constant(true));
  }
}
```

### Add a new article

```dart
  Future<bool> addArticle(Session session, Article article) async {
    await Article.insert(session, article);
    return true;
  }
```

### Update an article

```dart
  Future<bool> updateArticle(Session session, Article article) async {
    var result = await Article.update(session, article);
    return result;
  }
```

### Delete an article

```dart
  Future<bool> deleteArticle(Session session, int id) async {
    var result = await Article.delete(session, where: (t) => t.id.equals(id));
    return result == 1;
  }
```

## Setup Database

### Setup the Workspace

Goto your Database Manager Software (Datagrip) and create a new connection.
You can find the details in `defelopment.yaml` file. and the `passwords.yaml` file.

### Create tables

Goto generate folder and copy the `tables.dart` file. and paste it in your DBMS queary and Run.
