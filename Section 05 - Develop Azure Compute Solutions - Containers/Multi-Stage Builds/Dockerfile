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