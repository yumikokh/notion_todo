import 'package:flutter/material.dart';

/// InputChipの共通ウィジェット
/// DateChipとPriorityChipで使用される共通の構造を提供
class BaseInputChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final void Function(bool) onSelected;
  final void Function()? onDeleted;
  final Widget? avatar;
  final Widget? deleteIcon;
  final bool showCheckmark;
  final EdgeInsetsGeometry? labelPadding;
  final VisualDensity? visualDensity;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final Color? backgroundColor;
  final Color? selectedColor;

  const BaseInputChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.onDeleted,
    this.avatar,
    this.deleteIcon,
    this.showCheckmark = false,
    this.labelPadding,
    this.visualDensity,
    this.shape,
    this.side,
    this.backgroundColor,
    this.selectedColor,
  });

  factory BaseInputChip.standard({
    Key? key,
    required Widget label,
    required bool selected,
    required void Function(bool) onSelected,
    void Function()? onDeleted,
    Widget? avatar,
    EdgeInsetsGeometry? labelPadding,
    required BuildContext context,
  }) {
    return BaseInputChip(
      key: key,
      label: label,
      selected: selected,
      onSelected: onSelected,
      onDeleted: onDeleted,
      avatar: avatar,
      deleteIcon: Icon(
        Icons.clear,
        size: 14,
        color: Theme.of(context).disabledColor,
      ),
      showCheckmark: false,
      labelPadding: labelPadding ?? const EdgeInsets.symmetric(horizontal: 6),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      backgroundColor: Theme.of(context).cardColor,
      selectedColor: Theme.of(context).cardColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: label,
      selected: selected,
      onSelected: onSelected,
      onDeleted: onDeleted,
      avatar: avatar,
      deleteIcon: deleteIcon,
      showCheckmark: showCheckmark,
      labelPadding: labelPadding,
      visualDensity: visualDensity,
      shape: shape,
      side: side,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
    );
  }
}