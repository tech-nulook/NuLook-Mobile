import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/rounded_textfield.dart';
import '../../../core/cubit/image/image_cubit.dart';
import '../../home/view/advanced_drawer.dart';

enum PageType {
  pageOne,
  pageTwo,
  pageThree,
  pageFour,
  pageFive,
  pageSix,
  pageSeven,
  pageEight,
  pageNine,
  pageTen,
}

class AboutYourDetails extends StatefulWidget {
  const AboutYourDetails({super.key});

  @override
  State<AboutYourDetails> createState() => _AboutYourDetailsState();
}

class _AboutYourDetailsState extends State<AboutYourDetails> {
  int? pageOneSelectedIndex,
      pageTwoSelectedIndex,
      pageThreeSelectedIndex,
      pageFourSelectedIndex,
      pageFiveSelectedIndex,
      pageSixSelectedIndex,
      pageSevenSelectedIndex,
      pageEightSelectedIndex; // store which item is selected
  PageType currentPage = PageType.pageOne;

  final List<String> itemsDescribes = [
    "I am student",
    "I am Professional",
    "I am Influencer",
    "I am Entrepreneur",
    "Others",
  ];

  final List<String> itemsDayLooks = [
    "On the go",
    "Indoors",
    "Remote",
    "Outdoors",
    "Varies",
  ];

  final List<String> itemsLooks = [
    "On the go",
    "Indoors",
    "Remote",
    "Outdoors",
    "Varies",
  ];

  final List<String> itemsSkinType = [
    "Oily",
    "Dry",
    "Combination",
    "Sensitive",
    "Not sure",
  ];

  final List<String> itemsHairType = [
    "Straight",
    "Wavy",
    "Curly",
    "Coily",
    "Not sure",
  ];

  final List<String> itemsHairStyle = [
    "Casual",
    "Professional",
    "Minimalist",
    "Bold",
    "Ethnic",
  ];

  final List<String> itemsBeautyConcerns = [
    "Acne",
    "Hari fall",
    "Dry Scalp",
    "Dull skin",
    "Not sure",
  ];

  final List<String> itemsOccasion = [
    "Daily looks",
    "Date night",
    "Collage fest",
    "Parties",
    "Weeding",
  ];
  TextEditingController nameController = TextEditingController();

  // 🔁 Get next page type when button is pressed
  void _nextPage() {
    final allPages = PageType.values;
    final currentIndex = allPages.indexOf(currentPage);
    debugPrint("currentIndex $currentIndex");
    final nextIndex = (currentIndex + 1) % allPages.length;

    setState(() {
      currentPage = allPages[nextIndex];
      debugPrint("Page $currentPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = PageType.values.length;
    final currentPageIndex = PageType.values.indexOf(currentPage) + 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const AdvancedDrawerWidget();
                        //     },
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Skip'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "About you",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Provide your vendors",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "$currentPageIndex of $totalPages",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // 👈 rounded corners
                    side: const BorderSide(color: Colors.transparent, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      children: [_buildAboutYour(currentPage), SizedBox()],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          pageOneSelectedIndex != null
                              ? Colors.redAccent
                              : Colors.redAccent.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (currentPageIndex == 10) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AdvancedDrawerWidget.getRouteInstance(),
                        //   ),
                        // );
                      } else {
                        _nextPage();
                      }
                      // Example logic
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutYour(PageType page) {
    switch (page) {
      case PageType.pageOne:
        return pageOneWidget(
          title: 'What beast describes you ?',
          subTitle: 'Select what you are',
          items: itemsDescribes,
          selectedIndex: pageOneSelectedIndex,
        );
      case PageType.pageTwo:
        return pageTwoWidget(
          title: 'Your usual day looks  like ?',
          subTitle: 'Select what look',
          items: itemsDayLooks,
          selectedIndex: pageTwoSelectedIndex,
        );
      case PageType.pageThree:
        return pageThreeWidget(
          title: 'How often do you go out socially ?',
          subTitle: 'Select how you look',
          items: itemsLooks,
          selectedIndex: pageThreeSelectedIndex,
        );
      case PageType.pageFour:
        return pageFourWidget(
          title: 'What your skin type ?',
          subTitle: 'Select your skin type',
          items: itemsSkinType,
          selectedIndex: pageFourSelectedIndex,
        );
      case PageType.pageFive:
        return pageFiveWidget(
          title: 'What your hair type ?',
          subTitle: 'Select your hair type',
          items: itemsHairType,
          selectedIndex: pageFiveSelectedIndex,
        );
      case PageType.pageSix:
        return pageSixWidget(
          title: 'What your style preference ?',
          subTitle: 'Select your hair type',
          items: itemsHairStyle,
          selectedIndex: pageSixSelectedIndex,
        );
      case PageType.pageSeven:
        return pageSevenWidget(
          title: 'Do you have any beauty concerns ?',
          subTitle: 'Select your problems',
          items: itemsBeautyConcerns,
          selectedIndex: pageSevenSelectedIndex,
        );
      case PageType.pageEight:
        return pageEightWidget(
          title: 'Which occasions prepare for ?',
          subTitle: 'Select your preferences',
          items: itemsOccasion,
          selectedIndex: pageEightSelectedIndex,
        );
      case PageType.pageNine:
        return pageNineWidget(
          title: 'Who style influence your looks ?',
          subTitle: 'Inspires your look',
          items: itemsOccasion,
          selectedIndex: pageEightSelectedIndex,
        );
      case PageType.pageTen:
        return pageTenWidget(
          title: 'Take selfie / upload your profile picture ?',
          subTitle: 'Set your picture',
          items: itemsOccasion,
          selectedIndex: pageEightSelectedIndex,
        );
    }
  }

  Widget pageOneWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageOneSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageOneSelectedIndex = index;
                  debugPrint('PageOne: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageTwoWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageTwoSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageTwoSelectedIndex = index;
                  debugPrint('PageTwo: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageThreeWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageThreeSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageThreeSelectedIndex = index;
                  debugPrint('PageThree: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageFourWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageFourSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageFourSelectedIndex = index;
                  debugPrint('PageFour: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageFiveWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageFiveSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageFiveSelectedIndex = index;
                  debugPrint('PageFive: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageSixWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageSixSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageSixSelectedIndex = index;
                  debugPrint('PageSix:  ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageSevenWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageSevenSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageSevenSelectedIndex = index;
                  debugPrint('PageSeven: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageEightWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = pageEightSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  pageEightSelectedIndex = index;
                  debugPrint('PageEight: ${items[index]}');
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.red : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pageNineWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 20),
        RoundedTextField(
          controller: nameController,
          hintText: "Full Name",
          prefixIcon: Icons.person_outline,
          fillColor: Colors.grey.shade400,
          focusedBorderColor: Colors.white,
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget pageTenWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex }) {
    return Column(
      spacing: 20,
      children: [
        SizedBox.fromSize(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        InkWell(
          onTap: () => cameraDialog(),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Profile Circle
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: BlocBuilder<ImageCubit,ImageState>(
                  builder: (context, state) {
                     if(state is ImageLoading){
                       return const Center(
                         child: Icon(
                           Icons.person_outline,
                           color: Colors.red,
                           size: 80,
                         ),
                       );
                     } else if(state is ImageSelected) {
                       return ClipOval(
                         child: SizedBox(
                           width: 150.0, // Set equal width and height for a perfect circle
                           height: 150.0,
                           child: Image.file(state.imageFile, fit: BoxFit.cover, // Ensures the image covers the entire circular area
                           ),
                         ),
                       );
                     } else if (state is ImageError) {
                       return const Center(
                         child: Icon(
                           Icons.person_outline,
                           color: Colors.redAccent,
                           size: 80,
                         ),
                       );
                     }else{
                       return const Center(
                         child: Icon(
                           Icons.person_outline,
                           color: Colors.redAccent,
                           size: 80,
                         ),
                       );
                     }
                  },
                ),
              ),
              // Add (+) Button
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Future<bool> cameraDialog() async {
    final cubit = context.read<ImageCubit>();
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Media file'),
        content: const Text('Take camera / gallery to upload your profile picture ?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            child: Text("CAMERA", style: TextStyle()),
            onPressed: () {
              cubit.pickImage(context: context, source: ImageSource.camera);
              //Provider.of<ComplaintViewModel>(context, listen: false,).onImageCapture(ImageSource.camera, context: context);
              Navigator.pop(context, false);
            },
          ),

          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text("GALLERY", style: TextStyle()),
            onPressed: () {
              cubit.pickImage(context: context, source: ImageSource.gallery);
              //Provider.of<ComplaintViewModel>(context, listen: false,).onMultiImageCapture(ImageSource.gallery, context: context);
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

}
