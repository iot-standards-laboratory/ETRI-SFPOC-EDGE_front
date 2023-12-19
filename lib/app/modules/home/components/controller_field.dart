import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/app/components/responsive.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/modules/home/controllers/home_controller.dart';
import 'package:front/colors.dart';
import 'package:get/get.dart';

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
                  children: controller.controllers
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
                    children: controller.controllers
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
      print('${(data as ServiceImage).id} on ${agent.uuid}');
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
                ? _makeRichText(context, "ID : ", agent.uuid)
                : Text(
                    agent.uuid,
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
            const ExpansionTile(
              title: Text('Controllers'),
              subtitle: Text('The number of connected controllers: 1'),
              children: <Widget>[
                ListTile(title: Text('This is tile number 1')),
              ],
            ),
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
      DataCell(Text(controller.uuid)),
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
