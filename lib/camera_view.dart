// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:flutter/material.dart' hide CarouselController;

// class CameraView extends StatefulWidget {
//   const CameraView({super.key});

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Screen'),
//       ),
//       body: CameraAwesomeBuilder.awesome(
//         sensorConfig: SensorConfig.single(
//           sensor: Sensor.position(SensorPosition.back),
//           flashMode: FlashMode.none,
//           aspectRatio: CameraAspectRatios.ratio_16_9,
//         ),
//         saveConfig: SaveConfig.photo(),
//         onMediaTap: (mediaCapture) {
//           // OpenFile.open(mediaCapture.filePath);
//         },
//         theme: AwesomeTheme(
//           bottomActionsBackgroundColor: Colors.cyan.withOpacity(0.5),
//           buttonTheme: AwesomeButtonTheme(
//             backgroundColor: Colors.black,
//             iconSize: 32,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.all(16),
//           ),
//         ),
//         topActionsBuilder: (state) => AwesomeTopActions(
//           padding: EdgeInsets.zero,
//           state: state,
//           children: [
//             Expanded(
//                 child: Align(
//               alignment: Alignment.centerLeft,
//               child: AwesomeFlashButton(
//                 // Current CameraState
//                 state: state,
//                 // You can provide your own icon builder with a custom icon for each flash mode for example.
//                 iconBuilder: (flashMode) {
//                   switch (flashMode) {
//                     case FlashMode.none:
//                       return const Icon(Icons.flash_off);
//                     case FlashMode.on:
//                       return const Icon(Icons.flash_on);
//                     case FlashMode.auto:
//                       return const Icon(Icons.flash_auto);
//                     case FlashMode.always:
//                       return const Icon(Icons.flashlight_on);
//                   }
//                 },
//                 // You can provide a custom theme to the button. If you don't, it will use the theme from CameraAwesomeBuilder
//                 theme: AwesomeTheme(
//                   buttonTheme: AwesomeButtonTheme(
//                     iconSize: 32,
//                     padding: const EdgeInsets.all(8),
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                   ),
//                 ),
//                 onFlashTap: (sensorConfig, flashMode) {
//                   // You may want to update your custom UI or save the flash mode in the settings of your app for example

//                   // Finally, update the flash mode of the sensor config
//                   sensorConfig.setFlashMode(flashMode);
//                 },
//               ),
//             )),
//           ],
//         ),
//         bottomActionsBuilder: (state) => AwesomeBottomActions(
//           state: state,
//           left: TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           right: AwesomeCameraSwitchButton(
//             state: state,
//             scale: 1.0,
//             onSwitchTap: (state) {
//               state.switchCameraSensor(
//                 aspectRatio: state.sensorConfig.aspectRatio,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
