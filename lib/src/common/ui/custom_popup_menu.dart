import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// カスタムポップアップメニュー項目の定義
class CustomPopupMenuItem {
  final String id;
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback onTap;

  CustomPopupMenuItem({
    required this.id,
    required this.title,
    this.leading,
    this.trailing,
    required this.onTap,
  });
}

/// カスタムポップアップメニューを表示するためのフック
/// 使用例:
/// ```dart
/// final customMenu = useCustomPopupMenu(
///   items: [
///     CustomPopupMenuItem(
///       id: 'toggle',
///       title: Text('表示切替'),
///       trailing: isVisible ? Icon(Icons.check) : null,
///       onTap: () => toggleVisibility(),
///     ),
///   ],
/// );
///
/// // 使用箇所
/// IconButton(
///   key: customMenu.buttonKey,
///   icon: const Icon(Icons.more_horiz),
///   onPressed: customMenu.toggle,
/// )
/// ```
CustomPopupMenuController useCustomPopupMenu({
  required List<CustomPopupMenuItem> items,
  Offset offset = const Offset(0, 0),
  Duration animationDuration = const Duration(milliseconds: 30),
  Curve animationCurve = Curves.easeOut,
  Color? backgroundColor,
  Color? shadowColor,
  double elevation = 12,
}) {
  final context = useContext();
  final overlayEntry = useState<OverlayEntry?>(null);
  final isMenuOpen = useState(false);
  final buttonKey = useRef(GlobalKey());
  final isDisposed = useRef(false);

  // 画面から離れたときのクリーンアップ
  useEffect(() {
    return () {
      isDisposed.value = true;
      overlayEntry.value?.remove();
      overlayEntry.value = null;
    };
  }, const []);

  // オーバーレイを削除する関数
  void removeOverlay() {
    if (isDisposed.value) return;
    overlayEntry.value?.remove();
    overlayEntry.value = null;
    isMenuOpen.value = false;
  }

  // メニューを表示する
  void showMenu() {
    final RenderBox? renderBox =
        buttonKey.value.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    removeOverlay();

    final entry = OverlayEntry(
      builder: (overlayContext) => TweenAnimationBuilder<double>(
        duration: animationDuration,
        curve: animationCurve,
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Stack(
            children: [
              // 背景部分（タップすると閉じる）
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: removeOverlay,
                child: Container(color: Colors.transparent),
              ),
              // メニュー部分
              Positioned(
                top: position.dy + size.height + offset.dy,
                right: 10 + offset.dx,
                width: 240,
                child: Material(
                  elevation: elevation,
                  shadowColor: shadowColor ??
                      Theme.of(context).colorScheme.shadow.withAlpha(80),
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  color:
                      backgroundColor ?? Theme.of(context).colorScheme.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: items
                        .map((item) => InkWell(
                              onTap: () {
                                item.onTap();
                                removeOverlay();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                child: Row(
                                  children: [
                                    if (item.leading != null) ...[
                                      item.leading!,
                                      const SizedBox(width: 12),
                                    ],
                                    Expanded(child: item.title),
                                    if (item.trailing != null) item.trailing!,
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    overlayEntry.value = entry;
    Overlay.of(context).insert(entry);
    isMenuOpen.value = true;
  }

  // メニューの表示/非表示を切り替える
  void toggleMenu() {
    if (isMenuOpen.value) {
      removeOverlay();
    } else {
      showMenu();
    }
  }

  return CustomPopupMenuController(
    buttonKey: buttonKey.value,
    isOpen: isMenuOpen.value,
    toggle: toggleMenu,
    show: showMenu,
    close: removeOverlay,
  );
}

/// カスタムポップアップメニューのコントローラー
class CustomPopupMenuController {
  final GlobalKey buttonKey;
  final bool isOpen;
  final VoidCallback toggle;
  final VoidCallback show;
  final VoidCallback close;

  CustomPopupMenuController({
    required this.buttonKey,
    required this.isOpen,
    required this.toggle,
    required this.show,
    required this.close,
  });
}
