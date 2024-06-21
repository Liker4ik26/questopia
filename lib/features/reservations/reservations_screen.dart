import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/extensions/widget_modifier.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/features/reservations/blocs/reserved_slots/reserved_slots_bloc.dart';
import 'package:questopia/features/reservations/blocs/slots/slots_bloc.dart';
import 'package:questopia/features/reservations/widgets/calendar.dart';
import 'package:questopia/features/reservations/widgets/reservation_form.dart';
import 'package:questopia/features/reservations/widgets/time_container.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen(
      {super.key, required this.questId, required this.questTitle});

  final String questId;
  final String questTitle;

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  bool isSelected = false;
  List<String> selectedSlot = [];
  DateTime chosenDate = DateTime.now().copyWith(isUtc: true);
  FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();
  String slotTime = "";

  @override
  void initState() {
    super.initState();
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "Chanel ID",
      "Description",
      channelDescription: 'jfirej',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );
    var generalDetails = NotificationDetails(android: androidDetails);
    tz.initializeTimeZones();
    await localNotifications.zonedSchedule(
      0,
      'Вы забронировали квест ${widget.questTitle}!',
      'Ваш квест был забронирован на  ${DateFormat('dd MMMM yyyy', 'ru').format(chosenDate)}, время: ${convertTimeFormat(slotTime)}!',
      tz.TZDateTime.utc(chosenDate.year, chosenDate.month, chosenDate.day).add(
        const Duration(
          days: -1,
          hours: 12,
          minutes: 30,
        ),
      ),
      generalDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.onSecondary,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SlotsBloc(slotsRepository: context.read<SlotsRepository>()),
          ),
          BlocProvider(
            create: (context) => ReservedSlotsBloc(
                slotsRepository: context.read<SlotsRepository>()),
          ),
        ],
        child: BlocListener<ReservedSlotsBloc, ReservedSlotsState>(
          listener: (context, state) {
            if (state is ReservedSlotsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.medium,
                    ),
                  ),
                  backgroundColor: context.color.error,
                  content: Text(
                    ' Произошла ошибка при бронировании квеста: ${state.error.toString()}' +
                        'Попробуйте позже',
                  ),
                ),
              );
            }
            if (state is ReservedSlotsLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.medium,
                    ),
                  ),
                  backgroundColor: context.color.tertiary,
                  content: const Text('Квест успешно забронирован!'),
                ),
              );
            }
          },
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: .9,
            minChildSize: .6,
            snap: true,
            builder: (context, scrollController) {
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    backgroundColor: context.color.onSecondary,
                    flexibleSpace: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Забронировать',
                          style: context.text.rfDewiBold28,
                        ),
                        const Spacer(),
                        IconButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: context.color.onTertiary,
                              foregroundColor: context.color.primary),
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 24),
                  ),
                  const SizedBox(height: 24).sliver,
                  BlocBuilder<SlotsBloc, SlotsState>(
                    bloc: context.read<SlotsBloc>()
                      ..add(
                        LoadSlotsEvent(
                          completer: null,
                          questId: widget.questId,
                          date: chosenDate,
                        ),
                      ),
                    builder: (context, state) {
                      if (state is SlotsErrorState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.error.toString(),
                              style: context.text.rfDewiBold16,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => context.read<SlotsBloc>().add(
                                    LoadSlotsEvent(
                                        completer: null,
                                        questId: widget.questId,
                                        date: chosenDate),
                                  ),
                              child: Text(
                                'Перезагрузить',
                                style: context.text.rfDewiBold16
                                    .copyWith(color: context.color.tertiary),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 16).sliver;
                      }
                      if (state is SlotsLoadedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TimeTableCalendar(
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  chosenDate = selectedDay;
                                });
                              },
                              chosenDate: chosenDate,
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              direction: Axis.horizontal,
                              spacing: 12,
                              children:
                                  List.generate(state.slots.length, (index) {
                                final slot = state.slots[index];
                                return TimeContainer(
                                  onTap: () {
                                    setState(() {
                                      if (selectedSlot.contains(
                                              state.slots[index].idSlot) ==
                                          true) {
                                        selectedSlot.remove(slot.idSlot);
                                      } else if (selectedSlot.isEmpty) {
                                        selectedSlot.add(slot.idSlot);
                                      } else if (selectedSlot.contains(
                                              state.slots[index].idSlot) ==
                                          false) {
                                        selectedSlot.remove(selectedSlot.last);
                                        selectedSlot.add(slot.idSlot);
                                      }
                                      slotTime = selectedSlot.contains(
                                              state.slots[index].idSlot)
                                          ? slot.time
                                          : "";
                                    });
                                  },
                                  isSelected: selectedSlot
                                          .contains(state.slots[index].idSlot)
                                      ? true
                                      : false,
                                  slotDomain: slot,
                                  chosenDate: chosenDate,
                                );
                              }),
                            ).paddingSymmetric(horizontal: 24),
                          ],
                        ).sliver;
                      }
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: SizedBox(
                          height: 30,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: context.color.tertiary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25).sliver,
                  ReservationForm(
                    questId: widget.questId,
                    selectedSlot: selectedSlot,
                    chosenDate: chosenDate,
                    showNotification: showNotification(),
                  ).sliver,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
