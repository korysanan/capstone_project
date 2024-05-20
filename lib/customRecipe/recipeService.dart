import '../db/article.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../db/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../globals.dart' as globals;
import '../db/recipePost.dart';

class RecipeSerrvices {
  static const String url = 'http://api.kfoodbox.click';

  static List<Article> toArticleList(List<dynamic> json) {
    List<Article> articles = [];
    for (var element in json) {
      articles.add(Article(
        id: element["id"],
        title: element['title'],
        content: element['content'],
        likeCount: element['likeCount'],
        commentCount: element['commentCount'],
        createdAt: element['createdAt'],
        nickname: element['nickname'],
      ));
    }
    return articles;
  }

  static Future<List<Article>> getArticleList(
      page, limit, type, sort, query) async {
    try {
      String requestUrl = '';
      if (query == null) {
        requestUrl =
            "$url/custom-recipe-articles?page=$page&limit=$limit&type=$type&sort=$sort";
      } else {
        requestUrl =
            "$url/custom-recipe-articles?page=$page&limit=$limit&type=$type&sort=$sort&query=$query";
      }
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<Article> articles = toArticleList(jsonData['articles']);
        print("Get posts successfully.");
        return articles;
      } else {
        print("Failed to get post. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 게시물 정보 불러오기
  static Future<RecipePost> getPostInfo(postId) async {
    RecipePost temp = RecipePost(
      id: -1,
      userId: -1,
      isMine: false,
      isBookmarked: false,
      like: false,
      title: '',
      content: '',
      sequences: [],
      ingredients: [],
      imageUrls: [],
      createdAt: '',
      updatedAt: '',
      nickname: '',
      likeCount: -1,
      commentCount: -1,
    );
    try {
      http.Response response;
      if (globals.sessionId != null) {
        response = await http
            .get(Uri.parse('$url/custom-recipe-articles/$postId'), headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
          'Cookie': globals.sessionId!,
        });
      } else {
        response =
            await http.get(Uri.parse('$url/custom-recipe-articles/$postId'));
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        RecipePost postInfo = RecipePost.fromJson(jsonData);
        return postInfo;
      } else {
        print("Failed to add post. Status code: ${response.statusCode}");
        return temp;
      }
    } catch (e) {
      print("Error adding post: $e");
      return temp;
    }
  }

  static List<Comment> toCommentList(List<dynamic> json) {
    List<Comment> comments = [];
    for (var element in json) {
      comments.add(Comment(
        id: element["id"],
        userId: element['userId'],
        isMine: element['isMine'],
        nickname: element['nickname'],
        createdAt: element['createdAt'],
        updatedAt: element['updatedAt'],
        content: element['content'],
      ));
    }
    return comments;
  }

  // 게시물 댓글 불러오기
  static Future<List<Comment>> getComments(postId) async {
    try {
      final response = await http
          .get(Uri.parse('$url/custom-recipe-articles/$postId/comments'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<Comment> comments = toCommentList(jsonData['comments']);
        return comments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // 레시피 게시물 등록
  static Future<void> addRecipePost(
      String title,
      String content,
      List<XFile> images,
      List<Map<String, dynamic>> ingredients,
      List<Map<String, dynamic>> sequences) async {
    List<String> imageUrls = [];
    if (images.isNotEmpty) {
      imageUrls =
          List<String>.from(await postImages(images, 'CUSTOM_RECIPE_ARTICLE'));
    }
    List<Map<String, dynamic>> newSequences = [];
    for (var sequence in sequences) {
      if (sequence['imageUrl'] != null) {
        String imageUrl =
            await postImage(sequence['imageUrl'], 'CUSTOM_RECIPE_ARTICLE');
        newSequences.add({
          'sequenceNumber': sequence['sequenceNumber'],
          'content': sequence['content'],
          'imageUrl': imageUrl,
        });
      } else {
        newSequences.add({
          'sequenceNumber': sequence['sequenceNumber'],
          'content': sequence['content'],
        });
      }
    }
    try {
      Map<String, dynamic> results = {
        'title': title,
        'content': content,
        'sequences': newSequences,
        'ingredients': ingredients,
        'imageUrls': imageUrls
      };
      final encodedResults = jsonEncode(results);
      var response = await http.post(Uri.parse('$url/custom-recipe-article'),
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json',
            'Cookie': globals.sessionId!,
          },
          body: encodedResults);
      if (response.statusCode == 200) {
        print("Post added successfully.");
      } else {
        print("Failed to add post. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  static Future<String> postImage(XFile image, String type) async {
    try {
      final MultipartFile file = MultipartFile.fromFileSync(image.path,
          contentType: MediaType("image", "jpg"));
      FormData formData = FormData.fromMap({"images": file, 'type': type});

      Dio dio = Dio();

      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      dio.options.headers = {
        'Accept': '*/*',
        'Cookie': globals.sessionId!,
      };

      final response = await dio.post('$url/images', data: formData);
      List<dynamic> imageUrls = response.data['imageUrls'];
      return 'http://${imageUrls[0]}';
    } catch (e) {
      print(e);
    }
    return '';
  }

  // 게시물 이미지 업로드
  static Future<List<dynamic>> postImages(
      List<XFile> images, String type) async {
    if (images.isEmpty) {
      print("No Image");
      return [];
    }
    try {
      final List<MultipartFile> files = images
          .map((img) => MultipartFile.fromFileSync(img.path,
              contentType: MediaType("image", "jpg")))
          .toList();
      FormData formData = FormData.fromMap({"images": files, 'type': type});

      Dio dio = Dio();

      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      dio.options.headers = {
        'Accept': '*/*',
        'Cookie': globals.sessionId!,
      };

      final response = await dio.post('$url/images', data: formData);
      List<dynamic> imageUrls = response.data['imageUrls'];
      for (int i = 0; i < imageUrls.length; i++) {
        imageUrls[i] = 'http://${imageUrls[i]}';
      }
      return imageUrls;
    } catch (e) {
      print(e);
    }
    return [];
  }

  // 레시피 게시물 삭제
  static Future<void> deletePost(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('$url/custom-recipe-articles/$id'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        print("Post deleted successfully.");
      } else {
        print("Failed to delete post. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  static Future<void> editRecipePost(
      int id,
      String title,
      String content,
      List<XFile> images,
      List<String> iUrls,
      List<Map<String, dynamic>> ingredients,
      List<Map<String, dynamic>> sequences) async {
    List imageUrls = iUrls;
    if (images.isNotEmpty) {
      imageUrls.addAll(
          List<String>.from(await postImages(images, 'COMMUNITY_ARTICLE')));
    }
    List<Map<String, dynamic>> newSequences = [];
    for (var sequence in sequences) {
      if (sequence['imageUrl'].runtimeType == String) {
        newSequences.add({
          'sequenceNumber': sequence['sequenceNumber'],
          'content': sequence['content'],
          'imageUrl': sequence['imageUrl'],
        });
      } else if (sequence['imageUrl'].runtimeType == XFile) {
        String imageUrl =
            await postImage(sequence['imageUrl'], 'CUSTOM_RECIPE_ARTICLE');
        newSequences.add({
          'sequenceNumber': sequence['sequenceNumber'],
          'content': sequence['content'],
          'imageUrl': imageUrl,
        });
      } else {
        newSequences.add({
          'sequenceNumber': sequence['sequenceNumber'],
          'content': sequence['content'],
        });
      }
    }
    try {
      Map<String, dynamic> results = {
        'title': title,
        'content': content,
        'sequences': newSequences,
        'ingredients': ingredients,
        'imageUrls': imageUrls
      };
      final encodedResults = jsonEncode(results);
      var response =
          await http.put(Uri.parse('$url/custom-recipe-articles/$id'),
              headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json',
                'Cookie': globals.sessionId!,
              },
              body: encodedResults);
      if (response.statusCode == 200) {
        print("Post edit successfully.");
      } else {
        print("Failed to edit post. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error edit post: $e");
    }
  }

  // 레시피 게시글 댓글 작성
  static Future<void> addCommunityComment(int id, String comment) async {
    try {
      var response = await http.post(
        Uri.parse('$url/custom-recipe-articles/$id/comment'),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
          'Cookie': globals.sessionId!,
        },
        body: jsonEncode({
          'content': comment,
        }),
      );
      if (response.statusCode == 200) {
        print("Comment added successfully.");
      } else {
        print("Failed to add comment. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  // 게시물 댓글 삭제
  static Future<void> deleteComment(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('$url/custom-recipe-comments/$id'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        print("Comment deleted successfully.");
      } else {
        print("Failed to delete comment. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error delete comment: $e");
    }
  }

  // 게시물 댓글 수정
  static Future<void> editComment(int id, String comment) async {
    try {
      var response = await http.put(
        Uri.parse('$url/custom-recipe-comments/$id'),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
          'Cookie': globals.sessionId!,
        },
        body: jsonEncode({
          'content': comment,
        }),
      );
      if (response.statusCode == 200) {
        print("Comment edited successfully.");
      } else {
        print("Failed to edited comment. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error editing comment: $e");
    }
  }

  static String calUploadTime(String createdAt) {
    DateTime now = DateTime.now();
    try {
      DateTime created = DateTime.parse(createdAt);

      Duration diff = now.difference(created);
      if (!diff.isNegative) {
        if (diff.inMinutes < 60) {
          return '${diff.inMinutes} minutes ago';
        } else if (diff.inHours < 24)
          return '${diff.inHours} hours ago';
        else if (now.year == created.year)
          return '${created.month}/${created.day}';
      }
    } catch (e) {}
    return createdAt.split(' ').elementAt(0);
  }
}
