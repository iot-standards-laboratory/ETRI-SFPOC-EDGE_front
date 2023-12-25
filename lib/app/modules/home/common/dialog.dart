import 'package:flutter/material.dart';

// void makeDialog(BuildContext context) async {
//   var result = await showDialog(
//     builder: (context) => Container(
//       decoration: BoxDecoration(color: Colors.white),
//       width: 100,
//       height: 100,
//       margin: EdgeInsets.all(20),
//     ),
//     context: context,
//   );
// }

const logos = [
  'assets/images/logo_etri_basic.png',
  'assets/images/logo_etri_pro.png',
  'assets/images/logo_agworld.png',
  'assets/images/logo_conservis.jpg',
  'assets/images/logo_farmos.png',
  'assets/images/logo_tanibox.png',
  'assets/images/logo_agrivi.png',
];
const execScreens = [
  'assets/images/exec_agworld.png',
  'assets/images/exec_agworld.png',
  'assets/images/exec_agworld.png',
];
const svcNames = [
  'ETRI Smart Farm (basic)',
  'ETRI Smart Farm (pro)',
  'AgWorld',
  'Conservis',
  'Farmos',
  'TaniBox',
  'Agrivi',
];
const descriptions = [
  "Provide a function for monitoring and controlling the environment of the farm.",
  "Provide a advanced function for monitoring and controlling the farm.",
  "Global platform connecting farmers with agricultural resources and information.",
  "AI-powered irrigation management system optimizing water use for farms.",
  "Farm data management platform offering precision agriculture tools and insights.",
  "Smartphone app and sensor system for remote livestock monitoring and management.",
  "Agritech marketplace enabling farmers to directly buy and sell agricultural produce.",
];
const uuids = [
  'b13cccee-041c-48ce-b0fb-cafb9f8c23e4',
  '6e6a0aab-dd0d-44d1-8464-e976d465f1ad',
  'f6cbb20e-9eed-11ee-8c90-0242ac120002',
  'fc378524-9eed-11ee-8c90-0242ac120002',
  '0136c652-9eee-11ee-8c90-0242ac120002',
  '05dd5a9a-9eee-11ee-8c90-0242ac120002',
  '0a23375a-9eee-11ee-8c90-0242ac120002'
];

var colors = [
  [Colors.orange, Colors.pink],
  [Colors.purple, Colors.blue],
  [Colors.green.withAlpha(100), Colors.green],
];

Future<String?> makeDialog(BuildContext context) async {
  var result = await showDialog(
    builder: (context) => AlertDialog(
      // title: const Text('Title'),
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.8),
      elevation: 5,
      content: SizedBox(
        width: 1000,
        height: 660,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // header
              children: [
                Text(
                  'Service Store',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Row(
                          children: [
                            Icon(Icons.search),
                            Text('Search'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),

            Divider(color: Colors.white.withAlpha(150)),
            const SizedBox(height: 20),
            // body
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List<Widget>.generate(
                  3,
                  (index) => _installableServiceComponent(
                    context,
                    colors: colors[index],
                    logo: Image.asset(
                      logos[index],
                      fit: BoxFit.cover,
                    ),
                    execScreen: Image.network(
                      execScreens[index],
                      fit: BoxFit.cover,
                    ),
                    svcName: svcNames[index],
                    description: descriptions[index],
                    uuid: uuids[index],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List<Widget>.generate(
                  4,
                  (index) => _installableServiceSmallComponent(
                    context,
                    colors: [Colors.purple, Colors.blue],
                    logo: Image.asset(
                      logos[index + 3],
                      fit: BoxFit.cover,
                    ),
                    svcName: svcNames[index + 3],
                    description: descriptions[index + 3],
                    uuid: uuids[index + 3],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    context: context,
  );

  return result;
}

Widget _installableServiceComponent(
  BuildContext context, {
  required List<Color> colors,
  required Image logo,
  required Image execScreen,
  required String svcName,
  required String description,
  required String uuid,
}) {
  return SizedBox(
    width: 310,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // add gradient background
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: execScreen,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(svcName),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Container(
              // Set elevation for shadow effect
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5.0,
                    blurRadius: 7.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: logo,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // make a two text for title and description
                  Text(
                    svcName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // please add rounded background
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            var result = await _makeConfirmDialog(context);
            if (result) {
              Navigator.of(context).pop(uuid);
            }
          },
          child: const Text("Install"),
        )
      ],
    ),
  );
}

// small component for installable service
Widget _installableServiceSmallComponent(
  BuildContext context, {
  required List<Color> colors,
  required Image logo,
  required String svcName,
  required String description,
  required String uuid,
}) {
  return SizedBox(
    width: 240,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              // Set elevation for shadow effect
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5.0,
                    blurRadius: 7.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: logo,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // make a two text for title and description
                  Text(
                    svcName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // please add rounded background
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(uuid);
            },
            child: const Text("Install"),
          ),
        )
      ],
    ),
  );
}

Future<bool> _makeConfirmDialog(BuildContext context) async {
  var confirmKey = GlobalKey();
  var result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure to install this service?'),
            const SizedBox(height: 20),
            CustomProgressBar(key: confirmKey),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              (confirmKey.currentState as _CustomProgressBarState).confirm();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );

  return result as bool;
}

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar({super.key});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  bool isConfirm = false;
  void confirm() {
    setState(() {
      isConfirm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 10,
      width: isConfirm ? 250 : 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.blue],
        ),
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
