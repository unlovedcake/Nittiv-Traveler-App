// ignore_for_file: public_member_api_docs, sort_constructors_first

class SocialLink {
  final String name;
  final String assetImagePath;
  final String url;
  const SocialLink({
    required this.name,
    required this.assetImagePath,
    required this.url,
  });
}

const socialLinks = [
  SocialLink(
    name: 'Facebook',
    assetImagePath: 'assets/icons/facebook.png',
    url: 'https://www.facebook.com/hiddendestinationsPH',
  ),
  SocialLink(
    name: 'Instagram',
    assetImagePath: 'assets/icons/instagram.png',
    url: 'https://www.instagram.com/nittivwellness/',
  ),
  SocialLink(
    name: 'Twitter',
    assetImagePath: 'assets/icons/twitter.png',
    url: 'https://twitter.com/nittivwellness',
  ),
  SocialLink(
    name: 'LinkedIn',
    assetImagePath: 'assets/icons/linkedIn.png',
    url: 'https://www.linkedin.com/company/nittiv',
  ),
];
