import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/app/components/responsive.dart';
import 'package:front/app/model/service_image.dart';
import 'package:front/app/modules/home/common/dialog.dart';
import 'package:front/colors.dart';
import 'package:front/constants.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/home_controller.dart';

class ServicesField extends GetView<HomeController> {
  final pageController = PageController(viewportFraction: 1, keepPage: true);

  ServicesField({super.key});

  Widget _render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () {
                  return Row(
                    children: [
                      ...controller.svcs.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ImageFieldComponent(
                            info: e,
                            onDeleted: controller.deleteService,
                          ),
                        ),
                      ),
                      _AddImageButton(onTap: () {
                        Future.delayed(const Duration(milliseconds: 160),
                            () async {
                          var result = await makeDialog(context);
                          controller.installService(result as String);
                        });
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _renderMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        const SizedBox(
          height: defaultPadding * 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 200,
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus
              }),
              child: Obx(
                () {
                  return PageView.builder(
                    itemCount: controller.svcs.length + 1,
                    controller: pageController,

                    // itemCount: pages.length,
                    itemBuilder: (_, idx) {
                      return idx == controller.svcs.length
                          ? _AddImageButton(
                              onTap: () {
                                print("Hello world");
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ImageFieldComponent(
                                info: controller.svcs[idx],
                                onDeleted: controller.deleteService,
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _render(context),
      tablet: _render(context),
      mobile: _renderMobile(context),
    );
  }
}

class _AddImageButton extends StatelessWidget {
  final void Function() onTap;
  const _AddImageButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      // Clip.hardEdge가 뭔지 조사해보기
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        focusColor: Colors.black,
        onTap: onTap,
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: secondaryColor.withAlpha(100),
            borderRadius: const BorderRadius.all(
              Radius.circular(80),
            ),
          ),
          child: const Icon(Icons.add, size: 120),
        ),
      ),
    );
  }
}

class ImageFieldComponent extends StatelessWidget {
  final ServiceImage info;
  final void Function(ServiceImage svc) onDeleted;
  const ImageFieldComponent(
      {super.key, required this.info, required this.onDeleted});

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                '0 containers',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info.status == 'disabled'
                    ? const Icon(
                        Icons.cancel_outlined,
                        size: 24,
                        color: Colors.red,
                      )
                    : info.status == 'installing'
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.lightBlue,
                            ),
                          )
                        : const Icon(
                            Icons.check_circle_outline,
                            size: 30,
                            color: Colors.green,
                          ),
                IconButton(
                    icon: Icon(
                      size: 24,
                      info.imageId == ''
                          ? Icons.download_outlined
                          : Icons.delete_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onDeleted(info);
                    }),
              ],
            ),
          ],
        ),
        Text(
          info.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        TextButton(
          child: Text(
            info.imageId!,
            maxLines: 1,
          ),
          onPressed: () {
            if (info.status != "enabled") {
              Get.snackbar("Failed", "Service is not working");
              return;
            }
            launchUrlString(
              "${Uri.base.scheme}://$serverAddr/svc/${info.imageId}",
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: info,
      feedback: Container(
        width: 300,
        height: 220,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor.withAlpha(100),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: _body(context),
      ),
      child: Container(
        width: 280,
        height: 200,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _body(context),
      ),
    );
  }
}
