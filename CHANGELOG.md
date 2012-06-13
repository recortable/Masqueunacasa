# Masqueunacasa

TAREAS
- 1) Forzar que la cabecera de los grupos tenga 200 pixels de alto
st.
- 3) Enviar emails colectivos uno por uno y en background

## 13/06/2012
- Los posts pueden tener adjuntos (se guardan en s3)
- Pequeña reorganización del layout (en perfil y fases)

## 12/06/2012
- El grupo principal (Group.main) queda oculto
- Propuesta de layout para los posts
- Indicaciones de formato en los campos de latitud y longitud
- Apaño para mostrar los emails de los participantes (quitar cuando
  funcione el tema de envíos)
- El parámetro from de iniciar sesión es la url completa (para que
  funcione con subdominios)

## 09/06/2012
- En las propuestas se ve la pregunta
- El listado de fases muestra también las preguntas
- Mejora de los emails con css (usando la gema Roadie: https://github.com/Mange/roadie)
- Comentarios en algunas de las gemas (Gemfile)
- Entrar y salir (user session controller) sólo se puede hacer desde el dominio principal: redirect en
  caso contrario
- Recuperar contraseña implementado


## 07/06/2012
- Simplificación del formulario de los post con opciones de *texto*, *texto + imagen* o *texto + embed*
- Pestañas para las acciones "Ver" y "Editar" un post

## 06/06/2012
- Mostrar el resúmen de la propuesta en la página de la pregunta
- Traducir los nombres de los campos de Category
- Relations: experiencias y propuestas relacionadas
- Se puede relacionar una experiencia con una propuesta (en la página de
  la propuesta)
- Paginador en los blogs para mostrar links de "entradas más antiguas" y "Entradas más recientes"

## 05/06/2012
- Mejorado el sistema de configuración
- Puedes enviarte a ti mismo un mensaje si eres administrador... para
  probar
- Actualización de gemas (Rails 3.2.5)
- Mostrar una mensaje de diálogo antes de enviar un anuncio a todo el
  grupo ;)

## 04/06/2012
- Se muestran las primeras lineas de cada comunicado en la página de correo
- Se muestra el archivo de entradas del blog tambien en #index
- No te puedes "apuntar" ni seguir en los grupos cerrados
- Se pueden enviar comunicados (announcements) a los miembros y seguidores de un grupo
- Geolocalización de un grupo con Google Maps

## 03/06/2012
- Se puede mandar un mensaje (correo-e) a los miembros de un grupo desde su página de perfil (del grupo)
- Atom feeds para los blogs
- Se pueden cerrar los grupos, pero aún no tiene efectos...

## 02/06/2012
- Altura de las cabeceras adaptativa (es lo que se pretendía con la tarea 1?)

## 30/05/2012
  - Algo de investigación con GroupMailer. Solo development. No estilos. Con letter_opener 

## 23/05/2012
- Enlace desde la propuesta a la pregunta
- Enlace desde las preguntas a las propuestas
- Test funcionales para category_controller
- Test para el modelo Category
- Modelo Category: es lo que anteriormente llamábamos Question

## 22/05/2012
- Algunos test de integración para las experiencias
- Modelo y controlador para experiencias
- El título muestra el grupo actual

## 17/05/2012
- Ahora usamos 'subdomain' en vez de 'slug' para los subdominios de los
  grupos
- No todos los grupos tienen herramientas
- Dashboard de comunidad
- Mensajes a personas

## 16/05/2012
- Página de error 500
- Página de error 404
- Sustituido el editor de texto enriquecido: CKEditor en lugar de bootstrap-wysihtml5-rails

## 15/05/2012
- Versiones en posts
- Versiones en proposals
- Actividad (versions_controller)
- Empezamos con las propuestas
- Crear las fases
- Las tarjetas de participantes tienen una altura fija

## 14/05/2012
- Refactor editor.ja

## 10/05/2012
- Refactorización de groups/_sidebar.html.erb
- Los grupos tienen wiki (Pages)
- Bug fix: "read more..." links

## 9/05/2012
- Bug fix: al crear un usuario no aparece todo el formulario
- Adiós al modelo mensaje y hola modelo página
- Los usuarios pueden añadir su avatar
- Become funciona para admin

## 8/05/2012
- Añadir botón de "entrar para participar" a los grupos
- Redireccionar al entrar la sesión si el parámetro 'from' está
  disponible
- Bug fix: post-info no tenía el tamaño adecuado

## 7/05/2012
- Página de error en castellano
- Bug fix: check membership (group)
- Limpiando link_box
- Bug: la cabecera no era responsive
- Eliminar archivo de la barra lateral de los grupos
- Eliminar comentarios de la información del post
- Quitar cancan e implementar nuestro sistema de autorizaciones
- Añadir authorizations
- Limpiar has_current_group
- Añadir auth_role
- Quitar restricción al tamaño de las imágenes del post
- Añadir logos de panadería y sostrecivic

## 4/05/2012
- Mejores tests
- Se pueden añadir participantes a un grupo
- La página de participantes de un grupo muestra los memberships
- Se pueden eliminar participantes
- Se puede editar el nivel de participación de cada participante
- Estilos!
- Cambio de imágen de cabecera


## 3/05/2012
- Página de colectivos
- Página de participantes
- Se pueden añadir mensajes a un grupo
- Estilos, estilos, estilos!
- Favicon
- Empezando un mailer

## 2/05/2012
- Rich text editor para el perfil y los posts
- Se pueden subir imágenes al post
- Se pueden subir imágenes al perfil
- Estilos, estilos, estilos!

## 1/05/2012
- Se puede editar el perfil de un grupo
- Se puede añadir una entrada al blog de un grupo
- Actualizar algunas gemas
- Implementar la pantalla de inicio: que, como, quien

## 30/04/2012
- Preparar para el uso de subdominios
- Modelo 'content'

## 18/04/2012
- Create rails app

