import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';

class TermsandConditionsPage extends StatelessWidget {
  const TermsandConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 0,
        backgroundColor: const Color(0XFF6f6cd9),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Welcome to Hotel Booking!'
                '\n\nThese terms and conditions outline the rules and regulations for the use of Hotel Booking.\n\nBy using this app we assume you accept these terms and conditions. Do not continue to use Hotel Booking if you do not agree to take all of the terms and conditions stated on this page.'
                '\n\nThe following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the App Terms and Conditions Generator from App-Privacy-Policy.com.'
                '\n\nLICENSE'
                '\n\nUnless otherwise stated, Hotel Booking and/or its licensors own the intellectual property rights for all material on Hotel Booking. All intellectual property rights are reserved. You may access this from Hotel Booking for your own personal use subjected to restrictions set in these terms and conditions.'
                '\nYou must not:'
                '\n\n\t-Republish material from Hotel Booking'
                '\n\t-Sell, rent or sub-license material from Hotel Booking'
                '\n\t-Reproduce, duplicate or copy material from Hotel Booking'
                '\n\t-Redistribute content from Hotel Booking'
                '\n\nThis Agreement shall begin on the date hereof.'
                '\n\nParts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Hotel Booking does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Hotel Booking, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Hotel Booking shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.'
                '\n\nHotel Booking reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.'
                '\n\nYou warrant and represent that:\n\n'
                '\t-You are entitled to post the Comments on our App and have all necessary licenses and consents to do so;\n'
                '\t-The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;\n'
                '\t-The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy\n'
                '\t-The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.\n'
                '\nYou hereby grant Hotel Booking a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.\n\n'
                '\n\nHYPERLINKING TO OUR APP\n\n'
                'The following organizations may link to our App without prior written approval:\n'
                '\n\t-Government agencies;\n\t-Search engines;\n\t-News organizations;'
                '\n-Online directory distributors may link to our App in the same manner as they hyperlink to the Websites of other listed businesses; and\n'
                '-System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.'
                '\n\nThese organizations may link to our home page, to publications or to other App information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.'
                '\n\nWe may consider and approve other link requests from the following types of organizations:'
                '\nt-commonly-known consumer and/or business information sources;\n\t-dot.com community sites;\n\t-associations or other groups representing charities;\n\t-online directory distributors;\n\t-internet portals;\n\t-accounting, law and consulting firms; and\n\t-educational institutions and trade associations.\n\nWe will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Hotel Booking; and (d) the link is in the context of general resource information.'
                '\n\nThese organizations may link to our App so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.'
                '\n\nIf you are one of the organizations listed in paragraph 2 above and are interested in linking to our App, you must inform us by sending an e-mail to Hotel Booking. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our App, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.'
                '\n\nApproved organizations may hyperlink to our App as follows:\n\t-By use of our corporate name; or\n\t-By use of the uniform resource locator being linked to; or\n\t-By use of any other description of our App being linked to that makes sense within the context and format of content on the linking party’s site.'
                "\n\nNo use of Hotel Booking's logo or other artwork will be allowed for linking absent a trademark license agreement."
                '\n\n\nIFRAMES\n\n-Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our App.'
                '\n\n\nCONTENT LIABILITY\n\nWe shall not be hold responsible for any content that appears on your App. You agree to protect and defend us against all claims that is rising on our App. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.'
                '\n\n\nYOUR PRIVACY\n\n\tPlease read Privacy Policy.'
                '\n\n\nRESERVATION OF RIGHTS\n\nWe reserve the right to request that you remove all links or any particular link to our App. You approve to immediately remove all links to our App upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our App, you agree to be bound to and follow these linking terms and conditions.'
                '\n\n\nREMOVAL OF LIBKS FROM OUR APP\n\nIf you find any link on our App that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.\n\nWe do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.\n\n\n'
                'DISCLAIMER\n\nTo the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our App and the use of this website. Nothing in this disclaimer will:\n\n'
                '\t-limit or exclude our or your liability for death or personal injury;\n\t'
                '-limit or exclude our or your liability for fraud or fraudulent misrepresentation;\n\t-limit any of our or your liabilities in any way that is not permitted under applicable law; or\n\t-exclude any of our or your liabilities that may not be excluded under applicable law.\n\n'
                'The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.'
                'As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.sourceSansPro(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Constants.ksecondarycolor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBox extends StatefulWidget {
  const CheckBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CheckBoxWidget();
  }
}

class CheckBoxWidget extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text("I have read and accept terms and conditions"),
          ],
        ),
      ),
    );
  }
}
