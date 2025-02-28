import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/task.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../time_sheet_viewmodel.dart';
import 'duration_picker.dart';

class TimePickerSheet extends StatelessWidget {
  final TaskDate? initialDate;
  final Function(TaskDate?) onSelected;
  final GlobalKey _startTimeKey = GlobalKey();
  final GlobalKey _durationKey = GlobalKey();
  final TimeSheetViewModel _viewModel;
  final AppLocalizations l10n;

  TimePickerSheet({
    super.key,
    required this.initialDate,
    required this.onSelected,
    required this.l10n,
  }) : _viewModel =
            TimeSheetViewModel(initialDateTime: initialDate, l10n: l10n);

  List<Duration> get durations => _viewModel.durations;

  void _showTimePickerDialog({
    required BuildContext context,
    required GlobalKey key,
    required Widget child,
  }) {
    final RenderBox? button =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) return;

    final buttonPosition = button.localToGlobal(Offset.zero);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, _) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuad,
        );

        return Stack(
          children: [
            Positioned(
              left: buttonPosition.dx - 80,
              bottom:
                  MediaQuery.of(context).size.height - buttonPosition.dy + 8,
              child: ScaleTransition(
                alignment: Alignment.bottomCenter,
                scale: curvedAnimation,
                child: FadeTransition(
                  opacity: curvedAnimation,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 160,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.5,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          onSelected(_viewModel.selectedDateTime);
                          HapticHelper.selection();
                        },
                        child: Text(l10n.save,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(l10n.start_time),
                      const Spacer(),
                      InputChip(
                        key: _startTimeKey,
                        label: Text(
                          _viewModel.startTimeLabel,
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onPressed: () {
                          HapticHelper.light();

                          if (_viewModel.selectedDateTime?.start.isAllDay ==
                              true) {
                            _viewModel.handleStartTimeSelected(
                                _viewModel.currentRoundTime);
                            return;
                          }

                          final initialDateTime =
                              _viewModel.selectedStartDateTime;
                          // 15分刻みに切り上げる
                          final roundedDateTime = initialDateTime != null
                              ? DateTime(
                                  initialDateTime.year,
                                  initialDateTime.month,
                                  initialDateTime.day,
                                  initialDateTime.hour,
                                  ((initialDateTime.minute + 14) ~/ 15) * 15,
                                )
                              : null;
                          if (roundedDateTime != null) {
                            _viewModel.handleStartTimeSelected(roundedDateTime);
                          }

                          _showTimePickerDialog(
                            context: context,
                            key: _startTimeKey,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              minuteInterval: 15,
                              initialDateTime: roundedDateTime,
                              onDateTimeChanged:
                                  _viewModel.handleStartTimeSelected,
                            ),
                          );
                        },
                        onDeleted:
                            _viewModel.selectedDateTime?.start.isAllDay != true
                                ? () {
                                    HapticHelper.light();
                                    _viewModel.clearStartTime();
                                  }
                                : null,
                        deleteIcon: const Icon(Icons.close_rounded, size: 16),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  if (_viewModel.selectedDateTime?.start.isAllDay != true)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(l10n.duration),
                            const Spacer(),
                            InputChip(
                              key: _durationKey,
                              label: Text(
                                _viewModel.durationLabel,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                              onPressed: () {
                                HapticHelper.light();
                                final duration = _viewModel.currentDuration;
                                const interval = 5;
                                // 5分間隔に丸める
                                final roundedDuration = duration != null
                                    ? Duration(
                                        hours: duration.inHours,
                                        minutes: ((duration.inMinutes % 60 +
                                                    (interval - 1)) ~/
                                                interval) *
                                            interval)
                                    : Duration.zero;

                                // 丸めた値で初期化
                                _viewModel
                                    .handleDurationSelected(roundedDuration);

                                _showTimePickerDialog(
                                  context: context,
                                  key: _durationKey,
                                  child: DurationPicker(
                                    initialDuration: roundedDuration,
                                    onDurationChanged: (duration) {
                                      _viewModel
                                          .handleDurationSelected(duration);
                                    },
                                    maxHours: 16,
                                    minuteInterval: interval,
                                  ),
                                );
                              },
                              onDeleted: _viewModel.currentDuration != null
                                  ? () {
                                      HapticHelper.light();
                                      _viewModel.clearDuration();
                                    }
                                  : null,
                              deleteIcon:
                                  const Icon(Icons.close_rounded, size: 16),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // duration候補ボタン
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (final duration in durations)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    selected:
                                        _viewModel.currentDuration == duration,
                                    onSelected: (selected) {
                                      if (selected) {
                                        HapticHelper.light();
                                        _viewModel
                                            .handleDurationSelected(duration);
                                      }
                                    },
                                    label: Text(
                                      _viewModel.durationLabels[_viewModel
                                          .durations
                                          .indexOf(duration)],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
