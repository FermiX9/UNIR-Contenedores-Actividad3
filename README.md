# UNIR-Contenedores-Actividad3

Despliegue de Netbox en AWS EKS

## Requisitos en la instancia

- kubectl
- Helm
- EFS
- EKS
- Git

## Pasos a seguir

1. Despliegue del clúster en EKS
2. Añadir nodos en el clúster
3. Despliegue del EFS
4. Despliegue de una instancia en EC2 para el acceso al clúster
5. Modificar security groups para permitir el acceso desde el K8s al EFS y a la instancia de EC2
6. Modificar el fs-id del EFS en los archivos de configuración
7. Ejecutar los comandos en la instancia de EC2