FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /App

COPY fiap-githubactions-01.csproj ./
RUN dotnet restore --verbosity detailed

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /App

COPY --from=build-env /App/out ./

ENTRYPOINT ["dotnet", "fiap-githubactions-01.dll"]
