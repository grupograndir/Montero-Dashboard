# Instalador de la actualizacion del sistema de facturas de Montero.
# En el PC de Montero, en PowerShell:  irm https://montero-dashboard.vercel.app/instalar.ps1 | iex
# Descarga el paquete (enlace privado que caduca a los 21 dias) y lanza el instalador
# con permiso de administrador. No lleva ninguna clave: las pide el instalador.
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = 'https://kehamwcxejrgaqsjlhig.supabase.co/storage/v1/object/sign/instalador/montero_instalador_v2.zip?token=eyJraWQiOiIzOGI4MWVmOS02Mzk5LTQzOTctOTI3My01MmZhNTUzMDczZjkiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJpbnN0YWxhZG9yL21vbnRlcm9faW5zdGFsYWRvcl92Mi56aXAiLCJzY29wZSI6ImRvd25sb2FkIiwiaWF0IjoxNzkxMTkxMTk5LCJleHAiOjE3OTMwMDU1OTl9.4Hc7vKix3kE2oAshTjAMr_4BRua6CWECr4c_jOS_33c'
$tmp = Join-Path $env:TEMP 'montero_instalador'
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
New-Item -ItemType Directory -Path $tmp | Out-Null
Write-Host 'Descargando la actualizacion...' -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile (Join-Path $tmp 'm.zip') -UseBasicParsing
Expand-Archive -Path (Join-Path $tmp 'm.zip') -DestinationPath $tmp -Force
$ps = Join-Path $tmp 'USB_MONTERO\instalar.ps1'
Write-Host 'Pulsa SI en la ventana de permiso de administrador.' -ForegroundColor Yellow
Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -File `"$ps`" -Usuario $env:USERNAME"
