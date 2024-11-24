enum ImageResourceEnum {
  logo('assets/images/home/logo_inclusivamente.svg'),
  profissional('assets/images/home/psicologo.svg'),
  familia('assets/images/home/pais.svg'),
  notFound('assets/images/shared/not_found.svg'),
  logoTemaClaro('assets/images/shared/logo_tema_claro.svg'),
  autism('images/home/autism.svg'),
  calendar('images/home/calendar.svg'),
  children('images/home/children.svg'),
  source('images/home/source.svg'),
  base64Avatar(kBase64);

  final String path;

  const ImageResourceEnum(this.path);
}

const kBase64 =