import 'package:questopia/core/repositories/slots/data/remote/slots_api.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/core/repositories/slots/domain/reserved_slot_domain.dart';
import 'package:questopia/core/repositories/slots/domain/slot_domain.dart';

class SlotsRepositoryImpl implements SlotsRepository {
  SlotsRepositoryImpl({
    required SlotsApi slotsApi,
  }) : _slotsApi = slotsApi;

  final SlotsApi _slotsApi;

  @override
  Future<List<SlotDomain>> getSlots(String questId, DateTime date) async {
    final response = await _slotsApi.getSlots(questId: questId, date: date);
    return response;
  }

  @override
  Future<void> reserveSlot({required ReservedSlotDomain slotDomain}) async {
    await _slotsApi.reserveSlot(slotDomain: slotDomain);
  }
}
