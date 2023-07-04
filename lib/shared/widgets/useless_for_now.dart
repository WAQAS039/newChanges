//
//
// showProgressLoading(double downloaded,BuildContext context,bool isFromStory, CancelToken cancelToken) async {
//   await showDialog(
//     context: context,
//     useSafeArea: false,
//     builder: (context) {
//       return WillPopScope(
//         onWillPop: ()async{
//           cancelToken.cancel();
//           return false;
//         },
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.r)
//           ),
//           content: Consumer2<QuranStoriesProvider,IslamBasicsProvider>(
//             builder: (context, story,basics, child) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     alignment: LocalizationProvider().locale.languageCode == "ur" || LocalizationProvider().locale.languageCode == "ar" ? Alignment.centerRight:Alignment.centerLeft,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const CircularProgressIndicator(),
//                         SizedBox(width: 10.h,),
//                         Text(localeText(context, "please_wait"))
//                       ],
//                     ),
//                   ),
//                   Text("${isFromStory ? story.downloaded.toInt().toString() : basics.downloaded.toInt().toString()}/100")
//                 ],
//               );
//             },
//           ),
//         ),
//       );
//     },);
// }