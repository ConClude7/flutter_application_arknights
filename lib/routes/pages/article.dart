import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/shared.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/myToast.dart';
import 'package:http_multi_server/http_multi_server.dart';
import 'package:flutter_particles/particles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:particles_flutter/particles_flutter.dart';
import '../../widgets/lineBackground.dart';

class articlePage extends StatefulWidget {
  const articlePage({super.key});

  @override
  State<articlePage> createState() => _articlePageState();
}

class _articlePageState extends State<articlePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final imageController = MultiImagePickerController(
      maxImages: 9,
      withData: true,
      allowedImageTypes: ['png', 'jpg', 'jpeg', 'gif'],
      images: <ImageFile>[]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "编辑文章",
            style: TextStyle(color: Color.fromARGB(255, 229, 229, 229)),
          ),
          leading: IconButton(
              color: const Color.fromARGB(255, 229, 229, 229),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          actions: [
            GFButton(
              onPressed: () async {
                upLoadImage(context, imageController);
              },
              text: "发表",
              type: GFButtonType.transparent,
              textStyle: TextStyle(
                  color: const Color.fromARGB(255, 252, 163, 17),
                  fontSize: 18.sp),
            )
          ],
          flexibleSpace: appBarBackground(context),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 52, 52, 52),
          child: CustomPaint(
              painter: BackgroundPainter(),
              child: body(context, formKey, titleController, contentController,
                  imageController)),
        ));
  }
}

// 图片上传
Future<void> upLoadImage(
    BuildContext context, MultiImagePickerController imageController) async {
  FormData formData = FormData();
  List<MultipartFile> imagesFiles = [];
  final getImages = imageController.images;

  List<String> imageNames = [];
  for (ImageFile image in getImages) {
    if (image.hasPath) {
      Uint8List byteData = image.bytes!;
      imageNames.add(image.name);
      imagesFiles.add(MultipartFile.fromBytes(byteData, filename: image.name));
    }
  }

  List<String> nameSet = imageNames.toSet().toList();
  print(nameSet);

  if (nameSet.length == getImages.length) {
    List<MapEntry<String, MultipartFile>> formDataFiles = List.generate(
        imagesFiles.length, (index) => MapEntry("images", imagesFiles[index]));
    formData.files.addAll(formDataFiles);
    try {
      final response = await DartHttpUtils()
          .postFileDio("/api/articles/images", formData, context);
      // ignore: avoid_print
      print(response);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  } else {
    myToast.warning(context, "请勿上传重复的图片", null);
  }
}

Widget appBarBackground(BuildContext context) {
  return CircularParticle(
    key: UniqueKey(),
    awayRadius: 10,
    numberOfParticles: 15,
    speedOfParticles: 2,
    height: 100.sp,
    width: MediaQuery.of(context).size.width,
    onTapAnimation: false,
    maxParticleSize: 3,
    isRandSize: true,
    isRandomColor: true,
    randColorList: const [
      Color.fromARGB(20, 255, 255, 255),
      Color.fromARGB(20, 0, 0, 0),
      Color.fromARGB(50, 0, 0, 0)
    ],
    awayAnimationCurve: Curves.fastOutSlowIn,
    awayAnimationDuration: const Duration(milliseconds: 1000),
    enableHover: false,
    hoverColor: Colors.white,
    hoverRadius: 0,
    particleColor: const Color.fromARGB(10, 255, 255, 255),
    connectDots: true, //not recommended
  );
}

Widget body(BuildContext context, formKey, titleController, contentController,
    imageController) {
  Color fontColor = const Color.fromARGB(255, 229, 229, 229);
  Color errorColor = const Color.fromARGB(200, 252, 163, 17);
  Color iconColor = const Color.fromARGB(150, 229, 229, 229);

  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
    child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(color: fontColor),
              cursorColor: fontColor,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: fontColor),
                  hintStyle: TextStyle(color: iconColor),
                  errorStyle: TextStyle(color: errorColor),
                  labelText: "标题",
                  hintText: "请输入完整文章标题（5-30字）",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: iconColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: iconColor)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: errorColor)),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: errorColor)),
                  icon: Icon(
                    Icons.title,
                    color: iconColor,
                  )),
              obscureText: false,
              validator: (value) {
                return (value!.trim().length > 4 && value.trim().length < 31)
                    ? null
                    : "标题字数不符合要求（5-30字）";
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 350.sp,
              child: TextFormField(
                controller: contentController,
                maxLines: null,
                maxLength: 800,
                style: TextStyle(color: fontColor),
                cursorColor: fontColor,
                decoration: InputDecoration(
                    filled: false,
                    fillColor: const Color.fromARGB(10, 0, 0, 0),
                    labelStyle: TextStyle(color: fontColor),
                    hintStyle: TextStyle(color: iconColor),
                    errorStyle: TextStyle(color: errorColor),
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
                  return value!.trim().length > 9 ? null : "正文不得少于10字";
                },
              ),
            ),
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
                  stops: [0.1, 0.3, 0.7, 0.9], // 渐变颜色的分割点
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 352.sp,
              margin: EdgeInsets.only(top: 5.sp),
              child: MultiImagePickerView(
                controller: imageController,
                initialContainerBuilder: (context, pickerCallback) {
                  return GestureDetector(
                    onTap: pickerCallback,
                    child: Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(20, 255, 255, 255),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: iconColor,
                          size: 60.sp,
                        )),
                  );
                },
                addMoreBuilder: (context, pickerCallback) {
                  return GestureDetector(
                    onTap: pickerCallback,
                    child: Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(20, 255, 255, 255),
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: fontColor,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold),
                        )),
                  );
                },
              ),
            )
          ],
        )),
  );
}
