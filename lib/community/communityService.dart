import '../db/comment.dart';
import '../db/communityPost.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CommunitySerrvices {
  static const String url = 'http://api.kfoodbox.click';

  static Future<CommunityPost> getPostInfo(postId) async {
    CommunityPost temp = CommunityPost(
        id: -1,
        userId: -1,
        isMine: false,
        isBookmarked: false,
        like: false,
        title: '',
        content: '',
        imageUrls: [],
        createdAt: '',
        updatedAt: '',
        nickname: '',
        likeCount: -1,
        commentCount: -1);
    try {
      final response =
          await http.get(Uri.parse('$url/community-articles/$postId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        CommunityPost postInfo = CommunityPost.fromJson(jsonData);
        return postInfo;
      } else {
        return temp;
      }
    } catch (e) {
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

  static Future<List<Comment>> getComments(postId) async {
    try {
      final response =
          await http.get(Uri.parse('$url/community-articles/$postId/comments'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<Comment> comments = toCommentList(jsonData['comments']);
        return comments;
      } else {
        return <Comment>[];
      }
    } catch (e) {
      return <Comment>[];
    }
  }

  // static postImages(List<XFile?> images, String type) async {
  //   final List<MultipartFile> files = images
  //       .map((img) => MultipartFile.fromFileSync(img!.path,
  //           contentType: MediaType("image", "jpg")))
  //       .toList();
  //   FormData formData = FormData.fromMap({"images": files});
  //   Dio dio = Dio();

  //   dio.options.headers["authorization"] = AuthProvider.token;
  //   dio.options.contentType = 'multipart/form-data';

  //   final res = await dio.post('$url/images', data: formData).then((res) {
  //     Get.back();
  //     return res.data;
  //   });

  //   // var response = await http.post(
  //   //   Uri.parse('$url/images'),
  //   //   headers: {'Cookie': 'JSESSIONID=4FCBBCB164E334B014773B52598498ED'},
  //   //   body: {'images': images, 'type': type},
  //   // );
  //   // print('Response status: ${response.statusCode}');
  //   // print('Response body: ${response.body}');
  // }
}
