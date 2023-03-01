import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/app/components/responsive.dart';
import 'package:front/app/model/service.dart';
import 'package:front/colors.dart';
import 'package:front/constants.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/home_controller.dart';
import '../controllers/http_loader.dart';

class ServicesField extends GetView<HomeController> {
  final pageController = PageController(viewportFraction: 1, keepPage: true);

  ServicesField({super.key});

  Widget _render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.caption!.copyWith(
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
              child: Obx(() {
                return Row(
                  children: controller.services
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ServiceFieldComponent(info: e),
                        ),
                      )
                      .toList(),
                );
              }),
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
          style: Theme.of(context).textTheme.caption!.copyWith(
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
              child: Obx(() {
                return PageView.builder(
                  itemCount: controller.services.length,
                  controller: pageController,

                  // itemCount: pages.length,
                  itemBuilder: (_, idx) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child:
                          ServiceFieldComponent(info: controller.services[idx]),
                    );
                  },
                );
              }),
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

class ServiceFieldComponent extends StatelessWidget {
  final Service info;
  const ServiceFieldComponent({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 200,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(
                  '${info.numOfCtrls} devices',
                  style: Theme.of(context).textTheme.caption!.copyWith(
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
                      : const Icon(
                          Icons.check_circle_outline,
                          size: 30,
                          color: Colors.green,
                        ),
                  IconButton(
                      icon: Icon(
                        size: 24,
                        info.id == ''
                            ? Icons.download_outlined
                            : Icons.delete_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (info.id == '') installSvc(info);
                      }),
                ],
              ),
            ],
          ),
          Text(
            info.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
          TextButton(
            child: Text(
              info.id!,
              maxLines: 1,
              // overflow: ,
            ),
            onPressed: () {
              if (info.status != "enabled") {
                Get.snackbar("Failed", "Service is not working");
                return;
              }
              launchUrlString("http://$serverAddr/svc/${info.id}");
            },
          )
        ],
      ),
    );
  }
}
