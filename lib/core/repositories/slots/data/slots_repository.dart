import 'package:questopia/core/repositories/slots/domain/reserved_slot_domain.dart';
import 'package:questopia/core/repositories/slots/domain/slot_domain.dart';

abstract interface class SlotsRepository {
  const SlotsRepository._();

  Future<List<SlotDomain>> getSlots(String questId,DateTime date);
  Future<void> reserveSlot({required ReservedSlotDomain slotDomain});
}
