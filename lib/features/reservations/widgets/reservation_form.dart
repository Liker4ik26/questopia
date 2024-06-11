import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/slots/domain/reserved_slot_domain.dart';
import 'package:questopia/features/reservations/blocs/slots/slots_bloc.dart';

import '../../../core/common/widgets/custom_button.dart';
import '../../../core/utils/validators.dart';
import '../blocs/reserved_slots/reserved_slots_bloc.dart';

class ReservationForm extends StatefulWidget {
  ReservationForm({
    super.key,
    required this.questId,
    required this.selectedSlot,
    required this.chosenDate,
    required this.showNotification,
  });

  final String questId;
  final List<String?> selectedSlot;
  Future<void> showNotification;
  DateTime chosenDate = DateTime.now().copyWith(isUtc: true);

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  int totalPrice = 0;

  void updateTotalPrice(
      {required String count,
      required int addPriceForPlayer,
      required String price}) {
    setState(() {
      if (int.parse(count) > 4) {
        totalPrice =
            ((int.parse(count) - 4) * addPriceForPlayer) + int.parse(price);
        return;
      }
      totalPrice = int.parse(price);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _countPlayer = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 24),
          CustomTextField(
            bgColor: context.color.onTertiary,
            textInputAction: TextInputAction.next,
            textController: _phone,
            textInputType: TextInputType.phone,
            hint: 'Введите номер телефона',
            validator: (value) {
              return mobileValidator(context, value);
            },
            inputFormatters: [maskFormatter],
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(height: 16),
          BlocBuilder<SlotsBloc, SlotsState>(
            bloc: context.read<SlotsBloc>()
              ..add(
                LoadSlotsEvent(
                    completer: null,
                    questId: widget.questId,
                    date: widget.chosenDate),
              ),
            builder: (context, state) {
              if (state is SlotsLoadedState) {
                return CustomTextField(
                  textController: _countPlayer,
                  bgColor: context.color.onTertiary,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.phone,
                  hint: 'Введите количество человек',
                  validator: (value) {
                    return countPlayerValidator(
                      context: context,
                      countPlayer: value,
                      max: state.slots.first.price.playersMax,
                      min: state.slots.first.price.playersMin,
                    );
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  onChanged: (value) {
                    updateTotalPrice(
                      count: _countPlayer.text,
                      addPriceForPlayer: int.parse(
                        state.slots.first.price.priceAdditionalPlayer,
                      ),
                      price: state.slots.first.price.price,
                    );
                  },
                );
              }
              return CustomTextField(
                textController: _countPlayer,
                bgColor: context.color.onTertiary,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.phone,
                hint: 'Введите количество человек',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                ],
              );
            },
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(height: 160),
          BlocConsumer<SlotsBloc, SlotsState>(
            listener: (context, state) {},
            bloc: context.read<SlotsBloc>()
              ..add(LoadSlotsEvent(
                  completer: null,
                  questId: widget.questId,
                  date: widget.chosenDate)),
            builder: (context, state) {
              if (state is SlotsLoadedState) {
                return BlocBuilder<ReservedSlotsBloc, ReservedSlotsState>(
                  builder: (context, state) {
                    if (state is ReservedSlotsInitialState) {
                      return SafeArea(
                        child: CustomButton(
                          title: 'Забронировать за $totalPrice ₽ ',
                          titleColor: widget.selectedSlot.isNotEmpty
                              ? context.color.primary
                              : context.color.primary.withOpacity(.4),
                          bgColor: widget.selectedSlot.isNotEmpty
                              ? context.color.tertiary
                              : context.color.tertiary.withOpacity(.4),
                          onPressed: widget.selectedSlot.isNotEmpty
                              ? () async {
                                  if (_formKey.currentState!.validate() &&
                                      widget.selectedSlot.isNotEmpty) {
                                    context.read<ReservedSlotsBloc>().add(
                                          ReservedSlotEvent(
                                            reservedSlot: ReservedSlotDomain(
                                              phone: _phone.text,
                                              countPlayer:
                                                  int.parse(_countPlayer.text),
                                              idSlot:
                                                  widget.selectedSlot.first!,
                                              price: '$totalPrice',
                                            ),
                                          ),
                                        );
                                    if (widget.selectedSlot.isNotEmpty) {
                                      await widget.showNotification;
                                    }
                                    print('все успешно');
                                  }
                                }
                              : null,
                        ),
                      );
                    }
                    if (state is ReservedSlotsErrorState) {
                      return CustomButton(
                        title: state.error.toString(),
                      );
                    }
                    if (state is ReservedSlotsLoadingState) {
                      return CustomButton(
                        child: CircularProgressIndicator(
                          color: context.color.primary,
                        ),
                      );
                    }
                    if (state is ReservedSlotsLoadedState) {
                      context.pop();
                    }
                    return CustomButton(
                      title: 'Забронировать за $totalPrice ₽ ',
                      titleColor: widget.selectedSlot.isNotEmpty
                          ? context.color.primary
                          : context.color.primary.withOpacity(.4),
                      bgColor: widget.selectedSlot.isNotEmpty
                          ? context.color.tertiary
                          : context.color.tertiary.withOpacity(.4),
                      onPressed: widget.selectedSlot.isNotEmpty
                          ? () async {
                              if (_formKey.currentState!.validate() &&
                                  widget.selectedSlot.isNotEmpty) {
                                context.read<ReservedSlotsBloc>().add(
                                      ReservedSlotEvent(
                                        reservedSlot: ReservedSlotDomain(
                                          phone: '+7 ${_phone.text}',
                                          countPlayer:
                                              int.parse(_countPlayer.text),
                                          idSlot: widget.selectedSlot.first!,
                                          price: '$totalPrice',
                                        ),
                                      ),
                                    );
                                if (widget.selectedSlot.isNotEmpty) {
                                  await widget.showNotification;
                                }
                                print('все успешно');
                              }
                            }
                          : null,
                    );
                  },
                );
              }
              return const SafeArea(
                child: CustomButton(
                  title: 'Забронировать за 0 ₽ ',
                ),
              );
            },
          ).paddingAll(24),
        ],
      ),
    );
  }
}
