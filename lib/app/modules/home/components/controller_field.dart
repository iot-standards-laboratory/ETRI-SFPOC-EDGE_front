import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/app/components/responsive.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/modules/home/controllers/home_controller.dart';
import 'package:front/colors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../model/service_image.dart';

class ControllerField extends GetView<HomeController> {
  const ControllerField({super.key});

  Widget _render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Controllers',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.ctrls
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _controllerComponent(context, e),
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
          'Controllers',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: controller.ctrls
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _controllerComponent(context, e),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
        )
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

// class AgentFieldComponent extends StatelessWidget {
//   final Agent agent;
//   const AgentFieldComponent({super.key, required this.agent});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// Widget _render(BuildContext context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Text(
//         'Agents',
//         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//               color: Colors.white,
//               fontSize: 20,
//             ),
//       ),
//       const SizedBox(height: defaultPadding),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Container(
//           padding: const EdgeInsets.all(defaultPadding),
//           decoration: const BoxDecoration(
//             color: secondaryColor,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Obx(
//             () {
//               return DataTable(
//                 columns: [
//                   DataColumn(
//                     label: Text(
//                       'Name',
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'ID',
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'Status',
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                     ),
//                   ),
//                 ],
//                 rows: List<DataRow>.generate(controller.agents.length,
//                     (idx) => _agentRow(controller.agents[idx])),
//               );
//             },
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget _makeRichText(BuildContext context, String key, String value) {
  return RichText(
    text: TextSpan(
      text: key,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                // fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
        ),
      ],
    ),
  );
}

Widget _controllerComponent(BuildContext context, Controller agent) {
  return DragTarget(
    onAcceptWithDetails: (data) {
      HomeController.to.registerService(
        (data.data as ServiceImage).id,
        agent.id,
      );
      // print((data.data as ServiceImage).id);
    },
    builder: (context, candidateData, rejectedData) => Container(
      decoration: candidateData.isEmpty
          ? const BoxDecoration()
          : BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.red,
              ),
            ),
      child: Container(
        width: Responsive.isMobile(context) ? 320 : 520,
        // height: height,
        padding: const EdgeInsets.all(defaultPadding * 2),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _makeRichText(context, "Name : ", agent.name),
            const SizedBox(height: 16),
            !Responsive.isMobile(context)
                ? _makeRichText(context, "ID : ", agent.id)
                : Text(
                    agent.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 16),
            Text(
              agent.status ? "Connected" : "Disconnected",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: agent.status ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            GetX<HomeController>(builder: (ctrl) {
              return RegisteredSvcListComp(
                ctrlId: agent.id,
                svcs: ctrl.mapCtrlsSvcs[agent.id] ?? [],
                onLongPress: ctrl.unregisterService,
              );
            })
          ],
        ),
      ),
    ),
  );
}

DataRow _controllerRow(Controller controller) {
  return DataRow(
    cells: [
      DataCell(Text(controller.name)),
      DataCell(Text(controller.id)),
      DataCell(
        DragTarget(
          builder: (context, candidateData, rejectedData) => Container(
            decoration: candidateData.isEmpty
                ? const BoxDecoration()
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),
            child: Text(
              controller.status ? "Connected" : "Disconnected",
              style: TextStyle(
                color: controller.status ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class RegisteredSvcListComp extends StatelessWidget {
  final List<Map<String, dynamic>> svcs;
  final String ctrlId;
  final void Function(String svc_id, String ctrl_id) onLongPress;

  const RegisteredSvcListComp({
    super.key,
    required this.svcs,
    required this.ctrlId,
    required this.onLongPress,
  });

  Widget _makeSvcComp({
    required String svcId,
    required String name,
    required void Function()? onTap,
  }) {
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
        onLongPress: () {
          onLongPress(svcId, ctrlId);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.withAlpha(50),
            borderRadius: const BorderRadius.all(
              Radius.circular(80),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(name),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(svcs);
    return Wrap(
      children: svcs
          .map(
            (e) => _makeSvcComp(
              svcId: e['id'],
              name: e['img_name'],
              onTap: () {
                launchUrlString(
                    'http://code.godopu.com:9995/svc/55372cfb-01a8-4704-bbb8-f9d0aaac2686?name=hello');
              },
            ),
          )
          .toList(),
    );
  }
}
