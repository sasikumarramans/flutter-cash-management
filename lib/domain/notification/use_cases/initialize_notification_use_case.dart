import 'package:bearnshare/domain/notification/notification_repository.dart';
import 'package:bearnshare/generated/l10n.dart';

class InitializeNotificationUseCase {
  final NotificationRepository repository;

  InitializeNotificationUseCase(this.repository);

  Future<void> call() async {
    await repository.initialize();
    await repository.subscribeToTopic(S().s_high_importance_channel);
  }
}
