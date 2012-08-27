# Masqueunacasa

TAREAS
- Enviar emails colectivos en background

## 27/08/2012
- Css tweaks en actividad
- Cache post y resúmenes
- Los post muestran al autor/a
- Mejor resúmen de posts


## 24/08/2012
- El email de actividad se envía a lxs participantes de Group.root en
vez de a lxs admins
- Mejoras en cómo se muestran las versiones
- Cache agresivo de welcome, habitapedia y categorias
- Mejoras en los emails de actividad

## 23/08/2012
- Bug que no permitía editar las secciones de los grupos

## 22/08/2012
- Migración: añadir editores de las secciones
- Dashboards para preguntas y experiencias
- Mejorada la vista de propuestas dashboard
- Ahora se añaden editorships correctamente
- Tratando de mejorar el viewport para dispositivos móviles
- Sólo usuarios autorizados pueden crear o actualizar tareas

## 05/08/2012 (Ha muerto Chavela Vargas! :( )
- Css 
- Editor genérico
- Formularios mejorados
- Bug fixes
- Los editores, suscriptores y tareas aparecen en los formularios de
  edición
- Los formularios de edición son genéricos para todos los documentos
- Mejora de estilos (en especial tipos de letras)

## 19/07/2012
- Los enlaces pueden ser editados
- Counter cache for experiencies and relations
- Link document fixed
- More test

## 18/07/2012
- Las versiones muestran una actividad decente


## 17/07/2012
- Los grupos muestran los participantes en el perfil
- Las experiencias muestran las propuestas organizadas por fase
- Las propuestas se pueden asociar a más de una experiencia

## 16/07/2012
- Las experiencias tienen una galería de imágenes

## 15/07/2012
- Mesa de edición
- Los documentos tienen tareas

## 14/07/2012
- Links en propuestas y experiencias
- Mapa general
- Mapa en grupos, usuarios y experiencias

## 12/07/2012 (Pair programming!!)
- Todos los modelos tienen summary
- Borrada la tabla de usuarios y grupos (no agents)
- Mover al subdominio todos los grupos menos el admin

## 9/07/2012
- Se puede borrar el texto de las preguntas 
- Compilar los assets sólo si han cambiado

## 29/06/2012
- Se pueden quitar y añadir participantes
- Mejorado las vistas de Pages
- Empezamos con la búsqueda (Search model)
- Borrar propuestas y experiencias

## 28/06/2012
- Adaptar un poco el layout a lo de maría
- Borrar secciones

## 27/06/2012
- Bug fix: las phases se pueden cambiar de nombr
- Bug fix: se pueden guardar secciones sin imágen
- Se puede eliminar participantes de un grupo
- Ya no se oculta el login (login.css fuera) porque se ocultaba en
  casos que no debía (p.ej: viendo un usuario)
- Imágenes en las secciones
- Update gems (routes.yml breaking change)

## 26/06/2012
- Bug fix: mostrar el archivo del grupo actual (si existe)
- Añadir y borrar experiencias
- Los posts también tienen secciones
- Bug fix: documentos
- Mejorar la gestión de memberships en grupos 

## 25/06/2012.
- Se puede utilizar www como prefijo de subdominio
- Tratando de simplificar la navegación
- Mejorar las vistas de los grupos
- Cualquier usuario puede editar las propuestas y preguntas
- GRAN CAMBIO EN LA DB: tanto Usuarios como Grupos usan la misma tabla
- Modelo Agents: tanto usuarios como grupos son agentes. Se usa para que
  no pueda haber un nombre de usuario igual que uno de grupo
- Se pueden borrar preguntas (si eres admin)
- Bug fix: editar grupos
- Refactorizar el HasKudos

## 22/06/2012
- De momento, el archivo es sin fechas (lo siento, Pau...)
- Intentando poner un poco de orden en la parte 'social'

## 21/06/2012
- Fuera índice (hasta que encontremos la manera de encajarlo, si es que
  tiene sentido)
- Se puede pinchar en me gusta
- Lleva la cuenta del número de veces que se accede a una página
- vide_count en los modelos (número de veces visto)
- Modelo subscriptor (Subscribirse a los cambios de un modelo)
- Modelo kudos ("Me gusta")
- Probando la integración con twitter
- Las propuestas se pueden reordenar
- Tratando de mejorar la navegación
- Ahora las propuestas se crean desde la pregunta (la pregunta es un
  campo obligatorio)
- Imágenes chorras para la habitapedia

## 20/06/2012
- Quitar banner de habitapedia
- Mejorar la navegación
- Las fases también tienen secciones

## 19/06/2012
- Más botones flotantes para las acciones
- Las preguntas tienen posición con respecto a su fase
- Las propuestas tienen posición con respecto a su pregunta
- Las categorias también tienen secciones
- Las secciones se pueden mover
- Cuando pulsas salir permaneces en la misma página 
- Habitapedia reorganizado - muestra las preguntas
- Índice en propuestas a la izquierda del contenido
- Las secciones actualizan el update_at del documento al que están
  asociados
- cap db:sync se renombre a cap db:pull (como en heroku)
- El contenido de las experiencias se organiza en secciones
- El contenido de las páginas se organiza en secciones
- La secciones pueden pertenecer a otras cosas que no solo las
  propuestas
- ExposeResource expose_parent 

## 18/06/2012
- Mediafy.js: automáticamente inserta enlaces de vídeo, imágenes, etc...
  que haya en el texto.
- El layuot de Pages mejorado
- Páginas pasa a /docs
- Añadir o quitar relaciones se hace en la página de edición de
  propuestas
- El contenido de las propuestas se organiza en secciones
- Reorganización del layout de habitapedia


## 14/06/2012
- Lista de propuestas para administradorxs
- Una manera para poder usar markdown además de html
- Actualizar gemas
- Propuesta de layout para la habitapedia
- Mejora de los estilos del paginador
- Empezamos a mover las cosas de cloudinary a s3
- Fuera los avatares, los banners y las imágenes de los posts de
  cloudinary
- Usamos thin como servidor de desarrollo (para logs más claros)
- Limpieza del log en desarrollo: fuera assets
- Bug fix en los attachments. 

## 13/06/2012
- Ponemos un CNAME al amazon s3
- De momento QUITAMOS todos los locales que no sean ES. No se puede
  cambiar de idioma hasta que esté listo. Cuando esté listo en
  castellano hacemos la traducción al resto de los idiomas.
- Los posts pueden tener adjuntos (se guardan en s3)
- Pequeña reorganización del layout (en perfil y fases)
- Los emails con múltiples destinatarios se mandan de uno en uno

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

