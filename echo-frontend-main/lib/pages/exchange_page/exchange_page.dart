import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:echo_frontend/pages/exchange_page/school_list.dart';
import 'package:echo_frontend/pages/exchange_page/store_list.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<StatefulWidget> createState() => ExchangePageState();
}

class ExchangePageState extends State<StatefulWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
            "兌換點數".hcd,
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(120, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  controller: _tabController,
                  splashBorderRadius: BorderRadius.circular(25),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: Colors.blueGrey[900],
                  unselectedLabelColor: Colors.blueGrey,
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(text: '學校'.hcd),
                    Tab(text: '合作商家'.hcd),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            SchoolList(),
            StoreList(),
          ],
        ),
      ),
    );
  }
}
