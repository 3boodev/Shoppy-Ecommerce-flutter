
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onchange,
  bool isPassword=false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixpressed
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onchange,
  validator: validate,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix!=null?IconButton(onPressed:suffixpressed,icon: Icon(suffix)) :null,
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  double width =double.infinity,
  Color background=Colors.teal,
  double radius=0,
  bool isuppercase=true,
  @required Function onpress,
  @required String text,
})=>Container(
  width:width ,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:background ,
  ),
  child: MaterialButton(
    onPressed: onpress,
    child: Text(
    isuppercase?text.toUpperCase():text,
    style: TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.bold  ),
    ),
  ),
);

Widget defaultTextButton({
  @required Function function,
  @required String text
})=>
    TextButton(
      onPressed: function,
      child:Text(text.toUpperCase() ,
       style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ),) ,
);

void defaultToast({
  @required String msg,
  @required ToastStates state,
})=>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
enum ToastStates{SUCCESS,ERROR,WARNING}
Color ChooseToastColor(ToastStates state)
{
 Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
 return color;
}

void printfulltext(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {print(match.group(0)); });
}

String token ='';

Widget BuildListProuduct(model,context,{isoldprice=true})=>Padding(
  padding: const EdgeInsets.all(10),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width:100,
              height: 100,
            ),
            if(model.discount!=0&&isoldprice)
              Container(
                width: 100,
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT'
                  ,style: TextStyle(fontSize: 12,color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.1,fontWeight: FontWeight.bold,),),
              Spacer(),
              Row(children: [
                Text('${model.price.toString()}',style: TextStyle(fontSize: 16,height: 1.1,fontWeight: FontWeight.bold,color:Colors.green[700] ),),
                if(model.discount!=0&&isoldprice)
                  Text('${model.oldPrice.toString()}',style: TextStyle(fontSize: 12,height: 1.1,fontWeight: FontWeight.bold,color:Colors.grey,decoration: TextDecoration.lineThrough ),),
                Spacer(),
                IconButton(
                    icon:  CircleAvatar(
                      radius: 20,
                      backgroundColor: HomeCubit.get(context).favorites[model.id]?Colors.red:Colors.grey,
                      child:Icon(Icons.favorite_border,color: Colors.white,),
                    ),
                    padding:EdgeInsets.zero,iconSize: 20,
                    onPressed:(){HomeCubit.get(context).changeFavorite(model.id);}
                ),
              ],mainAxisAlignment: MainAxisAlignment.center,),
            ],
          ),
        ),
      ],
    ),
  ),
);