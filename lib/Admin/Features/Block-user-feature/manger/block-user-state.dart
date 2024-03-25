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
///un block user
class UnBlockLoadingState extends BlockUserStates {}
class UnBlockSuccessState extends BlockUserStates {}
class UnBlockErorrState extends BlockUserStates {}
/// saerch
class UserSearchLoading extends BlockUserStates{}
class UserSearchSuccess extends BlockUserStates{}
class UserSearchFailure extends BlockUserStates{}