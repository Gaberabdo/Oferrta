abstract class HomeState {}

class HomeInitialState extends HomeState {}
class ChangeItemIndex extends HomeState {}

class GetUserdataSuccess extends HomeState {}
class ErrorGetUserdata extends HomeState {}
class LoadingGetUserdata extends HomeState {}