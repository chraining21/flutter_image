import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() => runApp(MyApp());
int pindex = 0;
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final title = 'gallery';
    return new MaterialApp(
      title:title,
      home: new Gallerypage(title:title)
    );
    }
    
  }
  class Gallerypage extends StatelessWidget{
    final String title;
    final images = [
      'image/aa.jpg',
      'image/bb.jpg',
      'image/cc.jpg'
    ];
    Gallerypage({Key key, this.title});
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title:new Text(title),
        ),
        body:Row(
                children: <Widget>[
                  Container(
                      child:InkWell(
                          onTap: () => openGallery(0,context),
                          child: Image.asset(images.first)
                      ),
                    width: 100,
                    height: 100,
                  ),
                  Container(
                      child:InkWell(
                          onTap: () => openGallery(1,context),
                          child: Image.asset(images[1])
                      ),
                    width: 100,
                    height: 100,
                  ),
                  Container(
                      child:InkWell(
                          onTap: () => openGallery(2,context),
                          child: Image.asset(images[2])
                      ),
                    width: 100,
                    height: 100,
                  ),
                ]
            )
        );
    }
    void openGallery(_index,context) {
      pindex=_index;
      Navigator.push(
        context, MaterialPageRoute(
        builder: (context) =>
            GalleryWidget(
              images: images, index: _index,
            ),
      ),
      );
    }
  }
  class GalleryWidget extends StatefulWidget{
    final List<String> images;
    final int index;
    GalleryWidget({this.images,this.index});
    @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _GalleryWidgetState();
    }
  }
  class _GalleryWidgetState extends State<GalleryWidget>{
  PageController _pc =PageController(initialPage: pindex);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: PhotoViewGallery.builder(
            itemCount: widget.images.length,
            pageController: _pc,
            builder: (context,index){
              final _images = widget.images[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(_images),
                minScale: PhotoViewComputedScale.contained*0.8,
                maxScale: PhotoViewComputedScale.contained*2,
              );
            },
            onPageChanged: (int index){
            setState(() {
              pindex=index;
            });
          },
        ),
      appBar: new AppBar(
        title: new Text('photo'+(pindex).toString()),
      ),
    );
  }
}