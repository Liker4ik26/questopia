import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/card_image.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/extensions/widget_extensions.dart';
import 'package:questopia/features/reserved_quest/bloc/delete/delete_bloc.dart';
import 'package:questopia/features/reserved_quest/widgets/alert_dialog_widget.dart';

import '../../../core/repositories/reserved_quest/data/reserved_quest_repository.dart';
import '../../../core/repositories/reserved_quest/domain/reserved_quest.dart';
import '../../reservations/widgets/time_container.dart';

class ReservedQuestCard extends StatelessWidget {
  const ReservedQuestCard(
      {super.key, required this.onTap, required this.questDomain});

  final void Function() onTap;
  final ReservedSlotsQuestDomain questDomain;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(questDomain.idSlot.date);
    String formattedDate = DateFormat('dd MMMM', 'ru').format(date);

    final slotNoActive = DateTime.now().isAfter(
      DateTime(
          int.parse(questDomain.idSlot.date.split('-')[0]),
          int.parse(questDomain.idSlot.date.split('-')[1]),
          int.parse(questDomain.idSlot.date.split('-')[2]),
          int.parse(questDomain.idSlot.time.split(':')[0]),
          int.parse(questDomain.idSlot.time.split(':')[1]),
          int.parse(questDomain.idSlot.time.split(':')[2])),
    );
    return Container(
      decoration: BoxDecoration(
        color: context.color.onSecondary,
        borderRadius: BorderRadius.circular(
          AppDimensions.extraMedium,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CardImage(
                imageUrl: questDomain.idSlot.idQuest.photos.first,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(AppDimensions.extraMedium),
              ),
              const SizedBox(width: 9),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questDomain.idSlot.idQuest.name,
                    style: context.text.rfDewiSemiBold16,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$formattedDate в ${convertTimeFormat(questDomain.idSlot.time)}',
                    style: context.text.rfDewiSemiBold14.copyWith(
                      color: context.color.primary.withOpacity(.4),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 16, left: 16),
          const SizedBox(height: 14),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Статус',
              style: context.text.rfDewiRegular14.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ),
            trailing: Text(
              slotNoActive == false
                  ? questDomain.idSlot.status == true
                      ? 'Забронирован'
                      : 'Отменен'
                  : 'Прошел',
              style: context.text.rfDewiRegular14,
            ),
          ),
          Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 96,
            dashColor: context.color.primary.withOpacity(.4),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Кол-во человек',
              style: context.text.rfDewiRegular14.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ),
            trailing: Text(
              questDomain.countPlayer.toString(),
              style: context.text.rfDewiRegular14,
            ),
          ),
          Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 96,
            dashColor: context.color.primary.withOpacity(.4),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Телефон',
              style: context.text.rfDewiRegular14.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ),
            trailing: Text(
              questDomain.phone,
              style: context.text.rfDewiRegular14,
            ),
          ),
          Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 96,
            dashColor: context.color.primary.withOpacity(.4),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Цена',
              style: context.text.rfDewiRegular14.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ),
            trailing: Text(
              '${questDomain.price} ₽',
              style: context.text.rfDewiRegular14,
            ),
          ),
          questDomain.idSlot.status == false || slotNoActive
              ? const SizedBox()
              : CustomButton(
                  bgColor: context.color.primary.withOpacity(.08),
                  title: 'Отменить',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext contextInner) {
                        return BlocProvider(
                          create: (context) => DeleteBloc(
                              reservedQuestRepository:
                                  context.read<ReservedQuestRepository>()),
                          child: AlertDialogWidget(
                            reservedSlotsQuestDomain: questDomain,
                            onPressed: () {
                              context.read<DeleteBloc>().add(
                                    DeleteReservedQuestEvent(
                                        reservedQuest: questDomain),
                                  );
                              contextInner.pop();
                            },
                          ),
                        );
                      },
                    );
                  },
                ).paddingAll(16),
        ],
      ),
    );
  }
}
