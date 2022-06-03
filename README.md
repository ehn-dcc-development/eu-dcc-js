This small library reads a DCC QR code in the browser, it takes an HCERT string as input.

# Using

Just include `src/dcc-lib-bundle.js` in your project

# Building

First install:

* NPM
* Browserify

Then to build the library:
```
npm run build
```
or
```
browserify src/dcc.js --standalone eu-dcc-lib > dist/index.js
```

If you want to play around with the library then you can play with `src/index.js` and build that:

```
npm start
```

or

```
browserify src/index.js > dist/bundle.js
```

Then you can serve it with npx:

```
npx serve

```

Which by default will serve the index at:

```
http://localhost:3000
```

## Test with Node
Edit the `src/index.js` and run:

```
node src/index.js
``` 
or 
```
npm run demo
```

## Use it in Angular
Install the [EU DCC Library](https://www.npmjs.com/package/eu-dcc-lib):
```
npm -i eu-dcc-lib
```

Import:
```
import * as eudcc from 'eu-dcc-lib';
```
and decode
```js
const hcert= 'HC1:NCFTW2H...';
const dcc = eudcc.decode(hcert);
```
of verify 
```js
const hcert = 'HC1:NCFTW2H...';
const pem = `-----BEGIN CERTIFICATE-----\nMIIBvTCCAWOgAwIBA...\n-----END CERTIFICATE-----`;
const dcc = eudcc.verify(hcert, pem);
```

### Example 
Test project in Angular
* [Live demo](https://skounis.github.io/sk-dcc-lib-test-angular/) 
* [Source code](https://github.com/skounis/sk-dcc-lib-test-angular) 


## Notes 
### Load the bundle 
Build the `dist/indes.js` and copy it in the folder `src/assets/js/dcc-lib-bundle.js` in the Angular project. 

Edit the `angular.json` file and add a reference to it:
```json
    "scripts": [
        "src/assets/dcc-lib-bundle.js"
    ]
```

The section will look like:
```json
    "architect": {
    "build": {
        "builder": "@angular-devkit/build-angular:browser",
        "options": {
        "outputPath": "dist/dcc-validation-wire",
        "index": "src/index.html",
        "main": "src/main.ts",
        "polyfills": "src/polyfills.ts",
        "tsConfig": "tsconfig.app.json",
        "assets": [
            "src/favicon.ico",
            "src/assets"
        ],
        "styles": [
            "./node_modules/@angular/material/prebuilt-themes/indigo-pink.css",
            "src/styles.css"
        ],
        "scripts": [
            "src/assets/dcc-lib-bundle.js"
        ]
        },
    ...
    }
```

### Use the library in a component
In the component declare the library 

```js
declare const dccLib: any;
```

Use the library
```js
const hcert1 = "HC1:NCFTW2H:7*I06R3W/J:O6:P4QB3+7RKFVJWV66UBCE//UXDT:*ML-4D.NBXR+SRHMNIY6EB8I595+6UY9-+0DPIO6C5%0SBHN-OWKCJ6BLC2M.M/NPKZ4F3WNHEIE6IO26LB8:F4:JVUGVY8*EKCLQ..QCSTS+F$:0PON:.MND4Z0I9:GU.LBJQ7/2IJPR:PAJFO80NN0TRO1IB:44:N2336-:KC6M*2N*41C42CA5KCD555O/A46F6ST1JJ9D0:.MMLH2/G9A7ZX4DCL*010LGDFI$MUD82QXSVH6R.CLIL:T4Q3129HXB8WZI8RASDE1LL9:9NQDC/O3X3G+A:2U5VP:IE+EMG40R53CG9J3JE1KB KJA5*$4GW54%LJBIWKE*HBX+4MNEIAD$3NR E228Z9SS4E R3HUMH3J%-B6DRO3T7GJBU6O URY858P0TR8MDJ$6VL8+7B5$G CIKIPS2CPVDK%K6+N0GUG+TG+RB5JGOU55HXDR.TL-N75Y0NHQTZ3XNQMTF/ZHYBQ$8IR9MIQHOSV%9K5-7%ZQ/.15I0*-J8AVD0N0/0USH.3";
const dcc = dccLib.decode_hcert(hcert1);

console.log(dcc);
console.log(JSON.stringify(dcc, null, 2));
```

## References
* Similar library https://fuubi.github.io/digital-covid-certificate-lib/index.html https://github.com/fuubi/digital-covid-certificate-lib
