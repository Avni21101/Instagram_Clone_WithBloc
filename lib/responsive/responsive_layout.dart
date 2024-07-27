import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key,required this.mobileScreenLayout,required this.webScreenLayout});

  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize){
        return webScreenLayout;
      }else {
        return mobileScreenLayout;
      }
    }
    );
  }
}
