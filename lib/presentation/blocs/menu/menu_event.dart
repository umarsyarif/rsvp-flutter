part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
  @override
  List<Object> get props => [];
}
class FetchSatuan extends MenuEvent{}
class AddMenuEvent extends MenuEvent{
  final MenuParams params;

  const AddMenuEvent(this.params);
}
class FetchMenuEvent extends MenuEvent{}

