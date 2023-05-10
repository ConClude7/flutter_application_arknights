import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> buttonText = ["报警求助", "取消行程", "行程分享", "联系客服"];
    final List<List<String>> payText = [
      ["订单总额", "59.00"],
      ["起步费", "15.00"],
      ["公里费", "62.00"],
      ["等待费", "52.00"]
    ];

    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                          flex: 10,
                          child: Container(
                            color: Colors.black26,
                            alignment: Alignment.center,
                            child: const Text("这是地图"),
                          )),
                      Expanded(
                          flex: 12,
                          child: Container(
                            width: double.infinity,
                            color: const Color.fromARGB(255, 193, 222, 245),
                            padding:
                                EdgeInsets.fromLTRB(10.sp, 14.sp, 10.sp, 19.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BlueContainer(
                                        height: 65.sp,
                                        margin: EdgeInsets.only(bottom: 18.sp),
                                        padding: EdgeInsets.only(left: 19.sp),
                                        alignment: Alignment.centerLeft,
                                        child: BlueText(
                                            text: "支付成功", fontSize: 24.sp)),
                                    BlueContainer(
                                      padding: EdgeInsets.fromLTRB(
                                          19.sp, 18.sp, 19.sp, 40.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(
                                            payText.length + 1, (index) {
                                          return index == 0
                                              ? Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      bottom: 11.sp),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: BlueText(
                                                    text: "30.00元",
                                                    fontSize: 24.sp,
                                                  ))
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    BlueText(
                                                        text: payText[index - 1]
                                                            .first),
                                                    BlueText(
                                                        text: payText[index - 1]
                                                            .last)
                                                  ],
                                                );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 56.sp,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 8, 79, 123),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.sp))),
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 140, 203, 244),
                                          fontSize: 14.sp),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            buttonText.length, (index) {
                                          return Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                  child: Container(
                                                height: double.infinity,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2.sp),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  buttonText[index],
                                                ),
                                              )));
                                        }),
                                      ),
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Positioned(
                    top: 30.sp,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                                width: 34.sp,
                                height: 34.sp,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 8, 79, 123),
                                    borderRadius: BorderRadius.circular(24.sp)),
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi),
                                  child: Icon(
                                    Icons.sms_outlined,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}

class BlueContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final Alignment? alignment;

  const BlueContainer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.alignment,
    this.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(79, 178, 178, 178),
                offset: Offset(7.sp, 7.sp),
                blurRadius: 15.sp,
                spreadRadius: 1.sp)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 188, 221, 246),
                Color.fromARGB(255, 237, 244, 251)
              ])),
      child: child,
    );
  }
}

class BlueText extends StatelessWidget {
  final String text;
  final double? fontSize;
  const BlueText({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: const Color.fromARGB(255, 8, 79, 123),
          fontSize: fontSize ?? 14.sp),
    );
  }
}
