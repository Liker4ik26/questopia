import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';
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
  });

  final String questId;

  final List<String?> selectedSlot;
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
            prefixText: '+7 ',
            hint: '+7 (000) 000-00-00',
            textInputType: TextInputType.phone,
            title: 'Телефон',
            validator: (value) {
              return mobileValidator(context, '+7 $value');
            },
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: 'RU',
              ),
            ],
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
                  textInputType: TextInputType.number,
                  title: 'Количество человек',
                  hint: '3',
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
                textInputType: TextInputType.number,
                title: 'Количество человек',
                hint: '3',
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
                              ? () {
                                  if (_formKey.currentState!.validate() &&
                                      widget.selectedSlot.isNotEmpty) {
                                    context.read<ReservedSlotsBloc>().add(
                                          ReservedSlotEvent(
                                            reservedSlot: ReservedSlotDomain(
                                              phone: '+7 ${_phone.text}',
                                              countPlayer:
                                                  int.parse(_countPlayer.text),
                                              idSlot:
                                                  widget.selectedSlot.first!,
                                              price: '$totalPrice',
                                            ),
                                          ),
                                        );
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
                      // scheduleNotification(
                      //   widget.chosenDate,
                      //   TimeOfDay.fromDateTime(
                      //     DateTime.parse('2022-01-01 10:00:00'),
                      //   ),
                      // );
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
                          ? () {
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
