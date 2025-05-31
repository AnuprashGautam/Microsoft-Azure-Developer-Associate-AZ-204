### 🧱 What is a Multi-Stage Build?

A **multi-stage build** in Docker is a way to **use multiple `FROM` statements** in one Dockerfile to **create smaller and cleaner final images**.

Think of it like this:

> 👨‍🍳 First you cook the dish in a big kitchen (build stage), then you serve it in a small bowl (final stage) — without taking the entire kitchen to the table.

---

### 🤔 Why Use Multi-Stage?

* When building an app (like a .NET, Java, or Node.js app), you usually need tools like compilers, SDKs, and package managers.
* But once the app is built, you **don’t need all those heavy tools** — just the compiled files.
* Multi-stage builds help you:

  * 🚫 Avoid copying unnecessary files.
  * 🧹 Keep the final image small and clean.
  * 🔐 Reduce security risks (fewer tools = fewer vulnerabilities).

---

### 🧾 Full Dockerfile:

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk AS build
WORKDIR /source

COPY *.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet
WORKDIR /app
COPY --from=build /source/out .
ENTRYPOINT ["dotnet", "learningapp.dll"]
```

---

### 🔍 Step-by-Step Explanation

---

### 🏗 Stage 1 — **Build the App**

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk AS build
```

* **Uses the .NET SDK image**.
* It includes all the tools needed to **build, compile, and publish** your .NET app.
* The alias `AS build` lets us refer to this stage later.

---

```dockerfile
WORKDIR /source
```

* Sets the working folder inside the container to `/source`.
* Every command that follows will run in this folder.

---

```dockerfile
COPY *.csproj ./
```

* Copies the `.csproj` file (your project’s configuration file) into the `/source` folder inside the container.
* Why this step separately? Because Docker caches this layer — so if your code changes but the `.csproj` doesn’t, Docker skips restoring packages again.

---

```dockerfile
RUN dotnet restore
```

* Downloads and installs all NuGet packages your project needs (from the `.csproj` file).

---

```dockerfile
COPY . .
```

* Copies **all files** from your current folder (source code, views, etc.) into the container.

---

```dockerfile
RUN dotnet publish -c Release -o out
```

* Compiles and publishes your app in `Release` mode.
* The final, ready-to-run app files are saved in `/source/out`.

---

### 🚀 Stage 2 — **Run the App**

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet
```

* This is a **smaller image** that only has the ASP.NET **runtime** — no build tools or SDK.
* Perfect for running apps, not building them.

---

```dockerfile
WORKDIR /app
```

* Sets the working directory to `/app` inside the runtime container.

---

```dockerfile
COPY --from=build /source/out .
```

* Copies the published app files from the `build` stage's `/source/out` folder into the current stage’s `/app` folder.
* The key part here is: ✅ only the **final, necessary files** are copied — none of the source code or SDK.

---

```dockerfile
ENTRYPOINT ["dotnet", "learningapp.dll"]
```

* This is the **command that runs when the container starts**.
* It tells Docker: “Run this .NET app named `learningapp.dll`”.

---

### ✅ Summary:

| Stage       | What it does                        | Image size           |
| ----------- | ----------------------------------- | -------------------- |
| Build stage | Restores, builds, and publishes app | Large (includes SDK) |
| Final stage | Runs the app only                   | Small & clean        |

---

Let me know if you'd like to [see a visual diagram of this flow](f) or [try building a similar Dockerfile for a Java or Node.js app](f).
