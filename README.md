# Custom Maps Project

**Custom Maps Project** is a comprehensive solution designed to quickly and easily create fully interactive maps from static images. 

Unlike simple map viewers, this is an advanced, full-stack project that comes pre-packaged with a complete database structure, a PHP backend API, and a modern frontend ecosystem. It allows you to host deep-zoomable maps with markers, overlays, and custom locations with minimal configuration.

## 🚀 Key Features

- **Interactive Map Viewer**: Based on Leaflet, allowing for deep zoom and smooth navigation.
- **Full-Stack Environment**: 
  - **Database**: PostgreSQL with pre-configured schemas for markers, overlays, and map configurations.
  - **Backend**: Lightweight PHP API connecting the database to the frontend.
  - **Frontend**: Modern Vue 3 application with Pinia state management.
- **Dockerized**: The entire stack (DB, Admin, Backend, CDN, Frontend) runs in Docker containers for instant deployment.
- **Custom Assets**: Support for custom icons, map overlays, and descriptions.

## 🛠 Companion Tool: Pyvips Tile Cutter

This project is designed to work seamlessly with the **Pyvips Tile Cutter**. You do not need to manually slice your map images. 

Use the cutter to generate the necessary tile structure (`/z/x/y`) from your high-resolution images in seconds. No installation required.

- **Project Link**: [Pyvips Tile Cutter GitHub](https://github.com/Demax121/pyvips-tile-cutter)
- **Download Latest Release**: [Release v2](https://github.com/Demax121/pyvips-tile-cutter/releases/tag/%23v2)

## 🏗 Tech Stack

- **Frontend**: Vue.js 3, Vite, SCSS, Leaflet.js
- **Backend**: Native PHP (served via Caddy)
- **Database**: PostgreSQL (managed via PgAdmin 4)
- **Infrastructure**: Docker Compose, Caddy (Web Server & CDN)

## 📦 Project Structure

- `frontend/` - Vue.js application source code.
- `backend/` - PHP API scripts handling database connections and logic.
- `database/` - SQL initialization scripts and Dockerfiles for the DB.
- `cdn/` - Serves static assets (generated map tiles, icons, images).
- `docs/` - Screenshots of ui elements can delete [See Architecture Wiki](docs/WIKI.md).

## 🏁 Getting Started

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed on your machine.
- Map tiles generated using the [Pyvips Tile Cutter](https://github.com/Demax121/pyvips-tile-cutter).

### Installation

1.  **Clone the repository**
    ```bash
    git clone <repository_url>
    cd custom-maps
    ```

2.  **Configure Environment**
    Copy the example environment file and configure your secrets, do not change POSTGRES_HOST and POSTGRES_DB if you don't know what you are doing, .
    ```bash
    cp .env.example .env
    ```

3.  **Add Map Tiles**
    Place your generated map tiles inside the `cdn/assets/maps/` directory.

4.  **Start the Application**
    Run the entire stack using Docker Compose:
    ```bash
    docker-compose up -d --build
    ```

5.  **Access the App**
    - Frontend: `http://localhost:5173` (or configured port)
    - PgAdmin: `http://localhost:5050` (or configured port)

## 📝 Usage

Once running, the application will load the map configuration from the database. You can manage markers, add new maps, and configure overlays directly through the database or the provided API endpoints.

## 📄 License

[MIT](LICENSE)
