import 'package:yuix/data/providers/anilist/anilist_providers.dart';

const bdquery = '''
query(\$isBirthday:Boolean){
  Page {
    staff(isBirthday: \$isBirthday) {
      name {
        full
      }
      image {
        large
      }
    }
  }
}
''';

String trendingAnimeQuery = '''
query(
  \$page: Int
  \$id: Int
  \$type: MediaType
  \$isAdult: Boolean = false
  \$search: String
  \$format: [MediaFormat]
  \$status: MediaStatus
  \$countryOfOrigin: CountryCode
  \$source: MediaSource
  \$season: MediaSeason
  \$seasonYear: Int
  \$year: String
  \$onList: Boolean
  \$yearLesser: FuzzyDateInt
  \$yearGreater: FuzzyDateInt
  \$episodeLesser: Int
  \$episodeGreater: Int
  \$durationLesser: Int
  \$durationGreater: Int
  \$chapterLesser: Int
  \$chapterGreater: Int
  \$volumeLesser: Int
  \$volumeGreater: Int
  \$licensedBy: [Int]
  \$isLicensed: Boolean
  \$genres: [String]
  \$excludedGenres: [String]
  \$tags: [String]
  \$excludedTags: [String]
  \$minimumTagRank: Int
  \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: \$page, perPage: 10) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: \$id
      type: \$type
      season: \$season
      format_in: \$format
      status: \$status
      countryOfOrigin: \$countryOfOrigin
      source: \$source
      search: \$search
      onList: \$onList
      seasonYear: \$seasonYear
      startDate_like: \$year
      startDate_lesser: \$yearLesser
      startDate_greater: \$yearGreater
      episodes_lesser: \$episodeLesser
      episodes_greater: \$episodeGreater
      duration_lesser: \$durationLesser
      duration_greater: \$durationGreater
      chapters_lesser: \$chapterLesser
      chapters_greater: \$chapterGreater
      volumes_lesser: \$volumeLesser
      volumes_greater: \$volumeGreater
      licensedById_in: \$licensedBy
      isLicensed: \$isLicensed
      genre_in: \$genres
      genre_not_in: \$excludedGenres
      tag_in: \$tags
      tag_not_in: \$excludedTags
      minimumTagRank: \$minimumTagRank
      sort: \$sort
      isAdult: \$isAdult
    ) {
      id
      title {
        userPreferred
      }
      coverImage {
        extraLarge
        large
        color
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      chapters
      volumes
      genres
      isAdult
      averageScore
      popularity
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      mediaListEntry {
        id
        status
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}
''';
String _typeToQuery(AnilistType type) {
  return (type == AnilistType.anime) ? 'ANIME' : 'MANGA';
}

Map<String, dynamic> trendingMeidaQueryVariables = {
  "page": 1,
  "type": "MANGA",
  "isAdult": true,
  "countryOfOrigin": "JP",
  "sort": ["TRENDING_DESC", "POPULARITY_DESC"]
};

Map<String, dynamic> returnQuery(
    int page, String type, AnilistType? anilistType) {
  if (type == 'popular') {
    return {
      "page": page,
      "type": _typeToQuery(anilistType!),
      "season": "SPRING"
    };
  } else if (type == 'trending') {
    return {
      "page": page,
      "type": _typeToQuery(anilistType!),
      "sort": ["TRENDING_DESC", "POPULARITY_DESC"]
    };
  } else if (type == 'upcoming') {
    return {
      "page": page,
      "type": _typeToQuery(anilistType!),
      "season": "SUMMER"
    };
  } else if (type == 'alltime') {
    return {
      "page": page,
      "type": _typeToQuery(anilistType!),
      "sort": "POPULARITY_DESC"
    };
  } else if (type == 'top100') {
    return {
      "page": page,
      "type": _typeToQuery(anilistType!),
      "sort": "SCORE_DESC"
    };
  } else {
    return {};
  }
}

String popularAnimeQuery = '''
query(
  \$page: Int = 1
  \$id: Int
  \$type: MediaType
  \$isAdult: Boolean = false
  \$search: String
  \$format: [MediaFormat]
  \$status: MediaStatus
  \$countryOfOrigin: CountryCode
  \$source: MediaSource
  \$season: MediaSeason
  \$seasonYear: Int
  \$year: String
  \$onList: Boolean
  \$yearLesser: FuzzyDateInt
  \$yearGreater: FuzzyDateInt
  \$episodeLesser: Int
  \$episodeGreater: Int
  \$durationLesser: Int
  \$durationGreater: Int
  \$chapterLesser: Int
  \$chapterGreater: Int
  \$volumeLesser: Int
  \$volumeGreater: Int
  \$licensedBy: [Int]
  \$isLicensed: Boolean
  \$genres: [String]
  \$excludedGenres: [String]
  \$tags: [String]
  \$excludedTags: [String]
  \$minimumTagRank: Int
  \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: \$page, perPage: 10) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: \$id
      type: \$type
      season: \$season
      format_in: \$format
      status: \$status
      countryOfOrigin: \$countryOfOrigin
      source: \$source
      search: \$search
      onList: \$onList
      seasonYear: \$seasonYear
      startDate_like: \$year
      startDate_lesser: \$yearLesser
      startDate_greater: \$yearGreater
      episodes_lesser: \$episodeLesser
      episodes_greater: \$episodeGreater
      duration_lesser: \$durationLesser
      duration_greater: \$durationGreater
      chapters_lesser: \$chapterLesser
      chapters_greater: \$chapterGreater
      volumes_lesser: \$volumeLesser
      volumes_greater: \$volumeGreater
      licensedById_in: \$licensedBy
      isLicensed: \$isLicensed
      genre_in: \$genres
      genre_not_in: \$excludedGenres
      tag_in: \$tags
      tag_not_in: \$excludedTags
      minimumTagRank: \$minimumTagRank
      sort: \$sort
      isAdult: \$isAdult
    ) {
      id
      title {
        userPreferred
        romaji
        english
      }
      coverImage {
        extraLarge
        large
        color
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      chapters
      volumes
      genres
      isAdult
      averageScore
      popularity
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      mediaListEntry {
        id
        status
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}
''';

String upcommingNextSeasonquery = '''
query(
  \$page: Int = 1
  \$id: Int
  \$type: MediaType
  \$isAdult: Boolean = false
  \$search: String
  \$format: [MediaFormat]
  \$status: MediaStatus
  \$countryOfOrigin: CountryCode
  \$source: MediaSource
  \$season: MediaSeason
  \$seasonYear: Int
  \$year: String
  \$onList: Boolean
  \$yearLesser: FuzzyDateInt
  \$yearGreater: FuzzyDateInt
  \$episodeLesser: Int
  \$episodeGreater: Int
  \$durationLesser: Int
  \$durationGreater: Int
  \$chapterLesser: Int
  \$chapterGreater: Int
  \$volumeLesser: Int
  \$volumeGreater: Int
  \$licensedBy: [Int]
  \$isLicensed: Boolean
  \$genres: [String]
  \$excludedGenres: [String]
  \$tags: [String]
  \$excludedTags: [String]
  \$minimumTagRank: Int
  \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: \$page, perPage: 10) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: \$id
      type: \$type
      season: \$season
      format_in: \$format
      status: \$status
      countryOfOrigin: \$countryOfOrigin
      source: \$source
      search: \$search
      onList: \$onList
      seasonYear: \$seasonYear
      startDate_like: \$year
      startDate_lesser: \$yearLesser
      startDate_greater: \$yearGreater
      episodes_lesser: \$episodeLesser
      episodes_greater: \$episodeGreater
      duration_lesser: \$durationLesser
      duration_greater: \$durationGreater
      chapters_lesser: \$chapterLesser
      chapters_greater: \$chapterGreater
      volumes_lesser: \$volumeLesser
      volumes_greater: \$volumeGreater
      licensedById_in: \$licensedBy
      isLicensed: \$isLicensed
      genre_in: \$genres
      genre_not_in: \$excludedGenres
      tag_in: \$tags
      tag_not_in: \$excludedTags
      minimumTagRank: \$minimumTagRank
      sort: \$sort
      isAdult: \$isAdult
    ) {
      id
      title {
        userPreferred
      }
      coverImage {
        extraLarge
        large
        color
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      chapters
      volumes
      genres
      isAdult
      averageScore
      popularity
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      mediaListEntry {
        id
        status
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}

''';

String allTimePopularQuery = '''
query(
  \$page: Int = 1
  \$id: Int
  \$type: MediaType
  \$isAdult: Boolean = false
  \$search: String
  \$format: [MediaFormat]
  \$status: MediaStatus
  \$countryOfOrigin: CountryCode
  \$source: MediaSource
  \$season: MediaSeason
  \$seasonYear: Int
  \$year: String
  \$onList: Boolean
  \$yearLesser: FuzzyDateInt
  \$yearGreater: FuzzyDateInt
  \$episodeLesser: Int
  \$episodeGreater: Int
  \$durationLesser: Int
  \$durationGreater: Int
  \$chapterLesser: Int
  \$chapterGreater: Int
  \$volumeLesser: Int
  \$volumeGreater: Int
  \$licensedBy: [Int]
  \$isLicensed: Boolean
  \$genres: [String]
  \$excludedGenres: [String]
  \$tags: [String]
  \$excludedTags: [String]
  \$minimumTagRank: Int
  \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: \$page, perPage: 10) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: \$id
      type: \$type
      season: \$season
      format_in: \$format
      status: \$status
      countryOfOrigin: \$countryOfOrigin
      source: \$source
      search: \$search
      onList: \$onList
      seasonYear: \$seasonYear
      startDate_like: \$year
      startDate_lesser: \$yearLesser
      startDate_greater: \$yearGreater
      episodes_lesser: \$episodeLesser
      episodes_greater: \$episodeGreater
      duration_lesser: \$durationLesser
      duration_greater: \$durationGreater
      chapters_lesser: \$chapterLesser
      chapters_greater: \$chapterGreater
      volumes_lesser: \$volumeLesser
      volumes_greater: \$volumeGreater
      licensedById_in: \$licensedBy
      isLicensed: \$isLicensed
      genre_in: \$genres
      genre_not_in: \$excludedGenres
      tag_in: \$tags
      tag_not_in: \$excludedTags
      minimumTagRank: \$minimumTagRank
      sort: \$sort
      isAdult: \$isAdult
    ) {
      id
      title {
        userPreferred
        romaji
        english
      }
      coverImage {
        extraLarge
        large
        color
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      chapters
      volumes
      genres
      isAdult
      averageScore
      popularity
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      mediaListEntry {
        id
        status
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}
''';

String top100AnimeQuery = '''
query(
  \$page: Int = 1
  \$id: Int
  \$type: MediaType
  \$isAdult: Boolean = false
  \$search: String
  \$format: [MediaFormat]
  \$status: MediaStatus
  \$countryOfOrigin: CountryCode
  \$source: MediaSource
  \$season: MediaSeason
  \$seasonYear: Int
  \$year: String
  \$onList: Boolean
  \$yearLesser: FuzzyDateInt
  \$yearGreater: FuzzyDateInt
  \$episodeLesser: Int
  \$episodeGreater: Int
  \$durationLesser: Int
  \$durationGreater: Int
  \$chapterLesser: Int
  \$chapterGreater: Int
  \$volumeLesser: Int
  \$volumeGreater: Int
  \$licensedBy: [Int]
  \$isLicensed: Boolean
  \$genres: [String]
  \$excludedGenres: [String]
  \$tags: [String]
  \$excludedTags: [String]
  \$minimumTagRank: Int
  \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: \$page, perPage: 10) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: \$id
      type: \$type
      season: \$season
      format_in: \$format
      status: \$status
      countryOfOrigin: \$countryOfOrigin
      source: \$source
      search: \$search
      onList: \$onList
      seasonYear: \$seasonYear
      startDate_like: \$year
      startDate_lesser: \$yearLesser
      startDate_greater: \$yearGreater
      episodes_lesser: \$episodeLesser
      episodes_greater: \$episodeGreater
      duration_lesser: \$durationLesser
      duration_greater: \$durationGreater
      chapters_lesser: \$chapterLesser
      chapters_greater: \$chapterGreater
      volumes_lesser: \$volumeLesser
      volumes_greater: \$volumeGreater
      licensedById_in: \$licensedBy
      isLicensed: \$isLicensed
      genre_in: \$genres
      genre_not_in: \$excludedGenres
      tag_in: \$tags
      tag_not_in: \$excludedTags
      minimumTagRank: \$minimumTagRank
      sort: \$sort
      isAdult: \$isAdult
    ) {
      id
      title {
        userPreferred
      }
      coverImage {
        extraLarge
        large
        color
        
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      chapters
      volumes
      genres
      isAdult
      averageScore
      popularity
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      mediaListEntry {
        id
        status
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}
''';
