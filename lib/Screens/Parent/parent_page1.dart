import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidzo_app/Re-usable_Component/customprint.dart';
import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Screens/packages/app_info_model.dart';

class ParentCodePage extends StatefulWidget {
  const ParentCodePage({super.key});

  @override
  State<ParentCodePage> createState() => _ParentPage1State();
}

class _ParentPage1State extends State<ParentCodePage> {
  get child => null;
  List dataList = [];
  String? docId;

  getUserId() {
    var user = FirebaseAuth.instance.currentUser;
    printFunction('Uid of the child is ${user!.uid}');
    setState(
      () {
        docId = user.uid;
        printFunction('docId equals $docId');
      },
    );
  }

  DocumentSnapshot? documentSnapshot;

  String parentCode = 'No Code';

  bool isLoading = false;

  String getUserCode() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          parentCode = documentSnapshot.get('code');
          isLoading = false;
        });

        return parentCode;
      } else {
        setState(() {
          isLoading = false;
        });
        printFunction('User document does not exist');
        return parentCode;
      }
    });
    return parentCode;
  }

  @override
  void initState() {
    getUserId();
    getUserCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('children')
            .where(
              'parentid',
              isEqualTo: docId,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                CustomHeader(
                  isRequiredDesscriptionName: true,
                  headerName: "Parent ID:",
                  desscriptionName:
                      parentCode.isNotEmpty ? parentCode : 'NO CODE',
                  heightBetweenTheHeaderAndDesc: 0.02,
                  onTapDesscriptionName: () {
                    Fluttertoast.showToast(msg: 'Long press to copy Parent ID');
                  },
                  onLongTapDesscriptionName: () {
                    FlutterClipboard.copy(snapshot.data!.docs[0]['parentcode']);
                    Fluttertoast.showToast(
                        msg: 'Parent ID copied successfully');
                  },
                  containerHeight: MediaQuery.of(context).size.height * 0.35,
                  paddingAllSizeHeight: 0.10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.29,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.029,
                      ),
                      child: snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final appsInfoSnapshot = snapshot
                                    .data!.docs[index]['appinfo'] as List;
                                final appsInfo = List<AppInfoModel>.from(
                                    appsInfoSnapshot
                                        .map((e) => AppInfoModel.fromMap(e))
                                        .toList());
                                // log('appsInfo is $appsInfo');
                                return Padding(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.010,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                            long: snapshot.data!.docs[index]
                                                ['longitude'],
                                            lat: snapshot.data!.docs[index]
                                                ['latitude'],
                                            isScreenLocked: snapshot.data!
                                                .docs[index]['screenlocked'],
                                            appsInfo: appsInfo,
                                            childId: snapshot.data!.docs[index]
                                                ['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Color.fromRGBO(219, 217, 217, 1),
                                      ),
                                      child: ListTile(
                                        textColor: Colors.black,
                                        title: Text(
                                          snapshot.data!.docs[index]['name'] ??
                                              'NO CHILD DATA',
                                        ),
                                        subtitle: Text(
                                          snapshot.data!.docs[index]
                                                  ['parentcode'] ??
                                              'NO CHILD DATA',
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                    ),
                                    CustomTextButton(
                                      onTap: null,
                                      textFontSize: 30,
                                      textName:
                                          "There is no children for this parent code",
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    CustomButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const ChildSignUpScreen(),
                                          ),
                                        );
                                        FlutterClipboard.copy(parentCode);
                                      },
                                      buttonName:
                                          "sign up with this parent code",
                                      fontSize: 18,
                                      buttonColor: appColor,
                                      textColor: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color(0xFF598393),
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}
