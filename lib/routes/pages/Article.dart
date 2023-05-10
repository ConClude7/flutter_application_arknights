import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/common/appBar.dart';
import 'package:flutter_application_arknights/widgets/function/createColor.dart';
import 'package:flutter_application_arknights/widgets/common/myToast.dart';
import 'package:flutter_application_arknights/widgets/function/noScroll.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import '../../widgets/common/lineBackground.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Color fontColor = const Color.fromARGB(255, 229, 229, 229);
  Color errorColor = const Color.fromARGB(200, 252, 163, 17);
  Color iconColor = const Color.fromARGB(150, 229, 229, 229);
  double _progress = 0;
  final formKey = GlobalKey<FormState>();
  final tags = [];
  late String title;
  late String content;
  final imageController = MultiImagePickerController(
      maxImages: 9,
      withData: true,
      allowedImageTypes: ['png', 'jpg', 'jpeg', 'gif'],
      images: <ImageFile>[]);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Scaffold(
              appBar: appBar(context, "编辑文章", [
                GFButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await upLoadImage(context, imageController, formKey,
                          title, content, tags, (progress) {
                        print(progress);
                        setState(() {
                          _progress = progress;
                        });
                      });
                      // ignore: use_build_context_synchronously
                    }
                  },
                  text: "发表",
                  type: GFButtonType.transparent,
                  textStyle: TextStyle(
                      color: const Color.fromARGB(255, 252, 163, 17),
                      fontSize: 36.sp),
                )
              ]),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(255, 52, 52, 52),
                child: CustomPaint(
                    painter: BackgroundPainter(),
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
                        child: ScrollConfiguration(
                            behavior: NoScrollBehaviorWidget(),
                            child: ListView(
                              children: [
                                Form(
                                    key: formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextFormField(
                                          style: TextStyle(color: fontColor),
                                          cursorColor: fontColor,
                                          decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  color: fontColor),
                                              hintStyle: TextStyle(
                                                  color: iconColor),
                                              errorStyle: TextStyle(
                                                  color: errorColor),
                                              labelText: "标题",
                                              hintText: "请输入完整文章标题（5-30字）",
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: iconColor)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: iconColor)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: errorColor)),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: errorColor)),
                                              icon: Icon(
                                                Icons.title,
                                                color: iconColor,
                                              )),
                                          obscureText: false,
                                          validator: (value) {
                                            return (value!.trim().length > 4 &&
                                                    value.trim().length < 31)
                                                ? null
                                                : "标题字数不符合要求（5-30字）";
                                          },
                                          onSaved: (value) async {
                                            title = value!;
                                          },
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 800.sp,
                                          child: TextFormField(
                                            maxLines: null,
                                            maxLength: 800,
                                            style: TextStyle(color: fontColor),
                                            cursorColor: fontColor,
                                            decoration: InputDecoration(
                                                filled: false,
                                                fillColor: const Color.fromARGB(
                                                    10, 0, 0, 0),
                                                labelStyle:
                                                    TextStyle(color: fontColor),
                                                hintStyle:
                                                    TextStyle(color: iconColor),
                                                errorStyle: TextStyle(
                                                    color: errorColor),
                                                counterText: "",
                                                labelText: "正文",
                                                hintText: "您的文章内容",
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  Icons.content_copy,
                                                  color: iconColor,
                                                )),
                                            obscureText: false,
                                            validator: (value) {
                                              return value!.trim().length > 9
                                                  ? null
                                                  : "正文不得少于10字";
                                            },
                                            onSaved: (value) =>
                                                content = value!,
                                          ),
                                        ),
                                        SizedBox(
                                            width: double.infinity,
                                            child: Theme(
                                              data: ThemeData(
                                                  primarySwatch:
                                                      createMaterialColor(
                                                          Colors.white)),
                                              child: TagEditor(
                                                  icon: Icons.tag,
                                                  length: tags.length,
                                                  hasAddButton: true,
                                                  inputDecoration:
                                                      InputDecoration(
                                                    labelStyle: TextStyle(
                                                        color: fontColor),
                                                    hintStyle: TextStyle(
                                                        color: iconColor),
                                                    border: InputBorder.none,
                                                    hintText: '关键词',
                                                  ),
                                                  textStyle: TextStyle(
                                                      color: fontColor),
                                                  tagBuilder:
                                                      (context, index) => _Chip(
                                                          label: tags[index],
                                                          onDeleted: (index) {
                                                            setState(() {
                                                              tags.removeAt(
                                                                  index);
                                                            });
                                                          },
                                                          index: index),
                                                  onTagChanged: (value) {
                                                    setState(() {
                                                      tags.add(value);
                                                    });
                                                  }),
                                            )),
                                        Container(
                                          height: 1, // 线条高度
                                          width: double.infinity, // 屏幕宽度
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent, // 透明色
                                                Colors.white,
                                                Colors.white,
                                                Colors.transparent, // 透明色
                                              ],
                                              stops: [
                                                0.1,
                                                0.3,
                                                0.7,
                                                0.9
                                              ], // 渐变颜色的分割点
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: 5.sp),
                                          child: MultiImagePickerView(
                                            controller: imageController,
                                            initialContainerBuilder:
                                                (context, pickerCallback) {
                                              return GestureDetector(
                                                onTap: pickerCallback,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    color: const Color.fromARGB(
                                                        20, 255, 255, 255),
                                                    child: Icon(
                                                      Icons.add_photo_alternate,
                                                      color: iconColor,
                                                      size: 60.sp,
                                                    )),
                                              );
                                            },
                                            addMoreBuilder:
                                                (context, pickerCallback) {
                                              return GestureDetector(
                                                onTap: pickerCallback,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    color: const Color.fromARGB(
                                                        20, 255, 255, 255),
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: fontColor,
                                                          fontSize: 50.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            )))),
              )),
        ),
        (_progress == 0 || _progress == 1)
            ? const SizedBox.shrink()
            : Positioned(
                top: 400.sp,
                child: GFProgressBar(
                  width: 300.sp,
                  percentage: _progress,
                  lineHeight: 20,
                  alignment: MainAxisAlignment.center,
                  backgroundColor: Colors.black26,
                  progressBarColor: const Color.fromARGB(255, 252, 163, 17),
                  child: Text(
                    '${(_progress * 100).toStringAsFixed(2)}%',
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ))
      ],
    );
  }
}

// 图片上传
Future<void> upLoadImage(
    BuildContext context,
    MultiImagePickerController imageController,
    formKey,
    title,
    content,
    tags,
    Function(double) progressCallback) async {
  FormData formData = FormData();
  List<MultipartFile> imagesFiles = [];
  List<dynamic> getImageNames = [];
  final getImages = imageController.images;
  if (getImages.isNotEmpty) {
    List<String> imageNames = [];

    for (ImageFile image in getImages) {
      if (image.hasPath) {
        Uint8List byteData = image.bytes!;
        imageNames.add(image.name);
        imagesFiles
            .add(MultipartFile.fromBytes(byteData, filename: image.name));
      }
    }

    List<String> nameSet = imageNames.toSet().toList();
    if (nameSet.length == getImages.length) {
      List<MapEntry<String, MultipartFile>> formDataFiles = List.generate(
          imagesFiles.length,
          (index) => MapEntry("images", imagesFiles[index]));
      formData.files.addAll(formDataFiles);
      try {
        Map res = await DartHttpUtils().postFileDio("/api/articles/images",
            formData, context, (progress) => progressCallback(progress));
        getImageNames = await res['imageNames'];
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    } else {
      MyToast.warning(context, "请勿上传重复的图片", null);
    }
  } else {
    getImageNames = [];
  }

  /* print("title:$title");
  print("content:$content"); */
  // ignore: use_build_context_synchronously
  await upLoadArticle(context, formKey, title, content, tags, getImageNames);
}

Future<void> upLoadArticle(
    BuildContext context, formKey, title, content, tags, getImageNames) async {
  final res = await DartHttpUtils().postJsonDio(
      "/api/articles",
      {
        "title": title,
        "content": content,
        "keyWords": tags,
        "images": getImageNames
      },
      context);

  if (res['status'] == true) {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, "/myArticles");
    // ignore: use_build_context_synchronously
    MyToast.success(context, "上传成功", null);
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
