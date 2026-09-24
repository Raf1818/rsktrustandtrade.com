import React, { useState } from 'react';

export default function PaymentButtons({ lang = 'de' }) {
  const bscAddress = "0xa5c21334b270F1f4d7ccF06ABc935c983Db94609";
  const paypalLink = "https://www.paypal.com/ncp/payment/23JD9HVB65WFY";
  const whatsappNumber = "573138734968";
  const [copied, setCopied] = useState(false);

  const copyToClipboard = () => {
    navigator.clipboard.writeText(bscAddress);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const t = {
    de: { title: "Zahlungsmethode wählen", paypal: "Mit PayPal", buy: "Für $5 kaufen", crypto: "Mit Crypto (BSC)", copy: "Adresse kopieren", copied: "✓ Kopiert!", wa: "Bezahlt - WhatsApp TXID senden", waText: "Hallo RSK Trust, ich habe mit BSC bezahlt. Meine TXID: " },
    en: { title: "Choose payment method", paypal: "With PayPal", buy: "Buy for $5", crypto: "With Crypto (BSC)", copy: "Copy address", copied: "✓ Copied!", wa: "Paid - Send TXID via WhatsApp", waText: "Hello RSK Trust, I paid with BSC. My TXID: " },
    es: { title: "Elige método de pago", paypal: "Con PayPal", buy: "Comprar por $5", crypto: "Con Crypto (BSC)", copy: "Copiar dirección", copied: "✓ ¡Copiado!", wa: "Pagado - Enviar TXID por WhatsApp", waText: "Hola RSK Trust, pagué con BSC. Mi TXID: " },
    fr: { title: "Choisir le mode de paiement", paypal: "Avec PayPal", buy: "Acheter pour $5", crypto: "Avec Crypto (BSC)", copy: "Copier l'adresse", copied: "✓ Copié!", wa: "Payé - Envoyer TXID via WhatsApp", waText: "Bonjour RSK Trust, j'ai payé avec BSC. Mon TXID: " },
    pt: { title: "Escolha a forma de pagamento", paypal: "Com PayPal", buy: "Comprar por $5", crypto: "Com Crypto (BSC)", copy: "Copiar endereço", copied: "✓ Copiado!", wa: "Pago - Enviar TXID via WhatsApp", waText: "Olá RSK Trust, paguei com BSC. Meu TXID: " },
    ru: { title: "Выберите способ оплаты", paypal: "Через PayPal", buy: "Купить за $5", crypto: "Криптой (BSC)", copy: "Копировать адрес", copied: "✓ Скопировано!", wa: "Оплачено - Отправить TXID в WhatsApp", waText: "Привет RSK Trust, я оплатил через BSC. Мой TXID: " },
    zh: { title: "选择支付方式", paypal: "通过 PayPal", buy: "支付 $5 购买", crypto: "加密货币 (BSC)", copy: "复制地址", copied: "✓ 已复制!", wa: "已付款 - 通过 WhatsApp 发送 TXID", waText: "你好 RSK Trust，我已通过 BSC 付款。我的 TXID: " },
    ar: { title: "اختر طريقة الدفع", paypal: "عبر PayPal", buy: "شراء مقابل $5", crypto: "بالعملات الرقمية (BSC)", copy: "نسخ العنوان", copied: "✓ تم النسخ!", wa: "تم الدفع - إرسال TXID عبر واتساب", waText: "مرحبا RSK Trust، دفعت عبر BSC. معرف العملية: " }
  }[lang] || { title: "Zahlungsmethode wählen", paypal: "Mit PayPal", buy: "Für $5 kaufen", crypto: "Mit Crypto (BSC)", copy: "Adresse kopieren", copied: "✓ Kopiert!", wa: "Bezahlt - WhatsApp TXID senden", waText: "Hallo RSK Trust, ich habe mit BSC bezahlt. Meine TXID: " };

  const whatsappCheck = `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(t.waText)}`;

  return (
    <div className="max-w-4xl mx-auto my-10 px-4">
      <h2 className="text-3xl font-bold text-center mb-2">{t.title}</h2>
      <div className="grid md:grid-cols-2 gap-6">
        <div className="bg-white rounded-3xl shadow-xl p-8 text-center border">
          <h3 className="text-2xl font-bold mb-2">{t.paypal}</h3>
          <a href={paypalLink} target="_blank" rel="noopener noreferrer" className="bg-[#0a4fb3] text-white font-bold py-3 px-8 rounded-full text-xl inline-block w-full">{t.buy}</a>
        </div>
        <div className="bg-white rounded-3xl shadow-xl p-8 text-center border">
          <h3 className="text-2xl font-bold mb-1">{t.crypto}</h3>
          <div className="bg-white p-2 rounded-2xl inline-block border">
            <img src={`https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${bscAddress}`} alt="BSC QR" className="w-[200px] h-[200px]" />
          </div>
          <div className="mt-4">
            <p className="text-xs font-mono break-all text-gray-600 bg-gray-50 p-2 rounded border mb-2">{bscAddress}</p>
            <button onClick={copyToClipboard} className="text-xs bg-black text-white py-2 px-4 rounded-full w-full">{copied? t.copied : t.copy}</button>
          </div>
          <a href={whatsappCheck} target="_blank" rel="noopener noreferrer" className="mt-3 bg-[#25D366] text-white text-sm font-bold py-2 px-4 rounded-full inline-block w-full text-center">{t.wa}</a>
        </div>
      </div>
    </div>
  );
}
