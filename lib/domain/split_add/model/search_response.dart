class SearchResponse {
  final SearchData data;

  SearchResponse({
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      data: SearchData.fromJson(json),
    );
  }
}

class SearchData {
  final List<FriendItem> friends;
  final List<GroupSearchItem> groups;
  final int totalFriends;
  final int totalGroups;

  SearchData({
    required this.friends,
    required this.groups,
    required this.totalFriends,
    required this.totalGroups,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      friends: (json['friends'] as List?)
              ?.map((item) => FriendItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      groups: (json['groups'] as List?)
              ?.map((item) =>
                  GroupSearchItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalFriends: json['totalFriends'] ?? 0,
      totalGroups: json['totalGroups'] ?? 0,
    );
  }
}

class FriendItem {
  final String userId;
  final String username;
  final String name;
  final String email;
  final String lastActivity;

  FriendItem({
    required this.userId,
    required this.username,
    required this.name,
    required this.email,
    required this.lastActivity,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) {
    return FriendItem(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      lastActivity: json['lastActivity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'name': name,
        'email': email,
        'lastActivity': lastActivity,
      };
}

class GroupSearchItem {
  final int groupId;
  final String groupName;
  final String description;
  final int memberCount;
  final String lastActivity;
  final List<GroupParticipant> participants;

  GroupSearchItem({
    required this.groupId,
    required this.groupName,
    required this.description,
    required this.memberCount,
    required this.lastActivity,
    this.participants = const [],
  });

  factory GroupSearchItem.fromJson(Map<String, dynamic> json) {
    return GroupSearchItem(
      groupId: json['groupId'] ?? 0,
      groupName: json['groupName'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      lastActivity: json['lastActivity'] ?? '',
      participants: (json['participants'] as List?)
              ?.map((item) =>
                  GroupParticipant.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'groupName': groupName,
        'description': description,
        'memberCount': memberCount,
        'lastActivity': lastActivity,
        'participants': participants.map((p) => p.toJson()).toList(),
      };
}

class GroupParticipant {
  final String userId;
  final String username;
  final String name;
  final bool isAdmin;

  GroupParticipant({
    required this.userId,
    required this.username,
    required this.name,
    required this.isAdmin,
  });

  factory GroupParticipant.fromJson(Map<String, dynamic> json) {
    return GroupParticipant(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'name': name,
        'isAdmin': isAdmin,
      };
}