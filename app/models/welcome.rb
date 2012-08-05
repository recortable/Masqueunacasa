# encoding: utf-8
#
class Welcome
  def title
    '¡Hola!'
  end

  def what
    <<-'TEXT'
*Masqueunacasa* es una plataforma web de procesos colectivos de vivienda que pretende ofrecer herramientas para fomentar la participación y autogestión en la construcción de nuestras viviendas y entornos.

Es un soporte online para ofrecer y debatir alternativas al modelo dominante de vivienda actual, proponiendo experiencias construidas y guías de asesoría que nos ayuden a ver otra manera de hacer las cosas más cooperativa.
    TEXT
  end

  def hab_question
    '¿Quieres saber cómo resolver<br> tu problema de vivienda<br> de manera colectiva?'
  end

  def hab_action
    'Consulta la'
  end

  def hab_info
    <<-'TEXT'
Estamos recopilando dudas y propuestas útiles para tener en cuenta a lo largo del proceso de construcción colectiva de nuestras viviendas y entornos. ¡La Habitapedia està abierta a la participación de todo el mundo!
    TEXT
  end

  def exp_question
    '¿Quieres conocer<br> algunas propuestas<br> ya realizadas?'
  end

  def exp_action
    'Visita las'
  end

  def exp_info
    <<-'TEXT'
Si conoces alguna experiencia de vivienda colectiva en la que sus habitantes hayan participado en alguna de las fases del proceso, puedes subirla a la base de datos desde tu perfil de usuario de Más que una casa.
    TEXT
  end

  def blog_question
    '¿Quieres participar<br> proponiendo<br> mejoras y posibilidades?'
  end

  def blog_action
    'Escribe en el'
  end

  def blog_info
    <<-'TEXT'
Éste es el blog colectivo de Más que una casa. También puedes tener tu propio blog e informar de tus actividades, tanto si trabajas con estos temas como si estás iniciando un proyecto de cooperativa en vuestra zona. ¡Regístrate y participa!
    TEXT
  end

  def com_question
    '¿Quieres encontrar gente<br> interesada en procesos<br> colectivos de vivienda?'
  end

  def com_action
    'Únete a nuestra'
  end

  def com_info
    <<-'TEXT'
Queremos generar una red para compartir experiencias, conocer personas con experiencias comunes y encontrar gente que nos pueda asesorar en nuestros contextos locales. Regístrate y podrás formar parte de Más que una casa.
    TEXT
  end

end
