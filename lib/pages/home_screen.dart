import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:neostore/bloc/homescreen_bloc.dart';
import 'package:neostore/bloc/homescreen_event.dart';
import 'package:neostore/bloc/homescreen_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/arguments.dart';
import 'package:neostore/model/colors.dart';
import 'package:neostore/model/product.dart';
import 'package:neostore/pages/product_listing.dart';
import 'package:neostore/pages/slide_out_screen.dart';
import 'package:neostore/repository/product_repository.dart';
import 'package:neostore/repository/user_repository.dart';
import 'package:neostore/widgets/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  String? userId;
  HomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  Map<String, String> id = {
    'tables': '1',
    'sofas': '3',
    'chairs': '2',
    'cupboards': '4'
  };

  final imagePath = [
    'assets/images/slider_img1.jpg',
    'assets/images/slider_img2.jpg',
    'assets/images/slider_img3.jpg',
    'assets/images/slider_img4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return ScreenUtilInit(builder: () {
      return Scaffold(
        drawer: RepositoryProvider(
            create: (context) => UserRepository(),
            child: SlideOutDrawer(userId: widget.userId)),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            backgroundColor: AppColors().DarkRed,
            title: TitleText(),
            centerTitle: true,
            actions: [Icon(Icons.search)],
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 686.h / 3,
                child: CarouselSlider.builder(
                  itemCount: imagePath.length,
                  itemBuilder: (context, index, rindex) {
                    final _imagePath = imagePath[index];
                    return showImage(_imagePath, index);
                  },
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1 / 2,
                child: BlocProvider(
                  create: (context) =>
                      HomeBloc(authRepo: context.read<ProductRepository>())
                        ..add(ButtonClicked()),
                  child: showItems(context),
                ),
              )
            ],
          ),
        ),
        // ),
      );
    });
  }

  Widget showImage(String imagePath, int index) => SafeArea(
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: 686.h / 3,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: scrollIndicator(),
          )
        ]),
      );

  Widget scrollIndicator() => AnimatedSmoothIndicator(
        effect: ScrollingDotsEffect(
            activeDotColor: Colors.red,
            dotColor: Colors.grey,
            spacing: 20,
            paintStyle: PaintingStyle.fill,
            dotHeight: 12,
            dotWidth: 12),
        activeIndex: activeIndex,
        count: imagePath.length,
      );

  Widget buildItems(
      {String? text, IconData? icon, String? iconText, VoidCallback? onTap}) {
    return Material(
      color: AppColors().DarkRed,
      child: InkWell(
        onTap: () => onTap!(),
        highlightColor: AppColors().Red,
        splashColor: AppColors().Red,
        child: Padding(
          padding: EdgeInsets.all(50.h / 3),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: text == 'Tables' || text == 'Chairs'
                      ? text == 'Tables'
                          ? Alignment.topRight
                          : Alignment.topLeft
                      : text == 'Sofas'
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                  child: Text(text!,
                      softWrap: false,
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w500,
                          fontSize: text == 'Cupboards' ? 28.sp : 30.sp,
                          color: Colors.white)),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: iconText == 'Icons.chair' ||
                          iconText == 'MdiIcons.tableChair'
                      ? iconText == 'MdiIcons.tableChair'
                          ? Alignment.bottomLeft
                          : Alignment.topRight
                      : iconText == 'MdiIcons.chairRolling'
                          ? Alignment.bottomRight
                          : Alignment.topLeft,
                  child: Icon(icon, color: Colors.white, size: 80),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showItems(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.h / 3,
          vertical: 45.h / 3,
        ),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          int? cid = state.product!.data![0].productCategoryId;
          String? title1;
          switch (cid) {
            case 1:
              title1 = 'Tables';
              break;
            case 2:
              title1 = 'Chairs';
              break;
            case 3:
              title1 = 'Sofas';
              break;
            case 4:
              title1 = 'Cupboards';
              break;
          }

          if (state.product != null) {
            Navigator.pushNamed(context, '/products',
                arguments: ProductListArguments(
                    product: state.product,
                    title: title1,
                    userId: '${widget.userId}'));
          }
        }, builder: (context, state) {
          return GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 35.h / 3,
              crossAxisSpacing: 35.h / 3,
              childAspectRatio: 1,
              children: [
                buildItems(
                    text: 'Tables',
                    icon: MdiIcons.tableChair,
                    iconText: 'MdiIcons.tableChair',
                    onTap: () {
                      context
                          .read<HomeBloc>()
                          .add(ButtonClicked(id: id['tables']));
                    }),
                buildItems(
                    text: 'Sofas',
                    icon: Icons.chair,
                    iconText: 'Icons.chair',
                    onTap: () async {
                      context
                          .read<HomeBloc>()
                          .add(ButtonClicked(id: id['sofas']));
                    }),
                buildItems(
                    text: 'Chairs',
                    icon: MdiIcons.chairRolling,
                    iconText: 'MdiIcons.chairRolling',
                    onTap: () {
                      context
                          .read<HomeBloc>()
                          .add(ButtonClicked(id: id['chairs']));
                    }),
                buildItems(
                    text: 'Cupboards',
                    icon: MdiIcons.cupboard,
                    iconText: 'MdiIcons.cupboard',
                    onTap: () {
                      context
                          .read<HomeBloc>()
                          .add(ButtonClicked(id: id['cupboards']));
                    }),
              ]);
        }),
      );
}
