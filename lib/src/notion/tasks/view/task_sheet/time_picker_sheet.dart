import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/task.dart';
import '../../time_sheet_viewmodel.dart';
import 'duration_picker.dart';

class TimePickerSheet extends StatelessWidget {
  final TaskDate? initialDate;
  final Function(TaskDate?) onSelected;
  final GlobalKey _startTimeKey = GlobalKey();
  final GlobalKey _durationKey = GlobalKey();
  final TimeSheetViewModel _viewModel;

  static const durations = [
    Duration(minutes: 30),
    Duration(minutes: 60),
    Duration(minutes: 120),
    Duration(minutes: 240),
    Duration(minutes: 480),
  ];

  TimePickerSheet({
    super.key,
    required this.initialDate,
    required this.onSelected,
  }) : _viewModel = TimeSheetViewModel(initialDateTime: initialDate);

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
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          onSelected(_viewModel.selectedDateTime);
                        },
                        child: const Text('決定',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('開始時間'),
                      const Spacer(),
                      InputChip(
                        key: _startTimeKey,
                        label: Text(
                          _viewModel.selectedDateTime?.start.isAllDay != true
                              ? '${_viewModel.selectedStartDateTime!.hour}:${_viewModel.selectedStartDateTime!.minute.toString().padLeft(2, '0')}'
                              : '指定なし',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onPressed: () {
                          _showTimePickerDialog(
                            context: context,
                            key: _startTimeKey,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              initialDateTime:
                                  _viewModel.selectedStartDateTime ??
                                      DateTime.now(),
                              onDateTimeChanged:
                                  _viewModel.handleStartTimeSelected,
                            ),
                          );
                        },
                        onDeleted:
                            _viewModel.selectedDateTime?.start.isAllDay != true
                                ? _viewModel.clearStartTime
                                : null,
                        deleteIcon: const Icon(Icons.close_rounded, size: 16),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  if (_viewModel.selectedStartDateTime != null)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('期間'),
                            const Spacer(),
                            InputChip(
                              key: _durationKey,
                              label: Text(
                                (_viewModel.currentDuration != null)
                                    ? '${_viewModel.currentDuration!.inHours}:${(_viewModel.currentDuration!.inMinutes % 60).toString().padLeft(2, '0')}'
                                    : '指定なし',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                              onPressed: () {
                                _showTimePickerDialog(
                                  context: context,
                                  key: _durationKey,
                                  child: DurationPicker(
                                    initialDuration: _viewModel.currentDuration,
                                    onDurationChanged:
                                        _viewModel.handleDurationSelected,
                                  ),
                                );
                              },
                              onDeleted: _viewModel.currentDuration != null
                                  ? () => _viewModel.clearDuration()
                                  : null,
                              deleteIcon:
                                  const Icon(Icons.close_rounded, size: 16),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
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
