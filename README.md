# 🐾 MyVet (Swift/SwiftUI)

Versione nativa **Swift + SwiftUI** dell’app **MyVet**, sviluppata come trasposizione dell’originale.
L’app si appoggia al **backend di sviluppo MyVet** tramite chiamate HTTP (REST API).

---

## 📖 Cos’è MyVet?

**MyVet** è l’ecosistema digitale per la cura dei propri animali domestici, sviluppato dall’azienda MyVet.
Il suo core è offrire un insieme di funzionalità integrate per proprietari e veterinari, tra cui:

* 📒 **Libretto Sanitario Elettronico**: tracciamento di visite, terapie e vaccini.
* 👩‍⚕️ **Contatto diretto con il Veterinario**: prenotazione visite e gestione appuntamenti.
* 🥗 **Piano nutrizionale fresco a domicilio**.
* 🗺️ **Mappa interattiva**: scoperta degli specialisti nelle vicinanze.

---

## 🚀 Funzionalità implementate

Questa versione nativa **Swift/SwiftUI** include:

* 👤 **Gestione account**: creazione e autenticazione con **Email/Password** o **Sign in with Apple**.
* 🐶 **Gestione animali**: creazione e gestione dei propri pet.
* 🔍 **Ricerca veterinari**: fuzzy search basata su **ElasticSearch**.
* 🗺️ **Mappa interattiva**: visualizzazione dei veterinari nelle vicinanze.
* 📅 **Prenotazione appuntamenti**: richiedere e gestire le visite direttamente dall’app.
* ⭐ **Preferiti**: salvare i veterinari preferiti.
* 📞 **Contatto rapido**: telefonata o email diretta ai veterinari.
* 🔑 **Autenticazione sicura**: gestione sessione tramite **JWT token** salvato in `LocalStorage`.
* 🎨 **Personalizzazione tema**: supporto a temi chiari/scuri.
* 🖥️ **Supporto MacOS Nativo**: interfaccia personalizzata appositamente per essere buildata tramite AppKit, personalizzando molte schermate tramite tag di compilazione.

---

## 🛠️ Stack Tecnologico

* **Linguaggi**: Swift
* **UI Framework**: SwiftUI
* **Autenticazione**: JWT Token, Sign in with Apple
* **Ricerca**: ElasticSearch
* **Persistenza locale**: UserDefaults / LocalStorage

---

## 📲 Requisiti

* iOS 26+
* Xcode 26+
* Permesso di **MyVet** per l'uso delle proprie API

## 📌 Roadmap

* [ ] Notifiche push per promemoria visite e vaccini

