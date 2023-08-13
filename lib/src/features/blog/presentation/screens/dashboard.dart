import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/presentation/providers/check_state_provider.dart';
import '../../../../route/route_names.dart';
import '../../../auth/presentation/providers/settings_provider.dart';

class Dashboard extends ConsumerStatefulWidget {
  Widget child;
  Dashboard({Key? key, required this.child}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends ConsumerState<Dashboard> {
  int visit = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? themeData =  ref.watch(settingsProvider).themeData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Idea Note'),
            leading:  Image.asset('assets/images/${ref.watch(settingsProvider).themeData==1?'logo.png':'logo_wb.png'}').pad(top: 8,bottom: 8,),
        ),
        body:
        Column(
          children: [
            Expanded(child: widget.child.pad(left: 10, right: 10, bottom: 5)),
            BottomBarInspiredInside(
              items: items,
              backgroundColor:
              themeData == 1? ColorResources.dark:
              ColorResources.background,

              color:  themeData == 1?ColorResources.background:ColorResources.dark,
              colorSelected: themeData == 1?ColorResources.dark:ColorResources.primary,
              indexSelected: ref.watch(tabIndex.notifier).state!,
              onTap: (int index) => setState(() {
                visit = index;
                switch (index){
                  case 1:  ref.read(tabIndex.notifier).state = 1;
                  context.goNamed(RouteNames.addBlog); break;
                  case 2: ref.read(tabIndex.notifier).state = 2;
                    context.goNamed(RouteNames.account);break;
                  default: ref.read(tabIndex.notifier).state = 0;
                  context.goNamed(RouteNames.viewBlog); break;
                }
              }),
              chipStyle: ChipStyle(convexBridge: true, background:themeData == 1?ColorResources.background:ColorResources.dark),
              itemStyle: ItemStyle.circle,
              animated: false,
            ),
          ],
        ),
      ),
    );
  }
}

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
  ),
  TabItem(
    icon: Icons.add,
  ),
  TabItem(
    icon: Icons.person,
  ),
];
