
$IMAGE_NAME = "salasrandy89/coosalud-backend:latest"
$VPS_USER = "root"
$VPS_IP = "201.219.216.217"
$REMOTE_DIR = "proyect/backend/"
$PORT = 37456

# Construir la imagen de Docker
docker-compose build
Write-Output "Imagen de Docker construida."

# # Etiquetar la imagen
docker tag backend-webapi salasrandy89/coosalud-backend:latest
Write-Output "Imagen etiquetada."

# # Subir la imagen al repositorio
docker push $IMAGE_NAME
Write-Output "Imagen enviada al repositorio."

$remoteCommand = @(
    "cd $REMOTE_DIR || exit 1",
    "docker-compose down",
    "docker image rmi $IMAGE_NAME || echo '⚠️ Imagen no encontrada, continuando...'",
    "docker-compose up -d"
) -join "; "


# 4. Comandos remotos como una sola línea

Write-Host "Conectando al VPS y desplegando..."
ssh -p 37456 root@201.219.216.217  "$remoteCommand"