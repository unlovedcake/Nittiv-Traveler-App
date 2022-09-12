import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nittiv_new_version/Models/UserModel.dart';
import 'package:path/path.dart' as path;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nittiv_new_version/Provider/posts-provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Core/Utils/nittiv-color.dart';
import '../../Models/PostModel.dart';

class ShowDialogPost {
  static final _bodyCtrl = TextEditingController();

  static String? imageUrlPost = "";

  static String? filename = "";

  static displayDialogPost(String? userName, String? imageUrl, String email,
      BuildContext context) async {
    final size = MediaQuery.of(context).size;

    filename = Provider.of<PostsProvider>(context, listen: false).getFileName;

    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const Text(
                      'Create Post',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      hoverColor: Colors.grey[300],
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: imageUrl ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '  ${userName!} ',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            RichText(
                              text: const TextSpan(
                                  text: "  is at  ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text: "Boracay Aklan",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: " with",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " @learn2surf",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  " and rates it with",
                                  style: TextStyle(fontSize: 12),
                                ),
                                RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemSize: 16,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: NittivColors.primaryGreen,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      controller: _bodyCtrl,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Share your recent journey   $userName",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: <Widget>[
                        context.watch<PostsProvider>().isNotEmptyImage == false
                            ? const AspectRatio(
                                aspectRatio: 16 / 5, //aspect ratio for Image
                                child: Image(
                                  image: NetworkImage(
                                      "https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8="),
                                  fit: BoxFit
                                      .fitWidth, //fill type of image inside aspectRatio
                                ),
                              )
                            : Container(
                                height: 100,
                                child: Image.memory(
                                    context.watch<PostsProvider>().getFilebytes,
                                    fit: BoxFit.fitWidth),
                              ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () {
                              File? imageGallery = File("");
                              Uint8List pickedFileBytess = Uint8List(10);
                              PickedFile? pickedImage = PickedFile("");

                              context.read<PostsProvider>().setImageGallery(
                                  imageGallery,
                                  pickedFileBytess,
                                  pickedImage,
                                  "",
                                  false);
                            },
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ButtonAddPhotoLocationTag(),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500, 50),
                    maximumSize: Size(size.width, 50),
                  ),
                  onPressed: () async {
                    Uint8List bytes =
                        await Provider.of<PostsProvider>(context, listen: false)
                            .getPickImageGallery
                            .readAsBytes();

                    try {
                      TaskSnapshot upload = await FirebaseStorage.instance
                          .ref(
                              'Post-Images/${DateTime.now()}.${Provider.of<PostsProvider>(context, listen: false).getImageGallery.path}')
                          .putData(
                            bytes,
                            SettableMetadata(contentType: 'image/png'),
                          );

                      imageUrlPost = await upload.ref.getDownloadURL();

                      print(imageUrlPost);
                    } catch (e) {}

                    User? user = FirebaseAuth.instance.currentUser;

                    PostModel postModel = PostModel()
                      ..id = const Uuid().v4()
                      ..body = _bodyCtrl.text
                      ..imagePost = imageUrlPost
                      ..countComment = 0
                      ..like = false
                      ..emailSaNagLike = ""
                      ..createdAt = DateTime.now()
                      ..user = {
                        'userId': user?.uid,
                        'userName': userName,
                        'userImage': imageUrl,
                      };

                    context
                        .read<PostsProvider>()
                        .createPost(userName, email, postModel, context);
                  },
                  child: const Text('Post')),
            ),
          ],
        );
      },
    );
  }
}

class ButtonAddPhotoLocationTag extends StatefulWidget {
  const ButtonAddPhotoLocationTag({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonAddPhotoLocationTag> createState() =>
      _ButtonAddPhotoLocationTagState();
}

class _ButtonAddPhotoLocationTagState extends State<ButtonAddPhotoLocationTag> {
  Uint8List? pickedFileBytes = Uint8List(10);

  PickedFile? pickedImage;

  File? imageFile = File("");
  String? fileName;
  String? imageUrl;

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();

    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName = path.basename(pickedImage!.path);
      imageFile = File(pickedImage!.path);
      pickedFileBytes = await pickedImage!.readAsBytes();
      setState(() {
        context.read<PostsProvider>().setImageGallery(
            imageFile!, pickedFileBytes!, pickedImage, fileName, true);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth == 500) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonAddPhoto(ontap: () {
                setState(() {
                  selectPhotoDialog(context);
                });
              }),
              buttonAddLocation(),
              buttonTagPeople(),
              buttonRateOperator(),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buttonAddPhoto(ontap: () {
                    setState(() {
                      selectPhotoDialog(context);
                    });
                  }),
                  buttonAddLocation(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buttonTagPeople(), buttonRateOperator()],
              ),
            ],
          );
        }
      },
    );
  }

  selectPhotoDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select a Photo From'),
            actions: <Widget>[
              OutlinedButton(
                child: Text('Gallery'),
                onPressed: () {
                  _upload('Gallery');
                  Navigator.pop(context);
                },
              ),
              OutlinedButton(
                child: Text('Video'),
                onPressed: () {
                  _upload('camera');
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  InkWell buttonRateOperator() {
    return InkWell(
      hoverColor: Colors.blueGrey,
      onTap: () {},
      child: Tooltip(
        message: "Rate Operator",
        child: Row(
          children: const [
            Icon(
              Icons.star,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              "Rate Operator",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buttonTagPeople() {
    return InkWell(
      hoverColor: Colors.blueGrey,
      onTap: () {},
      child: Tooltip(
        message: "Tag People",
        child: Row(
          children: const [
            Icon(
              Icons.people_alt,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              "Tag People",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buttonAddLocation() {
    return InkWell(
      hoverColor: Colors.blueGrey,
      onTap: () {},
      child: Tooltip(
        message: "Add Location",
        child: Row(
          children: const [
            Icon(
              Icons.add_location,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              "Add Location",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buttonAddPhoto({required Function() ontap}) {
    return InkWell(
      hoverColor: Colors.blueGrey,
      onTap: ontap,
      child: Tooltip(
        message: "Photo/Video",
        child: Row(
          children: const [
            Icon(
              Icons.image,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              "Add Photo/Video",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
