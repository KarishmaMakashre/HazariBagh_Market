import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  // ===================== BASIC =====================
  @override
  String get welcomeUser => 'Welcome, User!';

  @override
  String get discoverStores => 'Discover local stores & amazing deals';

  @override
  String get exploreStores =>
      'Explore stores by category & distance';

  @override
  String get visitStore => 'Visit Store';

  // ===================== HOME =====================
  @override
  String get categories => 'Categories';

  @override
  String get nearbyStores => 'Nearby Stores';

  @override
  String get viewAll => 'View All';

  @override
  String get bigSale => 'Big Sale this Week!';

  @override
  String get groceryOffer => 'On all grocery items';

  @override
  String get specialWeekend => 'Special Weekend Offer!';

  @override
  String get flatOff =>
      'Get flat 30% off on all orders above ₹999';

  // ===================== COMMON =====================
  @override
  String get back => 'Back';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get generalSettings => 'General Settings';

  @override
  String get mode => 'Mode';

  @override
  String get darkLight => 'Dark & Light';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get terms => 'Terms & Conditions';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get rateApp => 'Rate This App';

  @override
  String get shareApp => 'Share This App';

  @override
  String get logout => 'Logout';

  @override
  String get selectLanguage => 'Select Language';

  // ===================== ORDER =====================
  @override
  String get placedOn => 'Placed on';

  @override
  String get qty => 'Qty';

  // ===================== STATUS =====================
  @override
  String get pending => 'Pending';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  // ===================== SUPPORT =====================
  @override
  String get contactUs => 'Contact Us';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get faqs => 'FAQs';

  @override
  String get raiseComplaint => 'Raise Complaint';

  // ===================== RAISE COMPLAINT =====================
  @override
  String get raiseComplaintTitle =>
      'Raise a Complaint / Request Refund';

  @override
  String get subject => 'Subject';

  @override
  String get subjectHint => 'Brief subject of your complaint';

  @override
  String get orderNumberOptional =>
      'Order Number (Optional)';

  @override
  String get orderNumberHint =>
      'Enter order number if applicable';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint =>
      'Describe your issue in detail...';

  @override
  String get submitComplaint => 'Submit Complaint';

  @override
  String get complaintResponseNote =>
      'Our team will respond within 24 hours.';

  // ===================== LIVE CHAT =====================
  @override
  String get liveChatTitle => 'Live Chat Support';

  @override
  String get liveChatSubtitle =>
      'Typically replies within minutes.';

  @override
  String get chatHint => 'Type your message...';

  // ===================== FAQ =====================
  @override
  String get faqTrackOrderQ =>
      'How do I track my order?';

  @override
  String get faqTrackOrderA =>
      'You can track your order from the Orders section in your profile.';

  @override
  String get faqPaymentQ =>
      'What payment methods are accepted?';

  @override
  String get faqPaymentA =>
      'We accept UPI, Debit Card, Credit Card and Cash on Delivery.';

  @override
  String get faqCancelQ =>
      'How can I cancel my order?';

  @override
  String get faqCancelA =>
      'Orders can be cancelled before dispatch from the Orders page.';

  @override
  String get faqDeliveryFeeQ =>
      'Is there a delivery fee?';

  @override
  String get faqDeliveryFeeA =>
      'Delivery fee depends on distance and order value.';

  @override
  String get faqVendorQ =>
      'How do I become a vendor?';

  @override
  String get faqVendorA =>
      'You can register as a vendor from the Become a Vendor section.';

  @override
  String get faqRefundQ =>
      'What is your refund policy?';

  @override
  String get faqRefundA =>
      'Refunds are processed within 5–7 working days after approval.';

  // ===================== CONTACT =====================
  @override
  String get contactCallTitle => 'Call Us';

  @override
  String get contactCallSubtitle =>
      'Mon - Sun (9:00 AM - 9:00 PM)';

  @override
  String get contactWhatsappTitle => 'WhatsApp';

  @override
  String get contactWhatsappSubtitle =>
      'Quick support via WhatsApp';

  @override
  String get contactWhatsappAction => 'Chat Now';

  @override
  String get contactEmailTitle => 'Email Us';

  @override
  String get contactEmailSubtitle =>
      'We reply within 24 hours';

  // ===================== BOTTOM NAV =====================
  @override
  String get navHome => 'Home';

  @override
  String get navCategories => 'Categories';

  @override
  String get navOrders => 'Orders';

  @override
  String get navSupport => 'Support';

  // ===================== STORE =====================
  @override
  String get aboutStore => 'About Store';

  @override
  String get aboutStoreDesc =>
      'This store provides quality products at affordable prices. Customer satisfaction is our priority.';

  @override
  String get noDataFound => 'No data found';

  // ===================== JOBS & SERVICES =====================
  @override
  String get jobsAndServices => 'Jobs & Services';

  @override
  String get jobsServicesDesc =>
      'Find opportunities and professional services in Hazaribagh';

  @override
  String get jobs => 'Jobs';

  @override
  String get services => 'Services';

  @override
  String get filterByCategory =>
      'Filter By Category';

  @override
  String get viewDetails => 'View Details';

  // ===================== PROPERTY =====================
  @override
  String get propertyListing =>
      'Property Listing';

  @override
  String get propertySubtitle =>
      'Find verified properties near you';

  @override
  String get filter => 'Filter';

  @override
  String get propertyType =>
      'Property Type';

  @override
  String get category => 'Category';

  @override
  String get verified => 'Verified';

  @override
  String get owner => 'Owner';

  @override
  String get propertyWarning =>
      'Verify property documents and visit the property before payment.';
  @override
  String get contactInformation => 'Contact Information';

}
