import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/products_grid.dart';
import 'package:ct484_project/ui/products/top_right_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        actions: [
          Row(
            children: [
              const Image(
                image: AssetImage('assets/images/logo.jpg'),
                width: 40,
                height: 40,
                fit: BoxFit.cover, // Cách hình ảnh được căn chỉnh trong không gian được chỉ định
                alignment: Alignment.center, // Căn chỉnh hình ảnh trong không gian được chỉ định
              ),
              Container(
                width: 230,
                height: 35,
                margin: const EdgeInsets.only(left: 10), // margin để tạo khoảng cách giữa ô tìm kiếm và các phần tử khác
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), 
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 83, 82, 82).withOpacity(0.5), // màu đổ bóng
                      spreadRadius: 2, // độ lan rộng của bóng
                      blurRadius: 5, // độ mờ của bóng
                      offset: const Offset(0, 3), // vị trí của bóng
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 9), // Đặt chiều cao cho `TextField`
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_rounded),
                color: Colors.white,
                onPressed: () {
                },
              ),
              TopRightBadge(
                data: CartManager().itemCount,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CartScreen.routeName,
                    );
                  },
                ),
              )            
            ],
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromotionBanner(),
            ProductsGrid(),
          ],
        ),
      ),
    );
  }
}

  Widget _buildPromotionBanner() {
    return Container(
      height: 150,
      child: FlutterCarousel(
        options: CarouselOptions(
          height: 150,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          controller: CarouselController(),
          pageSnapping: true,
          scrollDirection: Axis.horizontal, //chiều ngang
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          disableCenter: true,
          slideIndicator: CircularSlideIndicator(),
        ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const  EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  // color: Colors.amber
                  image: DecorationImage(image: AssetImage('assets/images/green.jpg'), fit: BoxFit.cover, )
                ),
                // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
      ),
    );
  }

