importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyBcFEAqw12p-OfJegiKVyd_u8zs76Hh1OQ",
  appId: "1:903314051019:web:70c9626022b40fb825f04e",
  messagingSenderId: "903314051019",
  projectId: "ti-tan",
  authDomain: "ti-tan.firebaseapp.com",
  storageBucket: "ti-tan.appspot.com",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      const title = payload.notification.title;
      const options = {
        body: payload.notification.score,
      };
      return registration.showNotification(title, options);
    });
  return promiseChain;
});
self.addEventListener("notificationclick", function (event) {
  console.log("notification received: ", event);
});
