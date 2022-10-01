import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/login.dart';


class OnBoarding{
  final String image;
  final String title;
  final String body;
  OnBoarding({
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> boarding=[
    OnBoarding(image: 'assets/images/onboard1.jpg', title: 'View Items', body: 'you can view all products in our store from any where'),
    OnBoarding(image: 'assets/images/sale.jpg', title: 'Sale', body: 'you can view sales in our store'),
    OnBoarding(image: 'assets/images/favorite.jpg', title: 'Favorite Items', body: 'you can add any product to favorite and view them'),

  ];
  var pageController=PageController();
  bool isLast=false;
  bool isSkip=false;
  void skip()
  {
    CashHelper.putData(key: 'isSkip', value: true).then((value) {
      navigationAndFinish(context, Login());

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defultTextButton(
              function: skip,
              text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index){
                return builderItems(boarding[index]);
              },
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index){
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }else
                  {
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  count: boarding.length,
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                    spacing: 5
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      skip();
                    }
                    else
                      {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget builderItems(OnBoarding item)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(
            item.image,
          ),
        ),
      ),
      const SizedBox(height: 30.0,),
      Text(
        item.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(height: 15.0,),
      Text(
        item.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
      const SizedBox(height: 30.0,),
    ],
  );
}