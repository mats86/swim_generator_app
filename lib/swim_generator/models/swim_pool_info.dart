import 'package:equatable/equatable.dart';

import '../pages/swim_pool/models/swim_pool.dart';

class SwimPoolInfo extends Equatable {
  const SwimPoolInfo({
    required this.swimPool,
    required this.swimPoolID,
    required this.swimPoolName,
  });

  final SwimPool swimPool;
  final int swimPoolID;
  final String swimPoolName;

  const SwimPoolInfo.empty() : this(swimPool: const SwimPool.empty(), swimPoolID: 0, swimPoolName: '');

  SwimPoolInfo copyWith({
    SwimPool? swimPool,
    int? swimPoolID,
    String? swimPoolName,
  }) {
    return SwimPoolInfo(
      swimPool: swimPool ?? this.swimPool,
      swimPoolID: swimPoolID ?? this.swimPoolID,
      swimPoolName: swimPoolName ?? this.swimPoolName,
    );
  }

  @override
  List<Object?> get props => [swimPool, swimPoolID, swimPoolName];
}
