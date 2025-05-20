___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Roadtrip Explorer",
  "categories": ["ADVERTISING", "ANALYTICS", "MARKETING", "REMARKETING"],
  "brand": {
    "id": "roadtrip_technologies_explorer",
    "displayName": "Roadtrip Technologies B.V."
  },
  "description": "explorer applies",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "roadtrip_client_uuid",
    "displayName": "Roadtrip Client UUID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "roadtrip_unique_id",
    "displayName": "Roadtrip Unique ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "ats_job_id",
    "displayName": "ATS Job ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "ats_job_title",
    "displayName": "ATS Job Title",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "ats_application_id",
    "displayName": "ATS Application ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "google_client_id",
    "displayName": "Google Client ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "google_session_id",
    "displayName": "Google Session ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "facebook_id",
    "displayName": "Facebook ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "linked_in_id",
    "displayName": "LinkedIn ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "client_application_timestamp",
    "displayName": "Client Application Timestamp",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const sendPixel = require('sendPixel');
const encodeUriComponent = require('encodeUriComponent');

function buildQueryString(obj) {
  var parts = [];
  for (var key in obj) {
    if (obj.hasOwnProperty(key) && obj[key] != null) {
      var encodedKey = encodeUriComponent(key);
      var encodedValue = encodeUriComponent(obj[key]);
      parts.push(encodedKey + '=' + encodedValue);
    }
  }
  return parts.join('&');
}

var url = 'https://muuh.roadtrip.agency/api/v2/apply';

var postData = {
  roadtripClientUuid: data.roadtrip_client_uuid,
  roadtripUniqueId: data.roadtrip_unique_id,
  atsJobId: data.ats_job_id,
  atsJobTitle: data.ats_job_title,
  atsApplicationId: data.ats_application_id,
  googleClientId: data.google_cid,
  googleSessionId: data.google_sid,
  facebookId: data.facebook_id,
  linkedInId: data.linked_in_id,
  utmSource: data.utm_source,
  utmMedium: data.utm_medium,
  utmCampaign: data.utm_campaign,
  utmTerm: data.utm_term,
  utmContent: data.utm_content,
  clientApplicationTimestamp: data.client_application_timestamp,
};

var queryString = buildQueryString(postData);

var pixelUrl = url + '?' + queryString;

sendPixel(pixelUrl);

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://muuh.roadtrip.agency/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2025, 2:12:24 PM


