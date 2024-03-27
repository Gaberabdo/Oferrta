import '../../../../Features/Auth-feature/manger/model/user_model.dart';

abstract class BlockUserStates {}

class BlockInitialState extends BlockUserStates {}
///block user
class BlockLoadingState extends BlockUserStates {}
class BlockSuccessState extends BlockUserStates {}
class BlockErorrState extends BlockUserStates {}
///get user
class GetAllUserLoadingHomePageStates extends BlockUserStates {}
class GetAllUserSuccessHomePageStates extends BlockUserStates {}
class GetAllUserErrorHomePageStates extends BlockUserStates {}
class FilterUsersSuccess extends BlockUserStates {}
///un block user
class UnBlockLoadingState extends BlockUserStates {}
class UnBlockSuccessState extends BlockUserStates {}
class UnBlockErorrState extends BlockUserStates {}
/// saerch
class UserSearchLoading extends BlockUserStates{}
class UserSearchSuccess extends BlockUserStates{

  List<UserModel>users=[];
  UserSearchSuccess(this.users);
}
class UserSearchFailure extends BlockUserStates{}
///update user
class ImageUploadSuccess extends BlockUserStates{}
class ImageUploadFailed extends BlockUserStates{}
class ImageUploadLoading extends BlockUserStates{}
class UpdateLoadingUserDataState extends BlockUserStates{}
class UpdateSuccessUserDataState extends BlockUserStates{}
class UpdateErrorUserDataState extends BlockUserStates{}
///delete user
class DeleteLoadingUserDataState extends BlockUserStates{}
class DeleteSuccessUserDataState extends BlockUserStates{}
class DeleteErrorUserDataState extends BlockUserStates{}
