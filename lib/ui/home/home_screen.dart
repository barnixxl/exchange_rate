import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/main.dart';
import 'home_controller.dart';
import '../../app_router.dart';
import '../../utils/date_formatter.dart';

part 'home_screen.error_state.part.dart';
part 'home_screen.app_bar_state.part.dart';
part 'home_screen.load_state.part.dart';
part 'home_screen.success_state.part.dart';

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
      _homeController = Provider.of<HomeController>(
        context,
        listen: false,
      );
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 40),
        child: _buildAppBarWidget(_homeController),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Observer(
          builder: (_) {
            final result = _homeController.currencyResult.value;

            if (result.isLoading) {
              return _buildLoadingWidget();
            }
            if (result.isError) {
              return _buildErrorWidget(
                result.error?.toString(),
                () {
                  _loadData();
                },
              );
            }
            return _buildSuccessWidget(_homeController);
          },
        ),
      ),
    );
  }
}
