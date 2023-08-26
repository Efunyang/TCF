import 'dart:async';

import 'package:echo_frontend/constants/app_sizes.dart';
import 'package:echo_frontend/hyper_track_handler.dart';
import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:echo_frontend/repositories/providers/user_repo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late final WebViewController webViewController;
  Timer? timer;
  bool isMapLoading = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      final res = await _function();
      if (res == true) {
        timer?.cancel();
        setState(() {
          isMapLoading = false;
        });
      }
    });

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(ref.read(hyperTrackHandlerProvider).getWebViewURL()));
  }

  _function() async {
    return await webViewController
        .runJavaScriptReturningResult('''var temp = document.getElementsByClassName("_hideIcon_m6r46_45").length;
        if (temp == 0) {temp = false;} else {document.getElementsByClassName("_hideIcon_m6r46_45")[0].remove();temp = true;}''');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateChangesProvider).value;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "主頁".hcd,
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: Sizes.p24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height - 70 - 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${user?.carbonReduction ?? 0}',
                          style: GoogleFonts.lilitaOne(
                            fontSize: Sizes.p48,
                          ),
                        ),
                        Text(
                          '公斤減碳量'.hcd,
                          style: const TextStyle(
                            fontSize: Sizes.p24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    gapH16,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            percent: 0.56,
                            lineHeight: Sizes.p20,
                            padding: EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width * 0.64 - Sizes.p72 + Sizes.p8,
                            barRadius: const Radius.circular(25),
                            progressColor: Colors.cyan[600],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: Sizes.p72,
                            height: Sizes.p72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.cyan[600],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '${user?.point ?? 0}點'.hcd,
                              style: const TextStyle(
                                fontSize: Sizes.p24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              gapH16,
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.width * 0.9,
                child: isMapLoading
                    ? SpinKitCircle(
                        size: 80,
                        itemBuilder: (context, index) {
                          final colors = [
                            Colors.white,
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ];
                          final color = colors[index % colors.length];
                          return DecoratedBox(
                            decoration: BoxDecoration(color: color),
                          );
                        },
                      )
                    : WebViewWidget(controller: webViewController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
