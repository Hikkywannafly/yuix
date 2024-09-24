import 'package:dio/dio.dart';

enum AnilistType {
  anime,
  manga,
}

enum AnilistMediaListStatus {
  current,
  completed,
  planning,
  paused,
  dropped,
  repeating,
}

   String _typeToQuery(AnilistType type) {
    return (type == AnilistType.anime) ? 'ANIME' : 'MANGA';
  }

class AniListProvider {
  static const headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const String apiUrl = 'https://graphql.anilist.co';

  // ignore: unused_element
  static String _typeToQuery(AnilistType type) {
    return (type == AnilistType.anime) ? 'ANIME' : 'MANGA';
  }

  static String mediaListStatusToQuery(AnilistMediaListStatus status,
      {bool firstLetterUpperCase = false}) {
    switch (status) {
      case AnilistMediaListStatus.current:
        return "CURRENT";
      case AnilistMediaListStatus.completed:
        return "COMPLETED";
      case AnilistMediaListStatus.planning:
        return "PLANNING";
      case AnilistMediaListStatus.paused:
        return "PAUSED";
      case AnilistMediaListStatus.dropped:
        return "DROPPED";
      case AnilistMediaListStatus.repeating:
        return "REPEATING";
    }
  }

  static AnilistMediaListStatus stringToMediaListStatus(String status) {
    switch (status) {
      case "CURRENT":
        return AnilistMediaListStatus.current;
      case "COMPLETED":
        return AnilistMediaListStatus.completed;
      case "PLANNING":
        return AnilistMediaListStatus.planning;
      case "PAUSED":
        return AnilistMediaListStatus.paused;
      case "DROPPED":
        return AnilistMediaListStatus.dropped;
      case "REPEATING":
        return AnilistMediaListStatus.repeating;
      default:
        return AnilistMediaListStatus.current;
    }
  }

  static postRequest({
    Map<String, dynamic>? variable,
    required String queryString,
  }) async {
    try {
      final response = await Dio().post(apiUrl,
          options: Options(headers: {
            // "Authorization": "Bearer $anilistToken",
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          data: {
            "query": queryString,
          });
      return response;
    } on DioException catch (e) {
      print('${e.response}');
    }
  }

  static Future<Map<String, dynamic>> getTrendingMedia() async {
    const query = """
    query {
      Page(page: 1, perPage: 10) {
        media(sort: TRENDING_DESC) {
          id
          title {
            userPreferred
          }
          coverImage {
            large
          }
          bannerImage
          description
          status
          episodes
          chapters
          meanScore
          genres
          format
          startDate {
            year
            month
            day
          }
        }
      }
    }
    """;
    final response = await postRequest(queryString: query);
    return response.data;
  }

  // static Future<Map<String, dynamic>> getCollection(
  //   AnilistType anilistType,
  // ) async {
  //   final query = """
  //     {
  //       MediaListCollection( type : ${_typeToQuery(anilistType)}) {
  //         lists {
  //           status
  //           entries {
  //             status
  //             progress
  //             score
  //             media {
  //               id
  //               status
  //               chapters
  //               episodes
  //               meanScore
  //               isFavourite
  //               coverImage {
  //                 large
  //               }
  //               title {
  //                 userPreferred
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }

  //     """;

  //   final collectionData = <String, List>{};

  //   return collectionData;
  // }

  // static Future<dynamic> getMediaList(String id) async {
  //   final query = """
  //   {

  //   }""";
  // }
}
