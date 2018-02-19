# React Native PayFort

A react native wrapper for PayFort SDK.


# Install

Download and follow the installation steps in PayFort documentation
 https://docs.payfort.com/docs/mobile-sdk/build/index.html#download
 

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
