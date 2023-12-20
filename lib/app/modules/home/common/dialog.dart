import 'package:flutter/material.dart';
import 'package:front/app/model/service_image.dart';

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
                _installableServiceComponent(
                  context,
                  colors: [Colors.orange, Colors.pink],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  execScreen: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description:
                      "Provide a function for monitoring and controlling the environment of the farm.",
                  uuid: "6e6a0aab-dd0d-44d1-8464-e976d465f1ad",
                ),
                _installableServiceComponent(
                  context,
                  colors: [Colors.green.withAlpha(100), Colors.green],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  execScreen: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description:
                      "Provide a function for monitoring and controlling the environment of the farm.",
                  uuid: "uuid-2",
                ),
                _installableServiceComponent(
                  context,
                  colors: [Colors.purple, Colors.blue],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  execScreen: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description:
                      "Provide a function for monitoring and controlling the environment of the farm.",
                  uuid: "uuid-3",
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _installableServiceSmallComponent(
                  context,
                  colors: [Colors.purple, Colors.blue],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description: "Provide a function for ",
                  uuid: "uuid-3",
                ),
                _installableServiceSmallComponent(
                  context,
                  colors: [Colors.purple, Colors.blue],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description: "Provide a function for ",
                  uuid: "uuid-3",
                ),
                _installableServiceSmallComponent(
                  context,
                  colors: [Colors.purple, Colors.blue],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description: "Provide a function for ",
                  uuid: "uuid-3",
                ),
                _installableServiceSmallComponent(
                  context,
                  colors: [Colors.purple, Colors.blue],
                  logo: Image.network(
                    "https://placeimg.com/640/480/nature",
                    fit: BoxFit.cover,
                  ),
                  svcName: "ETRI Smart Farm (basic)",
                  description: "Provide a function for ",
                  uuid: "uuid-3",
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
                alignment: Alignment.centerLeft,
                child: Text(svcName),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: execScreen,
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
              padding: const EdgeInsets.all(16.0),
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
              child: Image.network(
                "https://placeimg.com/640/480/nature",
                fit: BoxFit.cover,
              ),
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
          onPressed: () {
            Navigator.of(context).pop(uuid);
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
              padding: const EdgeInsets.all(16.0),
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
