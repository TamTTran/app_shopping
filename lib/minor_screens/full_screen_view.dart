import 'package:flutter/material.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imageList;
  const FullScreenView({Key? key, required this.imageList}) : super(key: key);

  @override
  _FullScreenViewState createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Center(
              child: Text(
            ('${index + 1}') + ('/') + (widget.imageList.length.toString()),
            style: const TextStyle(
                fontSize: 24, color: Colors.grey, letterSpacing: 8),
          )),
          SizedBox(
              height: size * 0.5,
              child: PageView(
                controller: _controller,
                children: image(),
              )),
          SizedBox(
            height: size * 0.2,
            child: widget.imageList.isNotEmpty
                ? imageView()
                : const Center(child: Text('No images to display')),
          )
        ]),
      ),
    );
  }

  Widget imageView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.imageList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _controller.jumpToPage(index);
          },
          child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.yellow),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                child: Image.network(
                  widget.imageList[index],
                  fit: BoxFit.cover,
                ),
              )),
        );
      },
    );
  }

  List<Widget> image() {
    return List.generate(widget.imageList.length, (index) {
      return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(widget.imageList[index].toString()));
    });
  }
}
