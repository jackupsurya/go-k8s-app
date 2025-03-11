# Go-K8s-App

## 🚀 Overview
Go-K8s-App is a simple Go web application deployed using Docker and Kubernetes with CI/CD automation via Jenkins.

## 📌 Prerequisites
Ensure you have the following installed:

- **Go** (>=1.20) → [Install Go](https://golang.org/dl/)
- **Docker** → [Install Docker](https://docs.docker.com/get-docker/)
- **Kubernetes (kubectl & minikube or k3d)** → [Install K8s](https://kubernetes.io/docs/setup/)
- **Jenkins** → [Install Jenkins](https://www.jenkins.io/download/)
- **Git** → [Install Git](https://git-scm.com/downloads)
- **Ngrok (Optional for Webhook Exposure)** → [Install Ngrok](https://ngrok.com/download)

---

## 📂 Project Structure
```
go-k8s-app/
│── main.go
│── Dockerfile
│── deployment.yaml
│── service.yaml
│── Jenkinsfile
│── README.md
```

---

## 🔧 Setup & Installation

### 1️⃣ **Clone the Repository**
```sh
git clone https://github.com/jackupsurya/go-k8s-app.git
cd go-k8s-app
```

### 2️⃣ **Run Locally**
```sh
go mod tidy
go run main.go
```
Application runs on **`http://localhost:8080`**.

---

## 🐳 **Docker Setup**

### 3️⃣ **Build & Run Docker Image**
```sh
docker build -t go-k8s-app .
docker run -p 8080:8080 go-k8s-app
```

---

## ☸ **Kubernetes Deployment**

### 4️⃣ **Start Minikube or k3d**
```sh
minikube start  # Or use k3d if preferred
```

### 5️⃣ **Apply Kubernetes Configuration**
```sh
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### 6️⃣ **Check Deployment & Service**
```sh
kubectl get pods
kubectl get svc
```

Expose service if needed:
```sh
minikube service go-k8s-app --url
```

---

## 🔄 **CI/CD with Jenkins**

### 7️⃣ **Install Jenkins Plugins**
1. Go to **Manage Jenkins** → **Manage Plugins**.
2. Install:
   - `Pipeline`
   - `Docker Pipeline`
   - `Git Plugin`
   - `Kubernetes CLI Plugin`

### 8️⃣ **Setup Jenkins Pipeline**
1. Open **Jenkins (`http://localhost:8080`)**.
2. Create a **new pipeline project**.
3. In **Pipeline Definition**, select `Pipeline script from SCM`.
4. Set Repository URL: `https://github.com/jackupsurya/go-k8s-app.git`.
5. Save & Build.

---

## 📡 **Webhook for Automatic Deployment**

### 9️⃣ **Expose Jenkins to GitHub** (if running locally)
Use **ngrok** to expose Jenkins:
```sh
ngrok http 8080
```

Copy the public URL (`https://randomstring.ngrok.io`).

### 🔟 **Setup GitHub Webhook**
1. Go to **GitHub Repo** → **Settings** → **Webhooks**.
2. Set **Payload URL**: `https://randomstring.ngrok.io/github-webhook/`.
3. Choose **Just the push event**.
4. Save.

---

## 🎯 **Triggering Deployment**
1. Make a Git commit & push.
```sh
git add .
git commit -m "Updated application"
git push origin main
```
2. Jenkins will automatically:
   - Pull code
   - Build & push Docker image
   - Deploy to Kubernetes

---

## ✅ **Verify Deployment**
Check running services:
```sh
kubectl get pods
kubectl get svc
```
Access the service:
```sh
curl http://<EXTERNAL-IP>:8080
```
Or via Minikube:
```sh
minikube service go-k8s-app --url
```

---

## 🛑 **Cleanup**
To delete Kubernetes resources:
```sh
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
```
To stop Minikube:
```sh
minikube stop
```
To remove Docker image:
```sh
docker rmi go-k8s-app
```

---

## 🎉 **Done! Your Go-K8s-App is now fully automated!** 🚀