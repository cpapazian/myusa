
# Group Profile


## GET /api/v1/profile?schema=

Get the user profile with attributes limited to just those chosen by app owner during app registration in schema format.

+ Parameters

 + schema (required, boolean, `true`)

+ Response 200 (application/json; charset=utf-8)

    {
      "email": "joe@citizen.org",
      "givenName": "Joe",
      "additionalName": null,
      "familyName": "Citizen",
      "homeLocation": {
        "streetAddress": "",
        "addressLocality": null,
        "addressRegion": null,
        "postalCode": null
      },
      "telephone": null,
      "gender": null
    }

## GET /api/v1/profile

Get the user profile with attributes limited to just those chosen by app owner during app registration.

+ Response 200 (application/json; charset=utf-8)

    {
      "title": null,
      "first_name": "Joe",
      "middle_name": null,
      "last_name": "Citizen",
      "suffix": null,
      "address": null,
      "address2": null,
      "city": null,
      "state": null,
      "zip": null,
      "gender": null,
      "marital_status": null,
      "is_parent": null,
      "is_student": null,
      "is_veteran": null,
      "is_retired": "0",
      "email": "joe@citizen.org",
      "phone_number": null,
      "mobile_number": null,
      "uid": "a83dead6-d98d-4377-9e69-eb00488839f5",
      "id": "a83dead6-d98d-4377-9e69-eb00488839f5"
    }
