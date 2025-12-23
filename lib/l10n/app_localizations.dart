import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

/// Usage:
/// final loc = AppLocalizations.of(context);

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // ===================== DELEGATE =====================

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [Locale('en'), Locale('hi')];

  // ===================== BASIC =====================
  String get welcomeUser;
  String get discoverStores;
  String get exploreStores;
  String get visitStore;

  // ===================== HOME =====================
  String get categories;
  String get nearbyStores;
  String get viewAll;

  String get bigSale;
  String get groceryOffer;
  String get specialWeekend;
  String get flatOff;

  // ===================== COMMON =====================
  String get back;
  String get editProfile;
  String get generalSettings;
  String get mode;
  String get darkLight;
  String get language;
  String get settings;
  String get about;
  String get terms;
  String get privacy;
  String get rateApp;
  String get shareApp;
  String get logout;
  String get selectLanguage;

  // ===================== ORDER =====================
  String get placedOn;
  String get qty;

  // ===================== STATUS =====================
  String get pending;
  String get completed;
  String get cancelled;

  // ===================== SUPPORT =====================
  String get contactUs;
  String get liveChat;
  String get faqs;
  String get raiseComplaint;

  // ===================== RAISE COMPLAINT =====================
  String get raiseComplaintTitle;
  String get subject;
  String get subjectHint;
  String get orderNumberOptional;
  String get orderNumberHint;
  String get description;
  String get descriptionHint;
  String get submitComplaint;
  String get complaintResponseNote;

  // ===================== LIVE CHAT =====================
  String get liveChatTitle;
  String get liveChatSubtitle;
  String get chatHint;

  // ===================== FAQ =====================
  String get faqTrackOrderQ;
  String get faqTrackOrderA;
  String get faqPaymentQ;
  String get faqPaymentA;
  String get faqCancelQ;
  String get faqCancelA;
  String get faqDeliveryFeeQ;
  String get faqDeliveryFeeA;
  String get faqVendorQ;
  String get faqVendorA;
  String get faqRefundQ;
  String get faqRefundA;

  // ===================== CONTACT =====================
  String get contactCallTitle;
  String get contactCallSubtitle;
  String get contactWhatsappTitle;
  String get contactWhatsappSubtitle;
  String get contactWhatsappAction;
  String get contactEmailTitle;
  String get contactEmailSubtitle;

  // ===================== BOTTOM NAV =====================
  String get navHome;
  String get navCategories;
  String get navOrders;
  String get navSupport;

  // ===================== STORE =====================
  String get aboutStore;
  String get aboutStoreDesc;
  String get noDataFound;

  // ===================== JOBS & SERVICES =====================
  String get jobsAndServices;
  String get jobsServicesDesc;
  String get jobs;
  String get services;
  String get filterByCategory;
  String get viewDetails;

  // ===================== PROPERTY =====================
  String get propertyListing;
  String get propertySubtitle;
  String get filter;
  String get propertyType;
  String get category;
  String get verified;
  String get owner;
  String get contactInformation;

  /// 🔥 FIXED: propertyWarning getter
  String get propertyWarning;

  // ===================== 🔥 DYNAMIC KEYS =====================

  String getByKey(String key) {
    final isHindi = localeName.startsWith('hi');

    switch (key) {
      // ---------- COMMON ----------
      case 'all':
        return isHindi ? 'सभी' : 'All';

      // ---------- JOB TYPE ----------
      case 'fullTime':
        return isHindi ? 'पूर्णकालिक' : 'Full Time';
      case 'shift':
        return isHindi ? 'शिफ्ट' : 'Shift';
      case 'onCall':
        return isHindi ? 'ऑन कॉल' : 'On Call';

      // ---------- JOB CATEGORIES ----------
      case 'itSoftware':
        return isHindi ? 'आईटी / सॉफ्टवेयर' : 'IT / Software';
      case 'salesMarketing':
        return isHindi ? 'सेल्स और मार्केटिंग' : 'Sales & Marketing';
      case 'healthcare':
        return isHindi ? 'स्वास्थ्य सेवा' : 'Healthcare';
      case 'education':
        return isHindi ? 'शिक्षा' : 'Education';
      case 'logistics':
        return isHindi ? 'लॉजिस्टिक्स' : 'Logistics';

      // ---------- PROPERTY ----------
      case 'For Rent':
        return isHindi ? 'किराये के लिए' : 'For Rent';
      case 'For Sale':
        return isHindi ? 'बिक्री के लिए' : 'For Sale';

      case 'Flats':
        return isHindi ? 'फ्लैट' : 'Flats';
      case 'Home':
        return isHindi ? 'घर' : 'Home';
      case 'PG':
        return isHindi ? 'पीजी' : 'PG';
      case 'Land':
        return isHindi ? 'जमीन' : 'Land';

      // ---------- STORE CATEGORIES ----------
      case 'groceryStore':
        return isHindi ? 'किराना स्टोर' : 'Grocery Store';

      case 'foodDelivery':
        return isHindi ? 'फूड डिलीवरी' : 'Food Delivery';

      case 'fashionStore':
        return isHindi ? 'फैशन स्टोर' : 'Fashion Store';

      case 'electronicsStore':
        return isHindi ? 'इलेक्ट्रॉनिक्स स्टोर' : 'Electronics Store';

      // ---------- STORE NAMES ----------
      case 'sharmaGrocery':
        return isHindi ? 'शर्मा किराना स्टोर' : 'Sharma Grocery';

      case 'deliciousFood':
        return isHindi ? 'डिलीशियस फूड' : 'Delicious Food';

      case 'fashionHub':
        return isHindi ? 'फैशन हब' : 'Fashion Hub';

      // ---------- HOME CATEGORIES ----------
      case 'jobs':
        return isHindi ? 'नौकरियां' : 'Jobs';

      case 'rentalProperty':
        return isHindi ? 'किराये की संपत्ति' : 'Rental Property';

      case 'foodDelivery':
        return isHindi ? 'फूड डिलीवरी' : 'Food Delivery';

      case 'fashionStore':
        return isHindi ? 'फैशन' : 'Fashion';

      case 'groceryStore':
        return isHindi ? 'किराना स्टोर' : 'Grocery';

      case 'hotelsRestaurants':
        return isHindi ? 'होटल और रेस्टोरेंट' : 'Hotels & Restaurants';

      case 'water':
        return isHindi ? 'पानी सप्लाई' : 'Water Supply';

      case 'education':
        return isHindi ? 'शिक्षा' : 'Education';

      case 'hospital':
        return isHindi ? 'अस्पताल' : 'Hospital';

      case 'wholesale':
        return isHindi ? 'थोक व्यापार' : 'Wholesale';

      case 'travel':
        return isHindi ? 'यात्रा' : 'Travel';

      case 'hardware':
        return isHindi ? 'हार्डवेयर' : 'Hardware';

      case 'plotLand':
        return isHindi ? 'प्लॉट / जमीन' : 'Plot / Land';

      case 'purchaseHome':
        return isHindi ? 'घर खरीदें' : 'Buy Home';

      case 'services':
        return isHindi ? 'सेवाएं' : 'Services';

      case 'automobile':
        return isHindi ? 'ऑटोमोबाइल' : 'Automobile';

      case 'government':
        return isHindi ? 'सरकारी सेवाएं' : 'Government';

      case 'transport':
        return isHindi ? 'परिवहन' : 'Transport';

      case 'agriculture':
        return isHindi ? 'कृषि' : 'Agriculture';

      // ===================== 🔥 JOB DETAILS =====================
      case 'techSolutions':
        return isHindi ? 'टेक सॉल्यूशंस प्रा. लि.' : 'Tech Solutions Pvt. Ltd.';

      case 'jobLocation':
        return isHindi ? 'स्थान: हजारीबाग' : 'Location: Hazaribagh';

      case 'jobSalary':
        return isHindi
            ? 'वेतन: ₹15,000 – ₹25,000'
            : 'Salary: ₹15,000 – ₹25,000';

      case 'jobExperience':
        return isHindi ? 'अनुभव: 1–3 वर्ष' : 'Experience: 1–3 Years';

      case 'jobPosted':
        return isHindi ? '2 दिन पहले पोस्ट किया गया' : 'Posted 2 days ago';

      case 'jobDescription':
        return isHindi
            ? 'यह एक पूर्णकालिक नौकरी है जिसमें Flutter और API का ज्ञान आवश्यक है।'
            : 'This is a full-time job requiring Flutter and API knowledge.';

      case 'requiredSkills':
        return isHindi ? 'आवश्यक कौशल' : 'Required Skills';

      case 'jobSkills':
        return isHindi
            ? 'Flutter, Dart, REST API, Firebase'
            : 'Flutter, Dart, REST API, Firebase';

      case 'contactInformation':
        return isHindi ? 'संपर्क जानकारी' : 'Contact Information';

      case 'jobContact':
        return isHindi ? 'फोन: +91 9876543210' : 'Phone: +91 9876543210';

      case 'applyNow':
        return isHindi ? 'अभी आवेदन करें' : 'Apply Now';

      case 'callEmployer':
        return isHindi ? 'नियोक्ता को कॉल करें' : 'Call Employer';

      // ===================== 🔥 JOB APPLY FORM =====================
      case 'applyForJob':
        return isHindi ? 'नौकरी के लिए आवेदन करें' : 'Apply for Job';

      case 'applyJobSubtitle':
        return isHindi
            ? 'कृपया नीचे दिए गए फॉर्म को भरें'
            : 'Please fill the form below';

      case 'fullName':
        return isHindi ? 'पूरा नाम' : 'Full Name';

      case 'fullNameHint':
        return isHindi ? 'अपना पूरा नाम दर्ज करें' : 'Enter your full name';

      case 'phoneNumber':
        return isHindi ? 'मोबाइल नंबर' : 'Phone Number';

      case 'phoneHint':
        return isHindi
            ? '10 अंकों का मोबाइल नंबर'
            : 'Enter 10-digit phone number';

      case 'email':
        return isHindi ? 'ईमेल' : 'Email';

      case 'emailHint':
        return isHindi ? 'अपना ईमेल दर्ज करें' : 'Enter your email address';

      case 'totalExperience':
        return isHindi ? 'कुल अनुभव (वर्षों में)' : 'Total Experience (Years)';

      case 'experienceHint':
        return isHindi ? 'उदाहरण: 2 वर्ष' : 'Example: 2 years';

      case 'coverLetter':
        return isHindi ? 'कवर लेटर' : 'Cover Letter';

      case 'coverLetterHint':
        return isHindi
            ? 'अपने बारे में संक्षेप में लिखें'
            : 'Write briefly about yourself';

      case 'submitApplication':
        return isHindi ? 'आवेदन जमा करें' : 'Submit Application';

      // ===================== 🔥 PROPERTY LISTING =====================
      case 'back':
        return isHindi ? 'वापस' : 'Back';

      case 'propertyListingTitle':
        return isHindi ? 'प्रॉपर्टी लिस्टिंग' : 'Property Listing';

      case 'propertyListingSubtitle':
        return isHindi
            ? 'हजारीबाग में अपना सही घर, फ्लैट, पीजी या जमीन खोजें'
            : 'Find your perfect home, flat, PG or land in Hazaribagh';

      case 'filter':
        return isHindi ? 'फ़िल्टर' : 'Filter';

      case 'propertyType':
        return isHindi ? 'प्रॉपर्टी प्रकार' : 'Property Type';

      case 'category':
        return isHindi ? 'श्रेणी' : 'Category';

      case 'importantNote':
        return isHindi
            ? 'महत्वपूर्ण: भुगतान करने से पहले प्रॉपर्टी विवरण और मालिक की जानकारी की पुष्टि करें। प्रॉपर्टी स्वयं जाकर देखें और सभी दस्तावेज़ जांचें।'
            : 'Important: Please verify property details and owner credentials before making any payment. Visit the property in person and check all documents carefully.';

      case 'verified':
        return isHindi ? 'सत्यापित' : 'Verified';

      case 'owner':
        return isHindi ? 'मालिक' : 'Owner';

      case 'viewDetails':
        return isHindi ? 'विवरण देखें' : 'View Details';

      // ================= PROPERTY DETAILS =================
      case 'noPropertySelected':
        return isHindi ? 'कोई प्रॉपर्टी चयनित नहीं है' : 'No Property Selected';

      case 'back':
        return isHindi ? 'वापस' : 'Back';

      case 'verified':
        return isHindi ? 'सत्यापित' : 'Verified';

      case 'description':
        return isHindi ? 'विवरण' : 'Description';

      case 'contactInformation':
        return isHindi ? 'संपर्क जानकारी' : 'Contact Information';

      case 'name':
        return isHindi ? 'नाम' : 'Name';

      case 'type':
        return isHindi ? 'प्रकार' : 'Type';

      case 'owner':
        return isHindi ? 'मालिक' : 'Owner';

      case 'verifyNote':
        return isHindi
            ? 'भुगतान करने से पहले प्रॉपर्टी दस्तावेज़, मालिक की जानकारी की जांच करें और प्रॉपर्टी स्वयं जाकर देखें।'
            : 'Verify property documents, owner credentials and visit the property before making any payment.';

      case 'callNow':
        return isHindi ? 'कॉल करें' : 'Call Now';

      case 'enquireNow':
        return isHindi ? 'पूछताछ करें' : 'Enquire Now';

      case 'noPropertySelected':
        return isHindi ? 'कोई प्रॉपर्टी चयनित नहीं है' : 'No Property Selected';

      case 'verifyNote':
        return isHindi
            ? 'भुगतान करने से पहले प्रॉपर्टी दस्तावेज़ और मालिक की जानकारी की जांच करें।'
            : 'Verify property documents and owner credentials before making any payment.';

      case 'callNow':
        return isHindi ? 'कॉल करें' : 'Call Now';

      case 'enquireNow':
        return isHindi ? 'पूछताछ करें' : 'Enquire Now';

      case 'hotelGrandPalace':
        return isHindi ? 'होटल ग्रैंड पैलेस' : 'Hotel Grand Palace';

      case 'spiceParadise':
        return isHindi ? 'स्पाइस पैराडाइज' : 'Spice Paradise';

      case 'pizzaCorner':
        return isHindi ? 'पिज़्ज़ा कॉर्नर' : 'Pizza Corner';

      case 'luxuryBuffet':
        return isHindi ? 'लक्ज़री • बुफे' : 'Luxury • Buffet';

      case 'indianMughlaiBiryani':
        return isHindi
            ? 'भारतीय • मुगलई • बिरयानी'
            : 'Indian • Mughlai • Biryani';

      case 'fastFoodPizza':
        return isHindi ? 'फास्ट फूड • पिज़्ज़ा' : 'Fast Food • Pizzas';

      case 'hotel':
        return isHindi ? 'होटल' : 'Hotel';

      case 'restaurant':
        return isHindi ? 'रेस्टोरेंट' : 'Restaurant';

      case 'fastFood':
        return isHindi ? 'फास्ट फूड' : 'Fast Food';

      // ===================== 🍽 MENU ITEMS =====================
      case 'chickenBiryani':
        return isHindi ? 'चिकन बिरयानी' : 'Chicken Biryani';

      case 'vegBiryani':
        return isHindi ? 'वेज बिरयानी' : 'Veg Biryani';

      case 'butterChicken':
        return isHindi ? 'बटर चिकन' : 'Butter Chicken';

      case 'paneerTikka':
        return isHindi ? 'पनीर टिक्का' : 'Paneer Tikka';
      // ===================== FASHION =====================
      case 'mensFashion':
        return isHindi ? 'पुरुषों का फैशन' : 'Mens Fashion';

      case 'womensFashion':
        return isHindi ? 'महिलाओं का फैशन' : 'Womens Fashion';

      case 'mensParlour':
        return isHindi ? 'पुरुष पार्लर और ग्रूमिंग' : 'Mens Parlour & Grooming';

      case 'mensParlourDesc':
        return isHindi
            ? 'हेयरकट, स्टाइलिंग और फेशियल सहित प्रोफेशनल ग्रूमिंग सेवाएं'
            : 'Professional grooming services including haircut and facial';

      case 'mensHairStudio':
        return isHindi
            ? 'पुरुष हेयर और बियर्ड स्टूडियो'
            : 'Mens Hair & Beard Studio';

      case 'mensHairStudioDesc':
        return isHindi
            ? 'ट्रेंडी हेयरस्टाइल और बियर्ड स्टाइलिंग'
            : 'Trendy hairstyles and beard styling';

      case 'womensSalon':
        return isHindi
            ? 'महिला सैलून और ब्यूटी सेवाएं'
            : 'Womens Salon & Beauty';

      case 'womensSalonDesc':
        return isHindi
            ? 'स्पा और मेकअप सहित पूरी ब्यूटी सेवाएं'
            : 'Complete beauty and spa services';

      case 'bridalMakeup':
        return isHindi ? 'ब्राइडल मेकअप' : 'Bridal Makeup';

      case 'bridalMakeupDesc':
        return isHindi
            ? 'शादी और पार्टी के लिए विशेष मेकअप सेवाएं'
            : 'Exclusive bridal and party makeup';

      // ===================== COMMON =====================
      case 'bookAppointment':
        return isHindi ? 'अपॉइंटमेंट बुक करें' : 'Book Appointment';

      case 'bookNow':
        return isHindi ? 'अभी बुक करें' : 'Book Now';

      case 'bookBridal':
        return isHindi ? 'ब्राइडल बुक करें' : 'Book Bridal';

      // ===================== PRICES =====================
      case 'price200':
        return isHindi ? '₹200 से शुरू' : 'Starting from ₹200';

      case 'price250':
        return isHindi ? '₹250 से शुरू' : 'Starting from ₹250';

      case 'price300':
        return isHindi ? '₹300 से शुरू' : 'Starting from ₹300';

      case 'price2500':
        return isHindi ? '₹2500 से शुरू' : 'Starting from ₹2500';

      // ===================== SERVICES =====================
      case 'hairCut':
        return isHindi ? 'हेयर कट' : 'Hair Cut';

      case 'hairStyling':
        return isHindi ? 'हेयर स्टाइलिंग' : 'Hair Styling';

      case 'facial':
        return isHindi ? 'फेशियल' : 'Facial';

      case 'massage':
        return isHindi ? 'मसाज' : 'Massage';

      case 'beardTrim':
        return isHindi ? 'दाढ़ी ट्रिम' : 'Beard Trim';

      case 'makeup':
        return isHindi ? 'मेकअप' : 'Makeup';

      case 'callNow':
        return isHindi ? 'कॉल करें' : 'Call';

      case 'whatsapp':
        return isHindi ? 'व्हाट्सएप' : 'WhatsApp';

      case 'enquiry':
        return isHindi ? 'पूछताछ' : 'Enquiry';

      case 'vegetables':
        return isHindi ? 'सब्ज़ियाँ' : 'Vegetables';
      case 'fruits':
        return isHindi ? 'फल' : 'Fruits';
      case 'rice':
        return isHindi ? 'चावल' : 'Rice';
      case 'wheat':
        return isHindi ? 'गेहूं' : 'Wheat';
      case 'oil':
        return isHindi ? 'तेल' : 'Oil';
      case 'milk':
        return isHindi ? 'दूध' : 'Milk';
      case 'snacks':
        return isHindi ? 'नाश्ता' : 'Snacks';
      case 'beverages':
        return isHindi ? 'पेय पदार्थ' : 'Beverages';
      case 'spices':
        return isHindi ? 'मसाले' : 'Spices';
      case 'pulses':
        return isHindi ? 'दालें' : 'Pulses';

      case 'no_products':
        return isHindi
            ? 'कोई उत्पाद उपलब्ध नहीं है'
            : 'No products available for';

      // ---------- CATEGORIES ----------
      case 'vegetables':
        return isHindi ? 'सब्ज़ियाँ' : 'Vegetables';

      case 'fruits':
        return isHindi ? 'फल' : 'Fruits';

      case 'rice':
        return isHindi ? 'चावल' : 'Rice';

      case 'snacks':
        return isHindi ? 'नाश्ता' : 'Snacks';

      case 'beverages':
        return isHindi ? 'पेय पदार्थ' : 'Beverages';

      case 'spices':
        return isHindi ? 'मसाले' : 'Spices';

      case 'pulses':
        return isHindi ? 'दालें' : 'Pulses';

      // ---------- COMMON ----------
      case 'no_products':
        return isHindi
            ? 'इस श्रेणी में कोई उत्पाद उपलब्ध नहीं है'
            : 'No products available for';

      case 'add':
        return isHindi ? 'जोड़ें' : 'Add';

      case 'fresh_tomatoes':
        return isHindi ? 'ताज़ा टमाटर' : 'Fresh Tomatoes';

      case 'onions_local':
        return isHindi ? 'प्याज़ (स्थानीय)' : 'Onions (Local)';

      case 'apples_shimla':
        return isHindi ? 'सेब (शिमला)' : 'Apples (Shimla)';

      case 'basmati_rice':
        return isHindi ? 'बासमती चावल' : 'Basmati Rice';

      case 'potato_chips':
        return isHindi ? 'आलू चिप्स' : 'Potato Chips';

      case 'soda_pack':
        return isHindi ? 'सोडा पैक' : 'Soda Pack';

      case 'turmeric_powder':
        return isHindi ? 'हल्दी पाउडर' : 'Turmeric Powder';

      case 'arhar_dal':
        return isHindi ? 'अरहर दाल' : 'Arhar Dal';

      // Navigation
      case 'back':
        return isHindi ? 'वापस' : 'Back';

      // Hotel Categories
      case 'hotels':
        return isHindi ? 'होटल' : 'Hotels';
      case 'restaurants':
        return isHindi ? 'रेस्टोरेंट' : 'Restaurants';
      case 'cafes':
        return isHindi ? 'कैफे' : 'Cafes';
      case 'fine_dining':
        return isHindi ? 'फाइन डाइनिंग' : 'Fine Dining';
      case 'fast_food':
        return isHindi ? 'फास्ट फूड' : 'Fast Food';
      case 'bakery':
        return isHindi ? 'बेकरी' : 'Bakery';

      // Store Names
      case 'sharma_store':
        return isHindi ? 'शर्मा किराना स्टोर' : 'Sharma Grocery Store';
      case 'delicious_food_point':
        return isHindi ? 'डिलिशियस फूड पॉइंट' : 'Delicious Food Point';
      case 'no_products':
        return isHindi ? 'कोई आइटम उपलब्ध नहीं है' : 'No items available';

      case 'add':
        return isHindi ? 'जोड़ें' : 'Add';

      case 'added_to_cart':
        return isHindi ? 'कार्ट में जोड़ा गया' : 'added to cart';

      // Example Product
      case 'fresh_tomatoes':
        return isHindi ? 'ताज़ा टमाटर' : 'Fresh Tomatoes';

      case 'Hotels':
        return isHindi ? 'होटल' : 'Hotels';

      case 'Restaurants':
        return isHindi ? 'रेस्टोरेंट' : 'Restaurants';

      case 'Cafes':
        return isHindi ? 'कैफ़े' : 'Cafes';

      case 'Fine Dining':
        return isHindi ? 'फाइन डाइनिंग' : 'Fine Dining';

      case 'Fast Food':
        return isHindi ? 'फास्ट फूड' : 'Fast Food';

      case 'Bakery':
        return isHindi ? 'बेकरी' : 'Bakery';

      case 'notifications':
        return isHindi ? 'सूचनाएं' : 'Notifications';

      case 'today':
        return isHindi ? 'आज' : 'Today';

      case 'mark_as_read':
        return isHindi ? 'सभी पढ़े हुए चिन्हित करें' : 'Mark as read';

      case 'transaction_id':
        return isHindi ? 'लेन-देन आईडी' : 'Transaction ID';

      case 'scheduled_for':
        return isHindi ? 'निर्धारित तिथि' : 'Scheduled for';

      case 'out_for_delivery':
        return isHindi ? 'डिलीवरी के लिए निकला' : 'Out for Delivery';

      case 'track':
        return isHindi ? 'ट्रैक करें' : 'Track';

      case 'cart_empty':
        return isHindi ? 'आपकी कार्ट खाली है' : 'Your cart is empty';

      case 'subtotal':
        return isHindi ? 'उप-योग' : 'Subtotal';

      case 'delivery_fee':
        return isHindi ? 'डिलीवरी शुल्क' : 'Delivery Fee';

      case 'payable_amount':
        return isHindi ? 'देय राशि' : 'Payable Amount';

      case 'payment':
        return isHindi ? 'भुगतान करें' : 'Payment';

      case 'unknown_store':
        return isHindi ? 'अज्ञात स्टोर' : 'Unknown Store';

      case 'back':
        return isHindi ? 'वापस' : 'Back';

      case 'cod':
        return isHindi ? 'कैश ऑन डिलीवरी' : 'Cash On Delivery';

      case 'cod_sub':
        return isHindi ? 'डिलीवरी पर भुगतान करें' : 'Pay When You Receive';

      case 'upi':
        return isHindi ? 'यूपीआई भुगतान' : 'UPI Payment';

      case 'upi_sub':
        return isHindi
            ? 'Google Pay, PhonePe, Paytm'
            : 'Google Pay, PhonePe, Paytm';

      case 'card':
        return isHindi ? 'डेबिट / क्रेडिट कार्ड' : 'Debit / Credit Card';

      case 'card_sub':
        return isHindi ? 'Visa, Mastercard, Rupay' : 'Visa, Mastercard, Rupay';

      case 'subtotal':
        return isHindi ? 'उप-योग' : 'Subtotal';

      case 'delivery_fee':
        return isHindi ? 'डिलीवरी शुल्क' : 'Delivery Fees';

      case 'total':
        return isHindi ? 'कुल राशि' : 'Total';

      case 'items':
        return isHindi ? 'आइटम' : 'Items';

      case 'place_order':
        return isHindi ? 'ऑर्डर करें' : 'Place Order';

      case 'product':
        return isHindi ? 'उत्पाद' : 'Product';

      case 'no_address':
        return isHindi ? 'पता उपलब्ध नहीं है' : 'No Address Found';

      case 'ordered':
        return isHindi ? 'ऑर्डर किया गया' : 'Ordered';

      case 'packed':
        return isHindi ? 'पैक किया गया' : 'Packed';

      case 'shipped':
        return isHindi ? 'भेज दिया गया' : 'Shipped';

      case 'delivered':
        return isHindi ? 'डिलीवर किया गया' : 'Delivered';

      case 'order_details':
        return isHindi ? 'ऑर्डर विवरण' : 'Order Details';

      case 'order_tracking':
        return isHindi ? 'ऑर्डर ट्रैकिंग' : 'Order Tracking';

      case 'delivery_address':
        return isHindi ? 'डिलीवरी पता' : 'Delivery Address';

      case 'download_invoice':
        return isHindi ? 'इनवॉइस डाउनलोड करें' : 'Download Invoice';

      case 'delivery_boy':
        return isHindi ? 'डिलीवरी बॉय' : 'Delivery Boy';

      case 'driver_on_way':
        return isHindi ? 'ड्राइवर रास्ते में है' : 'Driver on the way';

      case 'track_order':
        return isHindi ? 'ऑर्डर ट्रैक करें' : 'Track Order';

      case 'live_tracking':
        return isHindi ? 'लाइव ट्रैकिंग' : 'Live Tracking';

      case 'delivery_person_name':
        return isHindi ? 'अंकित शर्मा' : 'Ankit Sharma';

      case 'cancel_order':
        return isHindi ? 'ऑर्डर रद्द करें' : 'Cancel Order';

      case 'estimated_time':
        return isHindi ? 'अनुमानित समय' : 'Estimated Time';

      case 'search_hint':
        return isHindi
            ? 'स्टोर, उत्पाद खोजें...'
            : 'Search stores, products...';

      case 'recent_searches':
        return isHindi ? 'हाल की खोजें' : 'Recent Searches';

      case 'milkStore':
        return isHindi ? 'दूध की दुकान' : 'Milk Store';

      default:
        return key;
    }
  }
}

// ===================== DELEGATE =====================

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// ===================== LOOKUP =====================

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    default:
      throw FlutterError('Unsupported locale: $locale');
  }
}
