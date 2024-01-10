part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final CdUiLabels? labels;
  final String? message;

  const NotificationsState({
    this.items = const <NotificationModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
  });

  NotificationsState copyWith({
    List<NotificationModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CdUiLabels? labels,
    String? message,
  }) {
    return NotificationsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
