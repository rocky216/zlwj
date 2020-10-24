import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HomeSwiper extends StatefulWidget {
  List banners;
  HomeSwiper({Key key, this.banners}) : super(key: key);

  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          // decoration: BoxDecoration(color: Colors.white),
          child: Container(
            child: AspectRatio(
              aspectRatio: 16/5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index){
                    return Image.network(widget.banners[index]["desc"],
                      fit: BoxFit.fill,);
                  },
                  autoplay: true,
                  itemCount: 2,
                  pagination: new SwiperPagination(alignment: Alignment.bottomRight, 
                    builder: DotSwiperPaginationBuilder(size: 8)),
                  
                )
              ),
            ),
          ),
        );
  }
}


// class HomeSwiper extends StatelessWidget {
//   List<Object> banners;

//   List<Map> images = [
//     {"url":"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4176816726,2568559965&fm=11&gp=0.jpg"},
//     {"url":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586256772124&di=1c66a5e4262f23b12f844fc039cf6c15&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fexp%2Fw%3D500%2Fsign%3Ddad3b861acaf2eddd4f149e9bd110102%2F35a85edf8db1cb13e58efa74dd54564e93584bf6.jpg"},
//     {"url":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586256835088&di=2a17cc3d4d331107bd72beb5840d6ab6&imgtype=0&src=http%3A%2F%2Fi3.3conline.com%2Fimages%2Fpiclib%2F201311%2F06%2Fbatch%2F1%2F201411%2F1383702277744slzhoiro3h_medium.jpg"},
//   ];

//    HomeSwiper({Key key, this.banners}) : super(key: key);

  
  

//   @override
//   Widget build(BuildContext context) {
//     print(this.banners);
//     return Container(
//       decoration: BoxDecoration(color: Colors.white),
//       child: Container(
//         margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
//         child: AspectRatio(aspectRatio: 16/7,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Swiper(
//               itemBuilder: (BuildContext context, int index){
//                 return Image.network(this.images[index]["url"],
//                   fit: BoxFit.fill,);
//               },
//               autoplay: true,
//               itemCount: this.images.length,
//               pagination: new SwiperPagination(alignment: Alignment.bottomRight, 
//                 builder: DotSwiperPaginationBuilder(size: 8)),
              
//             )
//           ),
//         ),
//       ),
//     );
//   }
// }