# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj và restore trước (tối ưu cache)
COPY ECommerceMVC.csproj ./
RUN dotnet restore "ECommerceMVC.csproj"

# Copy toàn bộ source code và build
COPY . ./
RUN dotnet publish "ECommerceMVC.csproj" -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Environment (có thể override bằng docker-compose.yml)
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:80

EXPOSE 80
ENTRYPOINT ["dotnet", "ECommerceMVC.dll"]
