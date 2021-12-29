import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  Barcode? _result;
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    }
    _controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: <Widget>[
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: AppColors.white,
              borderRadius: 10,
              borderLength: 170,
              borderWidth: 10,
              cutOutSize: (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0,
            ),
            onPermissionSet: (controller, isAllowed) {
              if (!isAllowed) {
                Fluttertoast.showToast(
                  msg: 'Please allow the permission to scan the code',
                  fontSize: 18.0,
                  backgroundColor: AppColors.cFF4C4E,
                  toastLength: Toast.LENGTH_SHORT,
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Point camera at a playlist code',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FutureBuilder<bool?>(
                          future: _controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!) {
                                return IconButton(
                                  onPressed: () async {
                                    await _controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.flash_on, size: 30.0, color: AppColors.white),
                                );
                              } else if (snapshot.data! == false) {
                                return IconButton(
                                  onPressed: () async {
                                    await _controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.flash_off, size: 30.0, color: AppColors.white),
                                );
                              }
                            }
                            return const Icon(Icons.hourglass_bottom, size: 30.0);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await _controller?.flipCamera();
                            setState(() {});
                          },
                          icon: const Icon(Icons.flip_camera_ios_outlined, size: 30.0, color: AppColors.white),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _controller?.resumeCamera();
                          },
                          icon: const Icon(Icons.play_arrow, size: 30.0, color: AppColors.white),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _controller?.pauseCamera();
                          },
                          icon: const Icon(Icons.pause, size: 30.0, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
      if (_result != null) {
        Fluttertoast.showToast(msg: 'Playlist ${_result!.code} received', fontSize: 18.0, backgroundColor: Theme.of(context).primaryColor);
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
