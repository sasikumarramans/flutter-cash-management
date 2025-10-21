import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:equatable/equatable.dart';

enum CreateGroupStatus {
  initial,
  loading,
  success,
  failed,
}

enum SearchStatus {
  initial,
  loading,
  success,
  failed,
}

class CreateGroupState extends Equatable {
  final String groupName;
  final String category;
  final String currency;
  final String? groupImageFile;
  final String? searchQuery;
  final CreateGroupStatus status;
  final String? errorMessage;
  final bool isButtonEnabled;
  final bool isGroupNameEnabled;
  final List<SearchUserData> searchResults;
  final List<SearchUserData> selectedUsers;
  final SearchStatus searchStatus;

  const CreateGroupState({
    this.groupName = '',
    this.searchQuery = '',
    this.category = 'Friends',
    this.currency = 'USD',
    this.groupImageFile,
    this.status = CreateGroupStatus.initial,
    this.errorMessage,
    this.isButtonEnabled = false,
    this.isGroupNameEnabled = false,
    this.searchResults = const [],
    this.selectedUsers = const [],
    this.searchStatus = SearchStatus.initial,
  });

  CreateGroupState copyWith({
    String? groupName,
    String? searchQuery,
    String? category,
    String? currency,
    List<String>? memberUsernames,
    String? groupImageFile,
    CreateGroupStatus? status,
    String? errorMessage,
    bool? isButtonEnabled,
    bool? isGroupNameEnabled,
    List<SearchUserData>? searchResults,
    List<SearchUserData>? selectedUsers,
    SearchStatus? searchStatus,
  }) {
    return CreateGroupState(
      groupName: groupName ?? this.groupName,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      groupImageFile: groupImageFile ?? this.groupImageFile,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isGroupNameEnabled: isGroupNameEnabled ?? this.isGroupNameEnabled,
      searchResults: searchResults ?? this.searchResults,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      searchStatus: searchStatus ?? this.searchStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        groupName,
        category,
        currency,
        groupImageFile,
        status,
        errorMessage,
        isButtonEnabled,
        isGroupNameEnabled,
        searchResults,
        selectedUsers,
        searchStatus,
        searchQuery,
      ];
}
