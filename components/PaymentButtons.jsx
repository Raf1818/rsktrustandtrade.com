import React, { useState } from 'react';

export default function PaymentButtons() {
  const bscAddress = "0xa5c21334b270F1f4d7ccF06ABc935c983Db94609";
  const paypalLink = "https://www.paypal.com/ncp/payment/23JD9HVB65WFY";
  const whatsappNumber = "573138734968";
  const [copied, setCopied] = useState(false);
  const qrData = bscAddress;
  const copyToClipboard = () => {
    navigator.clipboard.writeText(bscAddress);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };
  const defaultText = "Hallo RSK Trust, ich habe mit BSC bezahlt. Meine TXID: ";
  const whatsappCheck = `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(defaultText)}`;
  return (
    <div className="max-w-4xl mx-auto my-10 px-4">
      <h2 className="text-3xl font-bold text-center mb-2">Zahlungsmethode wahlen</h2>
      <div className="grid md:grid-cols-2 gap-6">
        <div className="bg-white rounded-3xl shadow-xl p-8 text-center border">
          <h3 className="text-2xl font-bold mb-2">Mit PayPal</h3>
          <a href={paypalLink} target="_blank" rel="noopener noreferrer" className="bg-[#0a4fb3] text-white font-bold py-3 px-8 rounded-full text-xl inline-block w-full">Fur $5 kaufen</a>
        </div>
        <div className="bg-white rounded-3xl shadow-xl p-8 text-center border">
          <h3 className="text-2xl font-bold mb-1">Mit Crypto (BSC)</h3>
          <div className="bg-white p-2 rounded-2xl inline-block border">
            <img src={`https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${qrData}`} alt="BSC QR" className="w-[200px] h-[200px]" />
          </div>
          <div className="mt-4">
            <p className="text-xs font-mono break-all text-gray-600 bg-gray-50 p-2 rounded border mb-2">{bscAddress}</p>
            <button onClick={copyToClipboard} className="text-xs bg-black text-white py-2 px-4 rounded-full w-full">{copied? "✓ Kopiert!" : "Adresse kopieren"}</button>
          </div>
          <a href={whatsappCheck} target="_blank" rel="noopener noreferrer" className="mt-3 bg-[#25D366] text-white text-sm font-bold py-2 px-4 rounded-full inline-block w-full text-center">Bezahlt - WhatsApp TXID senden</a>
        </div>
      </div>
    </div>
  );
}
