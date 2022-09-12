abstract class View {
  static bool isDesktop(double width) => width >= 800;

  static bool isTablet(double width) => width > 420 && width < 800;

  static bool isMobile(double width) => width <= 768;
}
