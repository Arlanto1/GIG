part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends NotificationsEvent {
  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
class InitializeValues extends NotificationsEvent {
  const InitializeValues();
}