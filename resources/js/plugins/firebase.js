


import { initializeApp } from "firebase/app";


import { getAuth } from 'firebase/auth';
// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyD5PoC0YIOT_VmaQNUNj7ASXc_mtPeQ1hs",
    authDomain: "myproject-d5660.firebaseapp.com",
    projectId: "myproject-d5660",
    storageBucket: "myproject-d5660.appspot.com",
    messagingSenderId: "783540954294",
    appId: "1:783540954294:web:913a607a0994005bdbf217"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app)
export default app