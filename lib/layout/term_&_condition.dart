import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TearmsCondiion extends StatefulWidget {
  const TearmsCondiion({
    Key? key,
  }) : super(key: key);
  @override
  State<TearmsCondiion> createState() => _TearmsCondiionState();
}

class _TearmsCondiionState extends State<TearmsCondiion> {
  final String _markdownData = """
  # Tearm & Condition
  # link https://sites.google.com/view/homeplex/home
  ---
  ## Services
  ### - The Services include the provision of the Platform that enables you to arrange schedule different home-based services with independent third-party services providers of those services (“Service Professionals”). As a part of  the Services, Homeplex facilitates the transfer of payments to Service Professionals for the services they render to you and collects payments on behalf of such Services Professionals.
  ### - Homeplex does not provide the Pro Services and is not responsible for their provision. Services Professionals are solely liable and responsible for the Pro Services that they offer or otherwise provide through the Platform. Homeplex and its affiliates do not employ services professionals, nor are service professionals agents, contractors, or partners of Homeplex or its affiliates. Services professionals do not have the ability to bind or represent Homeplex.
  ### - A key part of the services is Homeplex’s ability to send you text messages, electronic mails, or whatsapp messages, including in connection with your bookings, your utilisation of the services, or as a part of its promotional and marketing strategies. While you may opt out of receiving these text messages by contacting Homeplex at privacy@Homeplex.com or through the in-platform setting, you agree and acknowledge that this may  impact Homeplex’s ability to provide the Services (or a part of the services) to you.
  ## CONSENT TO USE DATA
### - You agree that we may, in accordance with our privacy policy, collect and use your personal data. The privacy policy is available at https://nitishsingh44.weebly.com/pravacy-Homeplex and it explains the categories of personal data that we collect or otherwise process about you and the manner in which we process such data.
### - Subject to applicable laws, we may be directed by law enforcement agencies or the government and related bodies to disclose data in relation to you in connection with criminal or civil proceedings. You understand and agree that in such instances we shall have the right to share such data with relevant agencies or bodies.
## Bookings
## orders :
###  - The platform permits you to request various pro services at a time of your choosing based on available slots. To make a booking, you should follow the instructions on the platform and provide necessary information. We use reasonable efforts to enable you to find a services professional who is able to provide that service at the requested time. If, in the unlikely event we cannot find a service professional for the specific timeslot, we will contact you to find an alternative time. 
## Confirmation:
 ### -  once you place a request we will provide confirmation of the booking via SMS, email or a push notification. Once your booking has been confirmed, you will be required to make that payment in accordance with the terms or as indicated on the platform. Once a service professional has been identified.
## Cancellations:
 ### -  Bookings that are cancelled before confirmation on the platform will not be charged. Homeplex’s cancellation policy sted out application cancellations fees.
## - Substitution: 
### - In case of the unavailability of, or cancellation by a selected service professional, we will offer you a substitute of the service professional from among our registered services professionals. 

## PRICING, FEES, AND PAYMENT TERMS: -
### Homeplex reserves the right to charge you for the different services you may avail and/or for any other facilities you may opt for, from time to time, on or via the platform.
## Charges and fees in respect of pro services: -
### -  Homeplex reserves the right to charge you a convenience fee for facilitating the booking and transferring payments to the services professional (this fee is referred to as “fees”). You acknowledge that the final bill you receive may include additional charges, including without limitation, a safety fee, warranty fee, insurance fee, or service professional welfare fee.
### -  Homeplex shall notify you of the applicable charges, fees, and payment methods at the time of booking. Generally, you may make payments for pro services through credit cards, debit cards, net banking, wallets, esewa ,fonepay, or cash upon completion of the pro services. We have the right to modify and otherwise restrict the modes of payment available to you. You acknowledge that certain payment methods such as cash upon completion may not always be available to you as a payment method. For the avoidance of doubt, in the event you pay through the method of cash upon completion, you acknowledge that you will be required to pay bothe charges and fees to the service professional.
### -  The charges and fees may be payable at the time of making a booking, or upon the completion of the pro service, as specified by Homeplex.
### -  For the avoidance of doubt, please note that the charges are payable to service professionals, and Homeplex acts as a limited collection agency on behalf of such services professionals to collect and transfer amounts due to them.
### -   Taxes: - All charges and fees are inclusive of applicable taxes.
### -  Homeplex reserves the right to reasonably amend the charges and fees at any time at its sole discretion. A change in fees shall not impact any bookings that have been confirmed before fees on the platform.
### -  Charges and fees that you pay are final and non-refundable, unless otherwise determined by Homeplex or required by the applicable laws. Under certain laws, you may be entitled to a refund or other remedies for a failure in the provision of the services.
### -  You acknowledge and agree that charges and fees applicable in certain geographical areas may increase substantially during times o f high demand. Homeplex will use reasonable efforts to inform you of the charges and fees that may apply. However, by using the pro services, you will be responsible for the charges and fees incurred under your account regardless of your awareness of such charges or fees.
## Payment processors: 
### - We may use a third party payment processor (“payment processor”) to bill you through your select mode of payment. The processing of payments will be subject to the terms and policies of such payment processors in addition to these terms. We shall not be liable for any error of the payment processor. In the event of any unsuccessful payment, the money debited shall be credited in accordance with the terms of the payment processor.
##Cancellation:
 ### - you may elect to cancel your request for services from a service professional at any time prior to such service professional’s arrival, in which case you may be charged a cancellation fee in accordance with Homeplex’s cancellation.
## Subscriptions:
 ### -  Homeplex may from time to time offer subscription packages (how so over named) for monetary consideration. The packages shall provide customers with additional benefits, which may include the ability to avail discounted pro services. You agree that subscription packages (howsoever named) shall be subject to additional terms and conditions. You acknowledge that such subscription terms and conditions will be deemed to be an integral part of these terms.
### - Homeplex does not designate any portion of your payment as a tip or gratuity to the service professional. Any representation by Homeplex to the effect that tipping is “voluntary”, “not required”, and/or “included” in the payments you make for pro services is not intended to suggest that Homeplex provides any additional payments to service professionals. You understand and agree that while you are free to provide additional payment as a gratuity to any service professional who provides you with pro services you are under obligation to do so. Gratuities are voluntary.

  ## Your responsibilities
### - You represent and warrant that all information that you provide in relation to the services and pro services is complete, true, and correct on the date of agreeing to these terms and shall continue to be complete, true and correct while you avail the services and/or the pro services. Should any information that you provide change during the existence of these terms, you undertake to immediately bring such change to our notice. We do not accept any responsibility or liability for any loss or damages that you may suffer or incur if any information, documentation material, or data, provided to avail the services is incorrect, incomplete, inaccurate or misleading or if you fail to disclose any material fact.
### - You shall extend all cooperation to us in our defence of any proceedings that may be initiated against us due to a breach of your obligations or covenants under these terms. 
### - In respect of the user content, you represent and warrant that:
### (i). You own all intellectual property rights (or have obtained all necessary permissions) to provide user content and to grant the licences under these terms;
### (ii). You are solely responsible for all activities that occur on or through your account on the platform and all user content;
### (iii). The user content does not and shall not violate any of your obligations or responsibilities under other agreements;
### (iv). The user content does not and shall not violate, infringe, or misappropriate any intellectual property right or other proprietary right including the right of publicity or privacy of any person or entity;
 ### (v). The user content does not and shall not contain any viruses, corrupted data, or other harmful, disruptive, or destructive files or content;
## MISCELLANEOUS PROVISIONS
### (a). changes to Teams:The teams are subjected to revision at any time as determined by us , and all changes are effective immediate upon being posted  on the plateform. it is your responsibility to review these Teams periodically for the updated.
###  Notices: All notices ,request ,demands and determination for us under these teams .
### Third party Rights: No third party shall have any right to enforced any terms cobtained herein. 
 ## Force majeure:
 ### we shall have no liability to you if are prevented form or delayed in performing our obligation ,or form carring on our business by act event omission, or accident beyond our reasonable control including without limitation, strikes, faliure of a utility services or telecommuncation network act of god,war riot,civil commotion Malicious damage ,or compliance with any law or government order,rule,regulation,or direction 
  ## Contact
  ### Questions,comments and requests regarding this policy should be addressed to: support@Homeplex.com.phoneno: 9862287720
 ## support 
### Name:Nikhil shanker, Nitish singh,Shraban shah
 """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRIVACY POLICY"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Markdown(
          data: _markdownData,
        ),
      ),
    );
  }
}
