
# 🎓 Alumni Network Application

[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![.NET 10.0](https://img.shields.io/badge/Backend-.NET%2010.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL%20(Neon)-4169E1?logo=postgresql)](https://neon.tech)
[![SignalR](https://img.shields.io/badge/Real--Time-SignalR-orange)](https://learn.microsoft.com/en-us/aspnet/core/signalr)
[![Cloudinary](https://img.shields.io/badge/Media-Cloudinary-blue?logo=cloudinary)](https://cloudinary.com)

A full-stack cross-platform community platform designed to bridge the gap between alumni and students. Built with a scalable **.NET Core Web API** backend, **Neon PostgreSQL** database, and a high-performance **Flutter** mobile frontend featuring real-time bi-directional messaging using **SignalR**.

---

## 🌟 Key Features

- 🔐 **Authentication & Authorization:** Secure JWT-based authentication flow with protected endpoint execution.
- 💬 **Real-time Messaging:** Direct chat with real-time delivery status, online/last-seen tracking, and WebSocket auto-reconnection via **SignalR**.
- 📰 **Social Feed & Community:** Create/view interactive posts with photo attachments, likes, and nested comment threads.
- 👥 **Network & Connection Management:** Friend request system (Send, Accept, Reject, Pending) and alumni directory search.
- 👤 **Profile Management:** Detailed alumni profiles including graduation year, department, current job position, and company.
- ☁️ **Cloud Storage Integration:** Fast and optimized image hosting powered by **Cloudinary**.

---
## 🏗 System Architecture
[ Flutter Mobile App ]
│
├── HTTP / REST API (JWT Authenticated) ───► [ .NET Core Web API ] ───► [ Neon PostgreSQL ]
│                                                    │
└── WebSockets / SignalR Hub ────────────────────────┼───► [ Cloudinary Media Storage ]


---
## 🛠 Tech Stack

### **Frontend**
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod / Notifier pattern
- **Real-time Engine:** `signalr_netcore`
- **Networking:** HTTP & REST API Client

### **Backend**
- **Framework:** ASP.NET Core Web API (.NET 10)
- **ORM:** Entity Framework Core (Code-First)
- **Database:** PostgreSQL (Cloud hosted on Neon)
- **Real-Time Communication:** ASP.NET Core SignalR
- **Hosting & Deployment:** Render (Production API)

---

## 🚧 Project Roadmap & Upcoming Features

> *Note: This project is actively being built and refined during my off-work hours.*

- [x] JWT User Auth & Registration
- [x] Feed Post Creation, Like System & Comments
- [x] SignalR Real-time Chat & Online Status
- [ ] 🔐 **Change Password / Security Settings** (In Progress)
- [ ] ↪️ **Post Sharing Functionality** (In Progress)
- [ ] 🔔 **Push Notifications** (FCM Integration)
- [ ] 🔍 **Advanced Alumni Filtering** (By Graduation Year & Company)

---
## 🚀 Getting Started (Local Development)

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.0.0`)
- [.NET 10.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- PostgreSQL Database (Local or Neon Cloud)

### 1. Backend Setup
```bash
# Clone the repository
git clone [https://github.com/YOUR_GITHUB_USERNAME/alumni_network.git](https://github.com/Kixx-10/Alumni_Network_backend.git)

# Navigate to backend directory
cd alumni_network/backend/Alumni

# Update connection string in appsettings.Development.json
# Run Database Migrations
dotnet ef database update

# Start the Web API
dotnet run

📱 Screenshots & Demo
Registratio | Feed & Community | Real-Time Chat | Alumni Profile |
| :---: | :---: | :---: | :---: |
