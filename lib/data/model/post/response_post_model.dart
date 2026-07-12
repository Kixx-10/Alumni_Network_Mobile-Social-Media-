class ResponsePostModel {
  final String postId;
  final String? content;
  final String? mediaUrls;   
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final DateTime createdDate;
  final String authorId;
  final String authorName;
  final String authorAvatarUrl;
  final bool isLiked;

  ResponsePostModel({
    required this.postId,
    this.content,
    this.mediaUrls,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.createdDate,
    required this.authorId,
    required this.authorName,
    required this.authorAvatarUrl,
    this.isLiked = false,
  });

  factory ResponsePostModel.fromJson(Map<String, dynamic> json) {
  
    //    if mediaUrls List join ','
    //    post_card.dart  split(',') 
    final dynamic rawMedia = json['mediaUrls'];
    String? parsedMediaUrls;
    if (rawMedia is List && rawMedia.isNotEmpty) {
      parsedMediaUrls = rawMedia.map((e) => e.toString()).join(',');
    } else if (rawMedia is String && rawMedia.isNotEmpty) {
      parsedMediaUrls = rawMedia;
    }

    DateTime parsedDate;
    try {
      parsedDate = json['createdDate'] != null
          ? DateTime.parse(json['createdDate'].toString())
          : DateTime.now();
    } catch (_) {
      parsedDate = DateTime.now();
    }

    return ResponsePostModel(
      postId:   json['postId']?.toString()   ?? '',
      content:  json['content']?.toString(),
      mediaUrls: parsedMediaUrls,

      likeCount:    (json['likeCount']    as num? ?? 0).toInt(),
      commentCount: (json['commentCount'] as num? ?? 0).toInt(),
      shareCount:   (json['shareCount']   as num? ?? 0).toInt(),

      createdDate: parsedDate,

      authorId:        json['authorId']?.toString()        ?? '',
      authorName:      json['authorName']?.toString()      ?? 'Unknown Author',

      authorAvatarUrl: json['authorAvatarUrl']?.toString() ?? '',

      isLiked: json['isLiked'] == true || json['isLiked'] == 1,
    );
  }

  // ── Model → JSON ─────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'postId':          postId,
      'content':         content,
      'mediaUrls':       mediaUrls,
      'likeCount':       likeCount,
      'commentCount':    commentCount,
      'shareCount':      shareCount,
      'createdDate':     createdDate.toIso8601String(),
      'authorId':        authorId,
      'authorName':      authorName,
      'authorAvatarUrl': authorAvatarUrl,
      'isLiked':         isLiked,
    };
  }
  ResponsePostModel copyWith({
    String? postId,
    String? content,
    String? mediaUrls,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    DateTime? createdDate,
    String? authorId,
    String? authorName,
    String? authorAvatarUrl,
    bool? isLiked,
  }) {
    return ResponsePostModel(
      postId:          postId          ?? this.postId,
      content:         content         ?? this.content,
      mediaUrls:       mediaUrls       ?? this.mediaUrls,
      likeCount:       likeCount       ?? this.likeCount,
      commentCount:    commentCount     ?? this.commentCount,
      shareCount:      shareCount      ?? this.shareCount,
      createdDate:     createdDate     ?? this.createdDate,
      authorId:        authorId        ?? this.authorId,
      authorName:      authorName      ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      isLiked:         isLiked         ?? this.isLiked,
    );
  }

  List<String> get mediaUrlList {
    if (mediaUrls == null || mediaUrls!.isEmpty) return [];
    return mediaUrls!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  bool get hasMedia => mediaUrlList.isNotEmpty;

  bool get hasContent => content != null && content!.isNotEmpty;

  @override
  String toString() {
    return 'ResponsePostModel(postId: $postId, authorName: $authorName, '
        'likeCount: $likeCount, commentCount: $commentCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResponsePostModel && other.postId == postId;
  }

  @override
  int get hashCode => postId.hashCode;
}