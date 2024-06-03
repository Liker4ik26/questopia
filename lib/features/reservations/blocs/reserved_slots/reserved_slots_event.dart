part of 'reserved_slots_bloc.dart';

@immutable
abstract class ReservedSlotsEvent {
  const ReservedSlotsEvent();
}

final class ReservedSlotEvent extends ReservedSlotsEvent {
  const ReservedSlotEvent({required this.reservedSlot});

  final ReservedSlotDomain reservedSlot;
}
