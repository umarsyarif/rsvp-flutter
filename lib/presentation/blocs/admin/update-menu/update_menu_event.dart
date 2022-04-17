part of 'update_menu_bloc.dart';

abstract class UpdateMenuEvent extends Equatable {
  const UpdateMenuEvent();
  @override
  List<Object> get props => [];
}
class FetchUpdateMenuEvent extends UpdateMenuEvent{}
class PostUpdateMenuEvent extends UpdateMenuEvent{
  final MenuParams params;

  const PostUpdateMenuEvent(this.params);
}
