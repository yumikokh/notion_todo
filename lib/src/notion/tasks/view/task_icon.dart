import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class TaskIcon extends StatelessWidget {
  const TaskIcon({
    super.key,
    required this.icon,
    this.size = 18,
    this.isProjectIcon = false,
  });

  final String icon;
  final double size;
  final bool isProjectIcon;

  bool _looksLikeUrl(String value) {
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool _isSvgUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return uri.path.toLowerCase().endsWith('.svg');
  }

  Widget _buildFallback() {
    if (!isProjectIcon) {
      return SizedBox(width: size, height: size);
    }
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text('#', style: TextStyle(fontSize: size - 2, height: 1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_looksLikeUrl(icon)) {
      final fallback = _buildFallback();

      // SVG URL の場合はキャッシュ付きで読み込み
      if (_isSvgUrl(icon)) {
        return SizedBox(
          width: size,
          height: size,
          child: CachedNetworkSVGImage(
            icon,
            width: size,
            height: size,
            fit: BoxFit.contain,
            placeholder: fallback,
            errorWidget: fallback,
            fadeDuration: Duration.zero,
          ),
        );
      }

      // Notion の external icon URL を画像で表示（PNG, JPG等）
      return SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          imageUrl: icon,
          width: size,
          height: size,
          fit: BoxFit.contain,
          placeholder: (context, url) => fallback,
          errorWidget: (context, url, error) => fallback,
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
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
