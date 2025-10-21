import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:equatable/equatable.dart';

sealed class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object?> get props => [];
}

class GroupNameChanged extends CreateGroupEvent {
  final String groupName;
  const GroupNameChanged(this.groupName);
}

class CategoryChanged extends CreateGroupEvent {
  final String category;
  const CategoryChanged(this.category);
}

class AddGroupPhoto extends CreateGroupEvent {
  final MediaPicker? mediaPicker;
  const AddGroupPhoto({this.mediaPicker});
}

class GroupNameValidationCompleted extends CreateGroupEvent {
  final bool isValid;
  const GroupNameValidationCompleted(this.isValid);
}

class CreateGroup extends CreateGroupEvent {
  const CreateGroup();
}

class SearchUsers extends CreateGroupEvent {
  final String query;
  const SearchUsers(this.query);
}

class AddSelectedUser extends CreateGroupEvent {
  final SearchUserData user;
  const AddSelectedUser(this.user);
}

class RemoveSelectedUser extends CreateGroupEvent {
  final String userId;
  const RemoveSelectedUser(this.userId);
}

class ClearSearchResults extends CreateGroupEvent {
  const ClearSearchResults();
}
