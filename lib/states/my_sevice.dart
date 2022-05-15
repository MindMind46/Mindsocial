import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindsocial/models/post_model.dart';
import 'package:mindsocial/models/user_model.dart';
import 'package:mindsocial/states/authen.dart';
import 'package:mindsocial/utility/my_constant.dart';
import 'package:mindsocial/utility/my_dialog.dart';
import 'package:mindsocial/widgets/show_form.dart';
import 'package:mindsocial/widgets/show_icon_button.dart';
import 'package:mindsocial/widgets/show_text.dart';

class MySevice extends StatefulWidget {
  const MySevice({Key? key}) : super(key: key);

  @override
  State<MySevice> createState() => _MySeviceState();
}

class _MySeviceState extends State<MySevice> {
  String? post;
  var user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  TextEditingController textEditingController = TextEditingController();
  var postModels = <PostModel>[];
  bool load = true;

  @override
  void initState() {
    super.initState();
    findUserModel();
    readllPost();
  }

  Future<void> readllPost() async {
    await FirebaseFirestore.instance
        .collection('post').orderBy('timePost', descending: true)
        .snapshots()
        .listen((event) {
      if (postModels.isNotEmpty) {
        postModels.clear();
      }

      for (var element in event.docs) {
        PostModel postModel = PostModel.fromMap(element.data());

        print('### postModel == ${postModel.toMap()}');

        postModels.add(postModel);
      }
      load = false;
      setState(() {});
    });
  }

  Future<void> findUserModel() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Social'),
        backgroundColor: MyConstant.primary,
        actions: [
          ShowIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).twoWayAction(
                title: 'SingOut ?',
                subTitle: 'Plaese SingOut',
                label1: 'SingOut',
                pressFunC1: () {
                  processSingOut(context: context);
                },
              );
            },
            colorIcon: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          load ? const Center(child: CircularProgressIndicator()) : listPost(),
          addPost(),
        ],
      ),
    );
  }

  Widget listPost() => Padding(
    padding: const EdgeInsets.only(bottom: 80),
    child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: postModels.length,
          itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(postModels[index].urlAvatarPost),
                        ),
                        ShowText(label: postModels[index].namePost),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowText(
                          label: postModels[index].postBody,
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowText(
                            label: findTimePost(
                                timePost: postModels[index].timePost))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

  Column addPost() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShowForm(
                  controller: textEditingController,
                  label: 'New Post',
                  iconData: Icons.post_add,
                  changeFunC: (String string) {
                    post = string.trim();
                  }),
              ShowIconButton(
                  iconData: Icons.send,
                  pressFunc: () {
                    if (post?.isEmpty ?? true) {
                      MyDialog(context: context).twoWayAction(
                          title: 'No Post ?', subTitle: 'Please Fill Post');
                    } else {
                      processAddPost();
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> processSingOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Authen(),
          ),
          (route) => false);
    });
  }

  Future<void> processAddPost() async {
    Timestamp timePost = Timestamp.fromDate(DateTime.now());

    PostModel postModel = PostModel(
        namePost: userModel!.name,
        postBody: post!,
        timePost: timePost,
        uidPost: user!.uid,
        urlAvatarPost: userModel!.urlAvatar);

    await FirebaseFirestore.instance
        .collection('post')
        .doc()
        .set(postModel.toMap())
        .then((value) {
      print('Add Post Success');
      textEditingController.text = '';
    });
  }

  String findTimePost({required Timestamp timePost}) {
    DateTime dateTime = timePost.toDate();
    DateFormat dateFormat = DateFormat('dd MMM yyy HH:mm');
    String result = dateFormat.format(dateTime);

    return result;
  }
}
