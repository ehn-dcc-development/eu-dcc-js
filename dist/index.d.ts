declare module 'eu-dcc-lib' {
  /**
   * Decode an EU DCC Certificate.
   * @param hcert EU DCC Certificate 
   */
  export function decode(name: string): any;
  /**
   * Decode a QR Code Image.
   * @param qr base64 image
   */
  export function decode_qr(qr: string): any;

  /**
   * Verify and decode an EU-DCC Certificate. Throws an error if COSE verification fails
   * @param hcert EU DCC Certificate 
   * @param pem Digital Signature Certificate in pem format
   */
  export function verify(hcert: string, pem: string): any;
}
