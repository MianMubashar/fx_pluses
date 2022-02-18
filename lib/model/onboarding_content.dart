class OnboardingContent {
  String? image;
  String? title;
  String? description;
  OnboardingContent({this.image, this.description, this.title});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      image: 'assets/images/slider1.png',
      description:
          'Faster,cheaper global money transfers.plus your first few transfer are fee-free',
      title: 'Welcome to FX pluses'),
  OnboardingContent(
      image: 'assets/images/slider2.png',
      description:
      'Faster,cheaper global money transfers.plus your first few transfer are fee-free',
      title: 'Welcome to FX pluses'),OnboardingContent(
      image: 'assets/images/slider3.png',
      description:
      'Faster,cheaper global money transfers.plus your first few transfer are fee-free',
      title: 'Welcome to FX pluses')
];
