
# Gpromec IOS APP

Aplicación móvil nativa desarrollada SwiftUI (iOS) para el control de inventario y operaciones internas de Gpromec.  
Permite gestionar trabajadores, ítems, ubicaciones y movimientos de materiales, manteniendo trazabilidad y control en tiempo real con conexión a Supabase (PostgreSQL + API REST).
## Screenshots

<p align="center">
  <img src="https://private-user-images.githubusercontent.com/164811242/502650114-887579d8-052c-4f94-9f8e-79a0bdf6759f.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjA3MTcwNjQsIm5iZiI6MTc2MDcxNjc2NCwicGF0aCI6Ii8xNjQ4MTEyNDIvNTAyNjUwMTE0LTg4NzU3OWQ4LTA1MmMtNGY5NC05ZjhlLTc5YTBiZGY2NzU5Zi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUxMDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MTAxN1QxNTU5MjRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01ZTNjZTNjNjY1YjlkNTNmODNkZWQ3MGIyNDUxMTU2ZWQxOTY0NjkzYmY0NDQwZDI4MDUxOTY4ZjY5ODllMTBmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.P1HQffKxRtaClICkq2X8srhqoozZQOdba-tsZDr9ovE" width="220" alt="Pantalla 1"/>
  <img src="https://private-user-images.githubusercontent.com/164811242/502650110-68c8da7d-772c-4e03-ae70-4a12f181c981.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjA3MTcwNjQsIm5iZiI6MTc2MDcxNjc2NCwicGF0aCI6Ii8xNjQ4MTEyNDIvNTAyNjUwMTEwLTY4YzhkYTdkLTc3MmMtNGUwMy1hZTcwLTRhMTJmMTgxYzk4MS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUxMDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MTAxN1QxNTU5MjRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kNGY4YzJjMWNlMjlmYmQzNDBkZTg2YTg0OWYyNjI1Y2Y2Mjk5YzM5MjU5ODQ2NzQ4NGYxZDJlYjg4N2Y3MGQ2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.RCGBwFJlKWhfVLnwE2-aMDoKjQX8E29GcGk_onUm3Xg" width="220" alt="Pantalla 2"/>
  <img src="https://private-user-images.githubusercontent.com/164811242/502650107-7e3adac1-78ec-40e8-b8d2-88208b2f972a.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjA3MTc1NzAsIm5iZiI6MTc2MDcxNzI3MCwicGF0aCI6Ii8xNjQ4MTEyNDIvNTAyNjUwMTA3LTdlM2FkYWMxLTc4ZWMtNDBlOC1iOGQyLTg4MjA4YjJmOTcyYS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUxMDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MTAxN1QxNjA3NTBaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xZGY5NWI3NmMwZDEyM2ZmZjNmNWY5MWJmODQ1YTg2NjYzNmYyYzgzNjIxZjA5NWU2YTQ0MThmYTVmMDE3MDhmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.VevY6ZhET1XO-AVn0M-xxbyOZWkkaa_1IilhVJKxRQc" width="220" alt="Pantalla 3"/>
  <img src="https://private-user-images.githubusercontent.com/164811242/502650108-77221a90-4103-43cc-87dd-ca169c4803a3.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjA3MTc1NzAsIm5iZiI6MTc2MDcxNzI3MCwicGF0aCI6Ii8xNjQ4MTEyNDIvNTAyNjUwMTA4LTc3MjIxYTkwLTQxMDMtNDNjYy04N2RkLWNhMTY5YzQ4MDNhMy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUxMDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MTAxN1QxNjA3NTBaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xNTQzZTAzYjY2MjI1ZDU5Zjk1OWMwNzQzZTkyNjQ4NWZiZTc5NTQwZWYyYzdiMTE3Y2I0NjYxOWI4NTE1ODdhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.-fEalVWS-j1G-Ki0O7oAmfbDDWP03SllBg_XjcZ8R34" width="220" alt="Pantalla 4"/>
</p>

## Características Principales

- 📋 **Gestión de trabajadores:** listar, asignar y actualizar su ubicación actual.  
- 🏗️ **Ubicaciones y talleres:** registro y consulta de puntos físicos de trabajo.  
- 📦 **Inventario de ítems:** información detallada (nombre, descripción, estado, motivo de no retorno).  
- 🔄 **Historial de movimientos:** seguimiento completo con fecha, estado y color de alerta.  
- ☁️ **Conexión con Supabase:** operaciones asincrónicas seguras y rápidas (insert, select, update).  
  

## Stack

**Cliente (iOS):** Swift, SwiftUI, MVVM, async/await  
**Backend / Servicios:** Supabase (Postgres, REST/RPC, Storage)  
**Gestión de estado:** `ObservableObject`, `@State`, `@Published`, `@EnvironmentObject`  
**Arquitectura:** MVVM con servicios desacoplados y cliente Supabase centralizado  
**Lenguaje:** Swift 5.9+  
**IDE:** Xcode 15 o superior  



## Prototipado

Prototipo de App IOS

[Figma link G APP](https://www.figma.com/design/xck3BqtwjhPOH5nB3gXhFO/GpromecApp?node-id=1-3&t=hsoo39ElAD45vi6y-1)

##Documentacion
[Documentacion link G APP](https://deepwiki.com/AlexisJVillarruelEng/InventarioGpromecIOS/1-overview)
