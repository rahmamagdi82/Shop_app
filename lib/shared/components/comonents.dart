import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/style/colors.dart';

Widget defultTextFormFeild({
  required String? Function(String?) validate,
  required TextEditingController control,
  required TextInputType type,
  bool obscure =false,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? show,
  VoidCallback? tap,
  VoidCallback? submit(String)?,
  VoidCallback? change(String)?,
})=>TextFormField(
  validator: validate,
  controller: control,
  keyboardType: type,
  obscureText: obscure,
  onTap: tap,
  onChanged: change,
  onFieldSubmitted: submit,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: Icon(prefix),
    suffixIcon: (suffix==null)?null:IconButton(
      onPressed: show,
      icon: Icon(suffix),
    ),
    border: const OutlineInputBorder(),
  ),
);

Future navigation(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context)=> widget));

Future navigationAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(
        builder:(context)=> widget,
    ),
  (route){
    return false;
  }
);

Widget defultButton({
  required VoidCallback function,
  required String text,
  bool uperCase=false,
})=>Container(
  height: 50.0,
  width: double.infinity,
  child: MaterialButton(
    textColor: Colors.white,
    color: defaultColor,
    onPressed:function,
    child: (uperCase)?Text(text.toUpperCase()):Text(text),
  ),
);

Widget defultTextButton({
  required VoidCallback function,
  required String text,
})=>TextButton(
onPressed: function,
child: Text(
    text.toUpperCase()
),
);

///Colors of Toast
//error->red
//succes->green
//worning->amber
void toast({
  required String message,
  Color? color=Colors.amber,
})=>Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);

String token='';

Widget myDivider()=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0),
  child: Container(
    width: double.infinity,
    height: 1.5,
    color: Colors.grey,
  ),
);

Widget listProduct(item,context, {bool isOldPrice = true})=>Container(
  height: 120.0,
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(item.image),
              width: 120.0,
              height: 120.0,
            ),
            if(item.discount != 0 && isOldPrice)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style:TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
          alignment: AlignmentDirectional.bottomStart,
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${item.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(item.discount != 0 && isOldPrice)
                    Text(
                      '${item.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: (ShopCubit.get(context).favorites[item.id]==true)?defaultColor:Colors.grey,
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(item.id);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);