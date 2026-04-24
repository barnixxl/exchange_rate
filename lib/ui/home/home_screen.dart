import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/main.dart';

import 'home_controller.dart';
import '../../models/rate_data.dart';
import '../../app_router.dart';
import '../../utils/date_formatter.dart';

part 'app_bar_part.dart';
part 'screen_state_part.dart';
part 'loading_screen_state_part.dart';
part 'error_state_part.dart';
part 'success_state_part.dart';
part 'currency_list_part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _homeController = Provider.of<HomeController>(context, listen: false);
      _loadData();
    }
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _buildBody(),
      ),
    );
  }
}
