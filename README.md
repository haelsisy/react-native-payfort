# React Native PayFort

A react native wrapper for PayFort SDK.


# Install

1.Download and follow the installation steps in PayFort documentation

>  https://docs.payfort.com/docs/mobile-sdk/build/index.html#download

 2.Run

> npm install react-native-payfort --save
>  react-native link react-native-payfort

# Usage

    let { Payfort } = require('react-native').NativeModules;
    ........
    let options = {
      access_code: '', // Access Code
      command: 'AUTHORIZATION', //Command (AUTHORIZATION, PURCHASE)
      merchant_identifier: '', //The Merchant Identifier
      merchant_reference: 'XYZ9239-yu8100', //The Merchant’s unique order number (XYZ9239-yu8100)
      merchant_extra: '', //Extra data sent by merchant. Will be received and sent back as received. Will not be displayed in any report
      merchant_extra1: '', //Extra data sent by merchant. Will be received and sent back as received. Will not be displayed in any report
      merchant_extra2: '', //Extra data sent by merchant. Will be received and sent back as received. Will not be displayed in any report
      merchant_extra3: '', //Extra data sent by merchant. Will be received and sent back as received. Will not be displayed in any report
      merchant_extra4: '', //Extra data sent by merchant. Will be received and sent back as received. Will not be displayed in any report
      customer_name: '', //The customer’s name
      customer_email: 'email@domain.com', //The customer’s email (email@domain.com)
      phone_number: '', //The customer’s phone number.
      payment_option:'', //Payment option (MASTERCARD,VISA,AMEX)
      language: 'en', // The checkout page and messages language (en, ar)
      currency: 'EGP', //The currency of the transaction’s amount in ISO code 3 (EGP)
      amount: '1000', //The transaction’s amount
      eci: 'ECOMMERCE', //Ecommerce indicator (ECOMMERCE)
      order_description: '' //A description of the order
    };
    Payfort.initPayfort(options, (err, results) => {
      if (err) {
          console.log("error initializing Payfort: ", err);
          return;
      }
      // Payfort initialized...
      console.log(results)
    });

# Test Card Details

You want to test a transaction but you don’t have a credit card or user credentials for our other payments options? Well we’ve got your back, here you can find card numbers for any type of test you wish to do.

### Credit Cards
| CARD TYPE | NUMBER | EXPIARY DATE | CVV / CVC | 
|--|--|--|--|
| Visa | 4005550000000001 | 05/21 | 123 |
| MasterCard | 5123456789012346 | 05/21 | 123 |
| AMEX | 345678901234564 | 05/21 | 1234 |

### 3-D Secure Credit Cards
| CARD TYPE | NUMBER | EXPIARY DATE | CVV / CVC |
|--|--|--|--|
| Visa | 4557012345678902 | 05/21 | 123 |
| MasterCard | 5313581000123430 | 05/21 | 123 |
| AMEX | 374200000000004 | 05/21 | 1234 |

### Local Payment Methods
####

| PAYMENT OPTION | NUMBER | EXPIARY DATE | CVV / CVC
|--|--|--|--|
| Knet | 0000000001 | 05/17 | 1234

####

| PAYMENT OPTION | NUMBER | EXPIARY DATE | OTP | PIN
|--|--|--|--|--|
| Naps | 4215375500883243 | 06/17 | 1234 | 1234

####

| PAYMENT OPTION | PAYMENT ID | PASSWORD | OTP |
|--|--|--|--|
| Sadad | sadadOlpTest | 1234 | 112358 |

####

| PAYMENT OPTION | NUMBER | CARD TYPE |
|--|--|--|
| E-dirham | 4724439901004942 | Gold Card |

### Digital Wallets

| PAYMENT OPTION | NUMBER | EXPIARY DATE | CVV / CVC |
|--|--|--|--|
| MasterPass | 4000000000000002 | 05/21 | 123 |
| Visa Checkout | 4000000000000002 | 05/21 | 123 |

