import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/imagePath/image_common.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum HHImageType { network, local, asset, none }

// ignore: must_be_immutable
class HHImage extends StatelessWidget {
  /// 通用型图片
  HHImage({
    Key? key,
    required imageUrl,
    this.placeholder,
    this.placeholderError,
    this.fit,
    this.alignment,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.fadeInDuration,
    this.fadeInCurve,
    this.fadeOutDuration,
    this.fadeOutCurve,
    this.circularRadius,
    this.isAllShape,
    this.circularBottomLeft,
    this.circularBottomRight,
    this.circularTopLeft,
    this.circularTopRight,
    this.borderWidth,
    this.borderColor,
    this.imageColor,
    this.boxShadows,
    double? cacheWidth,
    double? cacheHeight,
    this.options,
  })  : _placeholderColor =
            Theme.of(currentContext).colorScheme.onPrimaryContainer,
        _medalUrl = null,
        _cacheWidth = cacheWidth?.floor(),
        _cacheHeight = cacheHeight?.floor(),
        _url = imageUrl ?? '',
        super(key: key);

  /// 头像类图片
  HHImage.avatar({
    Key? key,
    required imageUrl,
    String? medalUrl,
    this.fit = BoxFit.cover,
    this.alignment,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.fadeInDuration,
    this.fadeInCurve,
    this.fadeOutDuration,
    this.fadeOutCurve,
    double? circularRadius,
    this.borderWidth,
    this.borderColor,
    this.imageColor,
    this.boxShadows,
    double? cacheWidth,
    double? cacheHeight,
    this.options,
    this.isAllShape,
    this.circularTopLeft,
    this.circularTopRight,
    this.circularBottomLeft,
    this.circularBottomRight,
  })  : placeholder = ImagePathCommon.placeholderAvatar,
        placeholderError = ImagePathCommon.placeholderAvatarError,
        _placeholderColor =
            Theme.of(currentContext).colorScheme.onPrimaryContainer,
        _medalUrl = medalUrl,
        circularRadius = circularRadius ?? (width ?? height ?? 0) / 2,
        _cacheWidth = cacheWidth?.floor(),
        _cacheHeight = cacheHeight?.floor(),
        _url = imageUrl ?? '',
        super(key: key);

  /// 占位图 默认通用占位图
  final String? placeholder;

  /// 加载失败占位图 默认通用失败图
  final String? placeholderError;

  /// 填充方式 默认为BoxFit.contain
  final BoxFit? fit;

  /// 宽
  final double? width;

  /// 高
  final double? height;

  /// 内边距
  final EdgeInsets? padding;

  /// 外边距
  final EdgeInsets? margin;

  /// 淡入动画时间 默认300毫秒
  final Duration? fadeInDuration;

  /// 淡入动画效果 默认Curves.easeIn
  final Curve? fadeInCurve;

  /// 淡出动画时间 默认300毫秒
  final Duration? fadeOutDuration;

  /// 淡出动画效果 默认Curves.easeOut
  final Curve? fadeOutCurve;

  /// 圆角
  final double? circularRadius;

  ///圆角的值是否用同一个
  final bool? isAllShape;

  /// 圆角
  final double? circularTopLeft;

  /// 圆角
  final double? circularTopRight;

  /// 圆角
  final double? circularBottomLeft;

  /// 圆角
  final double? circularBottomRight;

  /// 边框
  final double? borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 阴影
  final List<BoxShadow>? boxShadows;

  /// 占位图背景颜色
  final Color? _placeholderColor;

  /// 占位图背景颜色
  final Color? imageColor;

  /// 勋章图片地址 仅avatar生效
  final String? _medalUrl;

  /// 对齐方式
  final Alignment? alignment;

  /// 图片裁剪参数 华为云专用
  final HHImagePotions? options;

  /// 内存中的宽度
  int? _cacheWidth;

  /// 内存中的高度
  int? _cacheHeight;

  /// 图片链接
  String _url;

  late String tempUrl = '';

  late Widget _tempWidget = Container();

  @override
  Widget build(BuildContext context) {
    ///增加缓存，如果有直接返回缓存image
    if (tempUrl.isNotEmpty) {
      return _tempWidget;
    }
    // 获取图片类型
    final imageType = getImageType(_url);
    tempUrl = _url;

    // 处理微信图片
    if (_url.contains('thirdwx.qlogo.cn') == true) {
      _url = _url.replaceFirst('thirdwx.qlogo.cn', 'wx.qlogo.cn');
    }

    Widget widget;

    switch (imageType) {
      case HHImageType.network: // 网络图片
        {
          // 处理图片
          if (Platform.isAndroid) {
            setCacheSize(context);
          }
          widget = CachedNetworkImage(
            imageUrl: _url,
            placeholder: (context, url) => _placeholderWidget(),
            width: width,
            height: height,
            color: imageColor,
            // memCacheWidth: _cacheWidth,
            // memCacheHeight: _cacheHeight,
            // maxWidthDiskCache: _cacheWidth,
            // maxHeightDiskCache: _cacheHeight,
            fit: _url.isNotEmpty ? (fit ?? BoxFit.contain) : BoxFit.cover,
            fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
            fadeInCurve: fadeInCurve ?? Curves.easeIn,
            fadeOutDuration:
                fadeOutDuration ?? const Duration(milliseconds: 300),
            fadeOutCurve: fadeOutCurve ?? Curves.easeOut,
            errorWidget: (context, error, stackTrace) =>
                _placeholderWidget(isErr: true),
            alignment: alignment ?? Alignment.center,
          );
        }
        break;
      case HHImageType.asset: // 本地图片
        {
          widget = Image.asset(
            _url,
            width: width,
            height: height,
            color: imageColor,
            fit: fit ?? BoxFit.cover,
            alignment: alignment ?? Alignment.center,
          );
        }
        break;
      case HHImageType.local: // 沙盒图片
        {
          widget = Image.file(
            File(_url),
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            color: _placeholderColor,
            errorBuilder: (_, __, ___) => _placeholderWidget(),
            alignment: alignment ?? Alignment.center,
          );
        }
        break;
      case HHImageType.none: // 空地址
        {
          widget = _placeholderWidget(isErr: true);
        }
        break;
    }

    // 图片添加圆角
    if ((circularRadius != null && circularRadius! > 0) ||
        !(isAllShape ?? true)) {
      widget = ClipRRect(
        borderRadius: isAllShape ?? true
            ? BorderRadius.all(Radius.circular(circularRadius ?? 0.0))
            : BorderRadius.only(
                topLeft: Radius.circular(circularTopLeft ?? 0.0),
                topRight: Radius.circular(circularTopRight ?? 0.0),
                bottomLeft: Radius.circular(circularBottomLeft ?? 0.0),
                bottomRight: Radius.circular(circularBottomRight ?? 0.0)),
        child: widget,
      );
    }

    // 添加勋章 （属于业务需求，后续再抽出来）
    if (_medalUrl?.isNotEmpty == true) {
      widget = Stack(children: [
        Container(margin: const EdgeInsets.fromLTRB(0, 0, 1, 1), child: widget),
        Positioned(
            right: 0,
            bottom: 0,
            width: (width ?? 42) / 42 * 16,
            height: (width ?? 42) / 42 * 16,
            child: CachedNetworkImage(imageUrl: _medalUrl!, fit: BoxFit.cover))
      ]);
    }

    //     _tempWidget = Container(
    //   padding: padding,
    //   margin: margin,
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color: borderColor ?? Colors.transparent,
    //       width: borderWidth ?? 0,
    //       style: BorderStyle.solid,
    //     ),
    //     color: _url.isNotEmpty ? Colors.transparent : _placeholderColor,
    //     borderRadius:  BorderRadius.circular(circularRadius ?? 0),
    //     boxShadow: boxShadows,
    //   ),
    //   child: widget,
    // );
    // return _tempWidget;

    _tempWidget = Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
          style: BorderStyle.solid,
        ),
        color: _url.isNotEmpty ? Colors.transparent : _placeholderColor,
        borderRadius: isAllShape ?? true
            ? BorderRadius.all(Radius.circular(circularRadius ?? 0.0))
            : BorderRadius.only(
                topLeft: Radius.circular(circularTopLeft ?? 0.0),
                topRight: Radius.circular(circularTopRight ?? 0.0),
                bottomLeft: Radius.circular(circularBottomLeft ?? 0.0),
                bottomRight: Radius.circular(circularBottomRight ?? 0.0)),
        boxShadow: boxShadows,
      ),
      child: widget,
    );
    return _tempWidget;
  }

  Widget _placeholderWidget({bool isErr = false}) {
    return Container(
      color: _placeholderColor,
      child: Image.asset(
        isErr ? placeholderError ?? '' : placeholder ?? '',
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 指定图片缓存宽高
  /// 控制内存、缓存中的图片大小、防止图片过大导致的crash
  setCacheSize(BuildContext context) {
    double scale = MediaQuery.of(context).devicePixelRatio;
    _cacheWidth ??= (width != null ? (width!).floor() : null);
    _cacheHeight ??= (height != null ? (height!).floor() : null);
    if (_cacheWidth != null) {
      _cacheWidth = (_cacheWidth! * scale).floor();
    }

    if (_cacheHeight != null) {
      _cacheHeight = (_cacheHeight! * scale).floor();
    }

    // 指定华为云下载图片宽高
    setDownloadSize();
  }

  /// 指定华为云下载图片宽高
  /// 放置图片过大浪费资源
  setDownloadSize() {
    // 处理华为云图片 && 视频第一帧图除外
    if (_url.contains('myhuaweicloud.com/') && !_url.contains('?vframe/')) {
      RegExp regex = RegExp(r'(\?x-image-process=image/resize).*');
      _url = _url.replaceAll(regex, '');
      _url = '$_url?x-image-process=image/resize,m_lfit,'
          '${options?.imageRule ?? getImageRule(_cacheWidth, _cacheHeight)}'
          '${options?.imageSize ?? getImageSize(_cacheWidth, _cacheHeight)}';

      // 已经处理原图，清空缓存size减少性能消耗
      _cacheWidth = null;
      _cacheHeight = null;
    }
  }

  /// 图片裁剪的大小
  /// 宽高皆为null，则默认：屏宽 * 2
  int getImageSize(int? width, int? height) {
    return width ?? height ?? (1.sw * 2).floor();
  }

  ///  裁剪图片策略
  ///  w: 指定宽度，高度自适应
  ///  h: 指定高度，宽度自适应
  String getImageRule(int? width, int? height) {
    return width != null
        ? HHImageRule.w
        : height != null
            ? HHImageRule.w
            : HHImageRule.w;
  }

  /// 图片类型
  static HHImageType getImageType(String url) {
    if (url.startsWith('http')) return HHImageType.network;
    if (url.startsWith('https')) return HHImageType.network;
    if (url.startsWith('assets')) return HHImageType.asset;
    if (url.isNotEmpty) return HHImageType.local;
    return HHImageType.none;
  }
}

/// 图片裁剪规则
class HHImageRule {
  static const String w = 'w_';
  static const String h = 'h_';
}

/// 图片裁剪参数
class HHImagePotions {
  HHImagePotions({
    this.imageSize,
    this.imageRule,
  });

  /// 图片大小
  int? imageSize;

  /// 图片比例侧策略
  String? imageRule;
}
