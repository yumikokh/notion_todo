import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskIcon extends StatelessWidget {
  const TaskIcon({super.key, required this.icon, this.size = 18});

  final String icon;
  final double size;

  bool _looksLikeUrl(String value) {
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool _isSvgUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return uri.path.toLowerCase().endsWith('.svg');
  }

  @override
  Widget build(BuildContext context) {
    if (_looksLikeUrl(icon)) {
      // SVG URL の場合は flutter_svg を使用
      if (_isSvgUrl(icon)) {
        return SizedBox(
          width: size,
          height: size,
          child: SvgPicture.network(
            icon,
            width: size,
            height: size,
            fit: BoxFit.contain,
            placeholderBuilder: (context) =>
                SizedBox(width: size, height: size),
          ),
        );
      }

      // Notion の external icon URL を画像で表示（PNG, JPG等）
      return SizedBox(
        width: size,
        height: size,
        child: Image.network(
          icon,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, _, __) => SizedBox(width: size, height: size),
        ),
      );
    }
    // 1文字絵文字などはテキストで表示
    // SizedBoxでラップして他のアイコンタイプと同じサイズを保証
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          icon,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: size - 2, height: 1),
        ),
      ),
    );
  }
}
