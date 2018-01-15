# CSO-CloudFlare
CloudFlare korumali web sitesinin gercek IP'sini tanimlayan arac.
CSO-CloudFlare Ruby'de insa edilir. Gercek IP kesfetmek icin CloudFlare'de bypass yapar.
Sunucunuzu ve web sitenizi test etmeniz gerekiyorsa bu yararli olabilir.
Korumanizi Dos (Hizmet Reddini) veya Dos'a karsı test edin.
CloudFlare, ziyaretciyle Cloudflare kullanicisinin barindirma saglayicisi arasinda oturan ve web siteleri icin bir ters proxy olarak gorev yapan servisler ve dagıtilan alan adi sunucusu servisleridir.
Aginiz bir DNS degisikligi ile bir web sitesi veya mobil uygulama icin kullanilabilirligi korur, hizlandirir ve gelistirir.

Version: 1.0

<em>Kullanım:</em>
<strong>ruby cso-cloudflare.rb -h yada --help </strong><br />
<strong>ruby cso-cloudflare.rb -b hedef site </strong> <br />
or<br />
<strong>ruby cso-cloudflare.rb --byp hedef site </strong><br />
<strong> Yardim icin "./cso-cloudflare.rb --help" yazip enter tusuna basiniz.</strong><br />
