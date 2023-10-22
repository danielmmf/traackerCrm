import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'pt', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? ptText = '',
    String? esText = '',
  }) =>
      [enText, ptText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // auth_Login
  {
    've8m5y6t': {
      'en': 'Welcome Back!',
      'es': '¡Bienvenido de nuevo!',
      'pt': 'Bem vindo de volta!',
    },
    'nrz6tgao': {
      'en': 'Use the form below to access your account.',
      'es': 'Utilice el siguiente formulario para acceder a su cuenta.',
      'pt': 'Utilize o formulário abaixo para acessar sua conta.',
    },
    'gt7wq2hw': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
      'pt': 'Endereço de email',
    },
    'bhbetfmh': {
      'en': 'Enter your email here...',
      'es': 'Introduzca su correo electrónico aquí...',
      'pt': 'Digite seu email aqui...',
    },
    'u4v4f7zu': {
      'en': 'Password',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    'zj808ybc': {
      'en': 'Enter your password here...',
      'es': 'Ingrese su contraseña aquí...',
      'pt': 'Digite sua senha aqui...',
    },
    'ir6csuz2': {
      'en': 'Forgot Password?',
      'es': '¿Has olvidado tu contraseña?',
      'pt': 'Esqueceu sua senha?',
    },
    'c6pan5lh': {
      'en': 'Login',
      'es': 'Acceso',
      'pt': 'Conecte-se',
    },
    's7cm0ts4': {
      'en': 'Don\'t have an account?',
      'es': '¿No tienes una cuenta?',
      'pt': 'Não tem uma conta?',
    },
    '8qecwnd8': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
      'pt': 'Criar uma conta',
    },
    'v08jdrd9': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
      'pt': 'Campo é obrigatório',
    },
    'o6jb2uhz': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    'yyvccatg': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
      'pt': 'Campo é obrigatório',
    },
    'dw3rcmml': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    'hykhto9x': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // forgotPassword
  {
    '8rieop4b': {
      'en': 'Forgot Password',
      'es': 'Has olvidado tu contraseña',
      'pt': 'Esqueceu sua senha',
    },
    'ubsekd9b': {
      'en':
          'Don\'t remember your password? Enter the email associated with your account below and we will send you a new link.',
      'es':
          '¿No recuerdas tu contraseña? Ingrese el correo electrónico asociado con su cuenta a continuación y le enviaremos un nuevo enlace.',
      'pt':
          'Não lembra da sua senha? Digite o e-mail associado à sua conta abaixo e enviaremos um novo link.',
    },
    'gnura8j0': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
      'pt': 'Endereço de email',
    },
    '7hwsw7s4': {
      'en': 'Please enter a valid email...',
      'es':
          'Por favor introduzca una dirección de correo electrónico válida...',
      'pt': 'Por favor digite um email válido...',
    },
    'otctweqi': {
      'en': 'Send Reset Link',
      'es': 'Enviar enlace de reinicio',
      'pt': 'Enviar link de redefinição',
    },
    '4r9gild0': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // auth_Create
  {
    'wdu7057z': {
      'en': 'Get Started',
      'es': 'Empezar',
      'pt': 'Iniciar',
    },
    'zr11kon4': {
      'en': 'Use the form below to get started.',
      'es': 'Utilice el siguiente formulario para comenzar.',
      'pt': 'Use o formulário abaixo para começar.',
    },
    'fd73adag': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
      'pt': 'Endereço de email',
    },
    'p89k3a14': {
      'en': 'Enter your email here...',
      'es': 'Introduzca su correo electrónico aquí...',
      'pt': 'Digite seu email aqui...',
    },
    'cni5lst0': {
      'en': 'Password',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    '2dhu7mqs': {
      'en': 'Create your password...',
      'es': 'Crea tu contraseña...',
      'pt': 'Crie sua senha...',
    },
    '796b9lga': {
      'en': 'Confirm Password',
      'es': 'confirmar Contraseña',
      'pt': 'Confirme sua senha',
    },
    'k1r5lj4d': {
      'en': 'Create your password...',
      'es': 'Crea tu contraseña...',
      'pt': 'Crie sua senha...',
    },
    'a7c9y9no': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
      'pt': 'Criar uma conta',
    },
    'fhdpzkkb': {
      'en': 'Use a social platform to continue',
      'es': 'Utilice una plataforma social para continuar',
      'pt': 'Use uma plataforma social para continuar',
    },
    'rpmkj1hs': {
      'en': 'Already have an account?',
      'es': '¿Ya tienes una cuenta?',
      'pt': 'já tem uma conta?',
    },
    'sg6l8oun': {
      'en': 'Log In',
      'es': 'Acceso',
      'pt': 'Conecte-se',
    },
    '11x3otbw': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // Main_Home
  {
    'dy3ymjix': {
      'en': 'Dashboard',
      'es': 'Panel',
      'pt': 'Painel',
    },
    'g0rtkzaj': {
      'en': 'Below is a summary of your teams activity.',
      'es':
          'A continuación se muestra un resumen de la actividad de su equipo.',
      'pt': 'Abaixo está um resumo da atividade de sua equipe.',
    },
    '2gra8nc6': {
      'en': 'New Customers',
      'es': 'nuevos clientes',
      'pt': 'novos clientes',
    },
    '1m3utksd': {
      'en': '24',
      'es': '24',
      'pt': '24',
    },
    '7lakbrsr': {
      'en': 'New Contracts',
      'es': 'Nuevos contratos',
      'pt': 'Novos Contratos',
    },
    'aqikthg3': {
      'en': '3,200',
      'es': '3.200',
      'pt': '3.200',
    },
    'sz2i00od': {
      'en': 'Expired Contracts',
      'es': 'Contratos vencidos',
      'pt': 'Contratos expirados',
    },
    'hcdkgf8p': {
      'en': '4300',
      'es': '4300',
      'pt': '4300',
    },
    'yd7kz32v': {
      'en': 'Projects',
      'es': 'Proyectos',
      'pt': 'Projetos',
    },
    '5ge9fv9i': {
      'en': 'UI Design Team',
      'es': 'Equipo de diseño de interfaz de usuario',
      'pt': 'Equipe de design de interface do usuário',
    },
    'c0q49zn4': {
      'en': '4 Members',
      'es': '4 miembros',
      'pt': '4 membros',
    },
    'dat0569v': {
      'en': 'Contract Activity',
      'es': 'Actividad contractual',
      'pt': 'Atividade Contratual',
    },
    '30vs7mqy': {
      'en': 'Below is an a summary of activity.',
      'es': 'A continuación se muestra un resumen de la actividad.',
      'pt': 'Abaixo está um resumo da atividade.',
    },
    '78lu89n4': {
      'en': 'Customer Activity',
      'es': 'Actividad del cliente',
      'pt': 'Atividade do cliente',
    },
    'xxozi8td': {
      'en': 'Below is an a summary of activity.',
      'es': 'A continuación se muestra un resumen de la actividad.',
      'pt': 'Abaixo está um resumo da atividade.',
    },
    '04yazfyb': {
      'en': 'Contract Activity',
      'es': 'Actividad contractual',
      'pt': 'Atividade Contratual',
    },
    'sj6tgyrg': {
      'en': 'Below is an a summary of activity.',
      'es': 'A continuación se muestra un resumen de la actividad.',
      'pt': 'Abaixo está um resumo da atividade.',
    },
    'wtfc4cid': {
      'en': 'Customer Activity',
      'es': 'Actividad del cliente',
      'pt': 'Atividade do cliente',
    },
    'hbh7yl6g': {
      'en': 'Below is an a summary of activity.',
      'es': 'A continuación se muestra un resumen de la actividad.',
      'pt': 'Abaixo está um resumo da atividade.',
    },
    'iaoaz36n': {
      'en': 'Dashboard',
      'es': 'Panel',
      'pt': 'Painel',
    },
    's5cbvg3h': {
      'en': '__',
      'es': '__',
      'pt': '__',
    },
  },
  // Main_Contracts
  {
    '6iyabcgm': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'cg6uh9dx': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'hizkkvfq': {
      'en': 'Projects',
      'es': 'Proyectos',
      'pt': 'Projetos',
    },
    'vlfks3mm': {
      'en': 'No-Code Platform Design',
      'es': 'Diseño de plataforma sin código',
      'pt': 'Design de plataforma sem código',
    },
    'wy9iibaz': {
      'en': 'Design Team Docs',
      'es': 'Documentos del equipo de diseño',
      'pt': 'Documentos da equipe de design',
    },
    'qengxdoh': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'eti1on05': {
      'en': 'ACME Co.',
      'es': 'ACME Co.',
      'pt': 'ACME Co.',
    },
    'l69duu2w': {
      'en': 'Contracts for New Opportunities',
      'es': 'Contratos para nuevas oportunidades',
      'pt': 'Contratos para Novas Oportunidades',
    },
    'bjciqa3q': {
      'en': 'Next Action',
      'es': 'Proxima accion',
      'pt': 'Próxima ação',
    },
    'foeyt1ox': {
      'en': 'Tuesday, 10:00am',
      'es': 'Martes, 10:00 a.m.',
      'pt': 'Terça-feira, 10h00',
    },
    '8qfbezev': {
      'en': 'In Progress',
      'es': 'En curso',
      'pt': 'Em andamento',
    },
    'mropyvpt': {
      'en': 'HealthAi',
      'es': 'SaludAi',
      'pt': 'SaúdeAi',
    },
    'mgdvfb62': {
      'en': 'Client Acquisition for Q3',
      'es': 'Adquisición de clientes para el tercer trimestre',
      'pt': 'Aquisição de clientes para o terceiro trimestre',
    },
    'unez6p75': {
      'en': 'Next Action',
      'es': 'Proxima accion',
      'pt': 'Próxima ação',
    },
    '2v12kjg0': {
      'en': 'Tuesday, 10:00am',
      'es': 'Martes, 10:00 a.m.',
      'pt': 'Terça-feira, 10h00',
    },
    'pt3qzqjq': {
      'en': 'In Progress',
      'es': 'En curso',
      'pt': 'Em andamento',
    },
    'uqfd826z': {
      'en': '__',
      'es': '__',
      'pt': '__',
    },
  },
  // Main_messages
  {
    'qnqfyvz1': {
      'en': 'Messages',
      'es': 'Mensajes',
      'pt': 'Mensagens',
    },
    'k601vtqy': {
      'en': 'Search messages here...',
      'es': 'Buscar mensajes aquí...',
      'pt': 'Pesquise mensagens aqui...',
    },
    'nbu1dtt2': {
      'en': 'Randy Mcdonald',
      'es': 'Randy McDonald',
      'pt': 'Randy McDonald',
    },
    'vgggjyqj': {
      'en':
          'This was really great, i\'m so glad that we could  catchup this weekend.',
      'es':
          'Esto fue realmente genial, estoy muy contento de haber podido ponernos al día este fin de semana.',
      'pt':
          'Isso foi realmente ótimo, estou tão feliz que pudemos nos atualizar neste fim de semana.',
    },
    '17ez5vjy': {
      'en': 'Mon. July 3rd - 4:12pm',
      'es': 'Lun. 3 de julio - 4:12 p.m.',
      'pt': 'Seg. 3 de julho - 16h12',
    },
    'egq2tbkx': {
      'en': 'Randy Mcdonald',
      'es': 'Randy McDonald',
      'pt': 'Randy McDonald',
    },
    'qkbfucwh': {
      'en':
          'This was really great, i\'m so glad that we could  catchup this weekend.',
      'es':
          'Esto fue realmente genial, estoy muy contento de haber podido ponernos al día este fin de semana.',
      'pt':
          'Isso foi realmente ótimo, estou tão feliz que pudemos nos atualizar neste fim de semana.',
    },
    'ei7tx6a0': {
      'en': 'Mon. July 3rd - 4:12pm',
      'es': 'Lun. 3 de julio - 4:12 p.m.',
      'pt': 'Seg. 3 de julho - 16h12',
    },
    '8ofjg4sd': {
      'en': 'Randy Mcdonald',
      'es': 'Randy McDonald',
      'pt': 'Randy McDonald',
    },
    '3sqgvxgj': {
      'en':
          'This was really great, i\'m so glad that we could  catchup this weekend.',
      'es':
          'Esto fue realmente genial, estoy muy contento de haber podido ponernos al día este fin de semana.',
      'pt':
          'Isso foi realmente ótimo, estou tão feliz que pudemos nos atualizar neste fim de semana.',
    },
    'fjprgw82': {
      'en': 'Mon. July 3rd - 4:12pm',
      'es': 'Lun. 3 de julio - 4:12 p.m.',
      'pt': 'Seg. 3 de julho - 16h12',
    },
    'txrrokwd': {
      'en':
          'I am a freelancer and I need help writing content for a proposal for a project. Can I give you some context for the projecct I need to write a proposal for?',
      'es':
          'Soy autónomo y necesito ayuda para redactar contenido para una propuesta de proyecto. ¿Puedo darle algún contexto para el proyecto para el que necesito escribir una propuesta?',
      'pt':
          'Sou freelancer e preciso de ajuda para escrever conteúdo para uma proposta de projeto. Posso fornecer algum contexto para o projeto para o qual preciso escrever uma proposta?',
    },
    'syej3gwb': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'l3qqc0tm': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'i27ynxxl': {
      'en': 'a few moments ago',
      'es': 'hace unos momentos',
      'pt': 'alguns momentos atrás',
    },
    'utzpik6j': {
      'en': 'This is my intro video',
      'es': 'Este es mi vídeo de introducción.',
      'pt': 'Este é meu vídeo de introdução',
    },
    '3stbzsbj': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    '7zrhthib': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'z3jwrht2': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'wh4k3gz0': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'ponrt0pp': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'sk12esw9': {
      'en': 'Start typing here...',
      'es': 'Empieza a escribir aquí...',
      'pt': 'Comece a digitar aqui...',
    },
    'jwdfrt35': {
      'en': 'Dashboard',
      'es': 'Panel',
      'pt': 'Painel',
    },
    'okkngboq': {
      'en': '__',
      'es': '__',
      'pt': '__',
    },
  },
  // Main_profilePage
  {
    'lop4pude': {
      'en': 'My Profile',
      'es': 'Mi perfil',
      'pt': 'Meu perfil',
    },
    '1adhtzoh': {
      'en': 'Account Settings',
      'es': 'Configuraciones de la cuenta',
      'pt': 'Configurações de Conta',
    },
    'wbt7du3j': {
      'en': 'Change Password',
      'es': 'Cambiar la contraseña',
      'pt': 'Alterar a senha',
    },
    'h1q2j7b9': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
      'pt': 'Editar Perfil',
    },
    'el7wmnlk': {
      'en': 'Update Theme',
      'es': 'Actualizar tema',
      'pt': 'Atualizar tema',
    },
    'r3v5efsf': {
      'en':
          'Update the theme of your application from seleccting one of the options below.',
      'es':
          'Actualice el tema de su aplicación seleccionando una de las siguientes opciones.',
      'pt':
          'Atualize o tema do seu aplicativo selecionando uma das opções abaixo.',
    },
    '51l4mxde': {
      'en': 'Dark Mode',
      'es': 'Modo oscuro',
      'pt': 'Modo escuro',
    },
    'bbphmr42': {
      'en': 'Light Mode',
      'es': 'Modo de luz',
      'pt': 'Modo claro',
    },
    '35x5szy3': {
      'en': 'Log Out',
      'es': 'Cerrar sesión',
      'pt': 'Sair',
    },
    't1v7zuuj': {
      'en': '__',
      'es': '__',
      'pt': '__',
    },
  },
  // userDetails
  {
    '9gb3l6zt': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // editProfile
  {
    'egtkxnmx': {
      'en': 'Change Photo',
      'es': 'Cambiar foto',
      'pt': 'Mudar foto',
    },
    'fjybd0lj': {
      'en': 'Your Name',
      'es': 'Su nombre',
      'pt': 'Seu nome',
    },
    'mynln2na': {
      'en': 'The email associated with this account is:',
      'es': 'El correo electrónico asociado a esta cuenta es:',
      'pt': 'O e-mail associado a esta conta é:',
    },
    'f1astew7': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
      'pt': 'Salvar alterações',
    },
    'nqbreyve': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
      'pt': 'Editar Perfil',
    },
  },
  // projectDetailsHealthAi
  {
    'ips11she': {
      'en': 'HealthAi',
      'es': 'SaludAi',
      'pt': 'SaúdeAi',
    },
    '9h2iol2v': {
      'en': 'Client Acquisition for Q3',
      'es': 'Adquisición de clientes para el tercer trimestre',
      'pt': 'Aquisição de clientes para o terceiro trimestre',
    },
    'xzhlvsie': {
      'en': 'Next Action',
      'es': 'Proxima accion',
      'pt': 'Próxima ação',
    },
    't545lar5': {
      'en': 'Tuesday, 10:00am',
      'es': 'Martes, 10:00 a.m.',
      'pt': 'Terça-feira, 10h00',
    },
    '6f3z1ksx': {
      'en': 'In Progress',
      'es': 'En curso',
      'pt': 'Em andamento',
    },
    '1zahyd5z': {
      'en': 'Contract Details',
      'es': 'Detalles del contrato',
      'pt': 'Detalhes do contrato',
    },
    '6l6w29kr': {
      'en': '\$125,000',
      'es': '\$125,000',
      'pt': 'US\$ 125.000',
    },
    'ni6p1pl9': {
      'en':
          'Additional Details around this contract and who is working on it in this card!',
      'es':
          '¡Detalles adicionales sobre este contrato y quién está trabajando en él en esta tarjeta!',
      'pt':
          'Detalhes adicionais sobre este contrato e quem está trabalhando nele neste cartão!',
    },
    'cab4abp7': {
      'en': 'Mark as Complete',
      'es': 'Marcar como completo',
      'pt': 'Marcar como concluído',
    },
    'z3g44rpg': {
      'en': 'Contract Details',
      'es': 'Detalles del contrato',
      'pt': 'Detalhes do contrato',
    },
    'geepq0sr': {
      'en': '\$67,000',
      'es': '\$67,000',
      'pt': 'US\$ 67.000',
    },
    'jrfjox4p': {
      'en':
          'Additional Details around this contract and who is working on it in this card!',
      'es':
          '¡Detalles adicionales sobre este contrato y quién está trabajando en él en esta tarjeta!',
      'pt':
          'Detalhes adicionais sobre este contrato e quem está trabalhando nele neste cartão!',
    },
    'd4gp6vhk': {
      'en': 'Mark as Complete',
      'es': 'Marcar como completo',
      'pt': 'Marcar como concluído',
    },
    '4zcigqcu': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // projectDetails
  {
    '2vvgg1ck': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // searchPage
  {
    'wbqd5qwt': {
      'en': 'Add Members',
      'es': 'Añadir miembros',
      'pt': 'Adicionar membros',
    },
    '24b1ivxs': {
      'en': 'Search members...',
      'es': 'Buscar miembros...',
      'pt': 'Pesquisar membros...',
    },
    'dz3b007z': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'pt': 'Opção 1',
    },
    'yxdjkyf0': {
      'en': 'All Members',
      'es': 'Todos los miembros',
      'pt': 'Todos os membros',
    },
    'whcjwcnu': {
      'en': 'View',
      'es': 'Vista',
      'pt': 'Visualizar',
    },
    'e130wimf': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // messagesDetails
  {
    'gswmbxbu': {
      'en':
          'I am a freelancer and I need help writing content for a proposal for a project. Can I give you some context for the projecct I need to write a proposal for?',
      'es':
          'Soy autónomo y necesito ayuda para redactar contenido para una propuesta de proyecto. ¿Puedo darle algún contexto para el proyecto para el que necesito escribir una propuesta?',
      'pt':
          'Sou freelancer e preciso de ajuda para escrever conteúdo para uma proposta de projeto. Posso fornecer algum contexto para o projeto para o qual preciso escrever uma proposta?',
    },
    'jwvo5yaz': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'qtwr9222': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'owe59xxj': {
      'en': 'a few moments ago',
      'es': 'hace unos momentos',
      'pt': 'alguns momentos atrás',
    },
    'ffknpojy': {
      'en': 'This is my intro video',
      'es': 'Este es mi vídeo de introducción.',
      'pt': 'Este é meu vídeo de introdução',
    },
    'k7q2ycr3': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    '14v46cb1': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'jg2cseie': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'vzc5gjb0': {
      'en': 'Hey really love what you are doing!',
      'es': '¡Oye, realmente amo lo que estás haciendo!',
      'pt': 'Ei, realmente amo o que você está fazendo!',
    },
    'ecbw0cdt': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'd2q0be2k': {
      'en': 'Start typing here...',
      'es': 'Empieza a escribir aquí...',
      'pt': 'Comece a digitar aqui...',
    },
    'cpio4t5x': {
      'en': 'Chat Details',
      'es': 'Detalles del chat',
      'pt': 'Detalhes do bate-papo',
    },
    'w6eqny0n': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // LandPage
  {
    'sd0bl1d0': {
      'en': 'Robo de Atendimento via WhatsApp',
      'es': 'Robo de Atención vía WhatsApp',
      'pt': 'Robô de Atendimento via WhatsApp',
    },
    'aq7bmhgy': {
      'en': 'Atendendo automaticamente',
      'es': 'Atendiendo automáticamente',
      'pt': 'Atendendo automaticamente',
    },
    '72runiw9': {
      'en': 'Primary Care, Intentional Medicine',
      'es': 'Atención Primaria, Medicina Intencional',
      'pt': 'Atenção Primária, Medicina Intencional',
    },
    'ykr1gff1': {
      'en': 'Chat',
      'es': 'Charlar',
      'pt': 'Bater papo',
    },
    'e4h9ziu1': {
      'en': 'Call',
      'es': 'Llamar',
      'pt': 'Chamar',
    },
    'e7894dkt': {
      'en': 'Doctor Bio',
      'es': 'Biografía del médico',
      'pt': 'Doutor Biografia',
    },
    'ynytcyo2': {
      'en':
          'Dr. Will Hobbiton is a board-certified internal medicine specialist with over 15 years of experience treating patients in both hospital and private practice settings. She is passionate about preventive care and dedicated to providing her patients with the highest level of personalized medical attention, while staying updated on the latest advancements in her field.',
      'es':
          'El Dr. Will Hobbiton es un especialista en medicina interna certificado con más de 15 años de experiencia en el tratamiento de pacientes tanto en hospitales como en consultorios privados. Le apasiona la atención preventiva y se dedica a brindar a sus pacientes el más alto nivel de atención médica personalizada, mientras se mantiene actualizada sobre los últimos avances en su campo.',
      'pt':
          'Will Hobbiton é um especialista em medicina interna certificado com mais de 15 anos de experiência no tratamento de pacientes em hospitais e consultórios particulares. Ela é apaixonada por cuidados preventivos e dedicada a fornecer aos seus pacientes o mais alto nível de atendimento médico personalizado, ao mesmo tempo em que se mantém atualizada sobre os últimos avanços em sua área.',
    },
    'hxt4hm23': {
      'en': 'Book Appointment',
      'es': 'Reservar una cita',
      'pt': 'Anotação de livro',
    },
    'bhw7cild': {
      'en': 'Favorite Doctor',
      'es': 'Doctor favorito',
      'pt': 'Médico favorito',
    },
    'rbzzwaby': {
      'en': 'Details',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    '7wz88qzu': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // LpMain
  {
    'f34yntvg': {
      'en': 'Primary Physician',
      'es': 'Doctor principal',
      'pt': 'robo de atendimento',
    },
    'evgd6j02': {
      'en': 'Dr. Will Hobbiton',
      'es': 'Dr. Will Hobbiton',
      'pt': 'Automatico via WhatsApp',
    },
    'gyx8c78o': {
      'en': 'Primary Care, Intentional Medicine',
      'es': 'Atención Primaria, Medicina Intencional',
      'pt': 'Sabe tudo sobre o seu negocio',
    },
    '3qdcwjn2': {
      'en': 'Chat',
      'es': 'Charlar',
      'pt': 'Bater papo',
    },
    'r2232slg': {
      'en': 'Doctor Bio',
      'es': 'Biografía del médico',
      'pt': 'Como funciona:',
    },
    'gcev8z2w': {
      'en':
          'O Nosso robo conectado ao um GPT pode aprender sobre a sua empresa e fazer um atendimento automatico de qualidade e de alta perfomance. O robo consegue ver usuarios , produtos e serviços , pode abrir chamados , cobrar pix e validar se foi pago!  Consegue consultar uma agenda ou ler documentos de referencia.',
      'es':
          'O Nosso robo conectado ao um GPT pode aprender sobre a sua empresa e fazer um atendimento automatico de qualidade e de alta perfomance. O robo consegue ver usuarios , produtos e serviços , pode abrir chamados , cobrar pix e validar se foi pago!  Consegue consultar uma agenda ou ler documentos de referencia.',
      'pt':
          'O Nosso robo conectado ao um GPT pode aprender sobre a sua empresa e fazer um atendimento automatico de qualidade e de alta perfomance. O robo consegue ver usuarios , produtos e serviços , pode abrir chamados , cobrar pix e validar se foi pago!  Consegue consultar uma agenda ou ler documentos de referencia.',
    },
    'xy5qdx1k': {
      'en': 'Book Appointment',
      'es': 'Reservar una cita',
      'pt': 'Agendar um atendimento',
    },
    '6uoe5c22': {
      'en': 'Favorite Doctor',
      'es': 'Doctor favorito',
      'pt': 'Compartilhe com alguém ',
    },
    'em2fvxwo': {
      'en': 'Details',
      'es': 'Detalles',
      'pt': 'WhatsCrm',
    },
    'nl50i4xs': {
      'en': 'Home',
      'es': 'Hogar',
      'pt': 'Lar',
    },
  },
  // Clients
  {
    'ffl6p2h1': {
      'en': 'check.io',
      'es': '',
      'pt': '',
    },
    't9j8pj84': {
      'en': 'Platform Navigation',
      'es': '',
      'pt': '',
    },
    'wnl5t6ui': {
      'en': 'Dashboard',
      'es': '',
      'pt': '',
    },
    'jsorgdhe': {
      'en': 'Chats',
      'es': '',
      'pt': '',
    },
    'qmfpvmvl': {
      'en': 'All Tasks',
      'es': '',
      'pt': '',
    },
    'dx4cduit': {
      'en': '12',
      'es': '',
      'pt': '',
    },
    'p0wm2y4k': {
      'en': 'Projects',
      'es': '',
      'pt': '',
    },
    '4a45ogxj': {
      'en': 'Settings',
      'es': '',
      'pt': '',
    },
    '0j0sz53l': {
      'en': 'Billing',
      'es': '',
      'pt': '',
    },
    'zlkyu17e': {
      'en': 'Explore',
      'es': '',
      'pt': '',
    },
    'uev4e0dd': {
      'en': 'Light Mode',
      'es': '',
      'pt': '',
    },
    'r9nm620k': {
      'en': 'Dark Mode',
      'es': '',
      'pt': '',
    },
    'azy2y4sf': {
      'en': 'Andrew D.',
      'es': '',
      'pt': '',
    },
    '2q1wtm44': {
      'en': 'admin@gmail.com',
      'es': '',
      'pt': '',
    },
    'uaekwfkl': {
      'en': 'All Tasks',
      'es': '',
      'pt': '',
    },
    'xa69u3fg': {
      'en': 'Below is a summary of tasks.',
      'es': '',
      'pt': '',
    },
    'e99jluq2': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    '46l16a7z': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    '99py4491': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    'uyx645gk': {
      'en': 'Completed',
      'es': '',
      'pt': '',
    },
    'vchddwiz': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    '0ugpg8tt': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    '1gomh6gw': {
      'en': 'Search all tasks...',
      'es': '',
      'pt': '',
    },
    'd3josqwm': {
      'en': 'Task Name',
      'es': '',
      'pt': '',
    },
    'bqi9o0ey': {
      'en': 'Assigned To',
      'es': '',
      'pt': '',
    },
    'hbm29x8x': {
      'en': 'Due Date',
      'es': '',
      'pt': '',
    },
    'fhom7q0k': {
      'en': 'Status',
      'es': '',
      'pt': '',
    },
    'td171n2p': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    '7824smti': {
      'en': 'Randy Rodriguez',
      'es': '',
      'pt': '',
    },
    'fq64be74': {
      'en': 'randy@domainname.com',
      'es': '',
      'pt': '',
    },
    'qw2u9ata': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'u8iyvaku': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    'ffu54j0p': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    'lentop9q': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'oxkg1oht': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'c4d6xfia': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    '6b2ap0ni': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'txhqx2o4': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    't7dhqt4h': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'n8x1f5t9': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    '3f10pgq2': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'gds7biwq': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'cx8dmv06': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    'ylb88gnw': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'uo9fkgbt': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'hrv8y496': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'odjvk0ka': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    'kewve42e': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    '6ncp1ltw': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    '7l6iqgyz': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'yctpfki3': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    '0a2h6mf6': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    '6u530xnm': {
      'en': 'All Tasks',
      'es': '',
      'pt': '',
    },
    'mgf16l5z': {
      'en': 'Home',
      'es': '',
      'pt': '',
    },
  },
  // NewClientsPage
  {
    'cy43ni0e': {
      'en': 'All Tasks',
      'es': '',
      'pt': '',
    },
    'qbtut609': {
      'en': 'Below is a summary of tasks.',
      'es': '',
      'pt': '',
    },
    'blv99q3r': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    'swaf6wmx': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'aslxqiqk': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    'fzy6c8ef': {
      'en': 'Completed',
      'es': '',
      'pt': '',
    },
    '6r57k3q7': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    '7mjagnqk': {
      'en': 'All',
      'es': '',
      'pt': '',
    },
    'kbcrywdw': {
      'en': 'Search all tasks...',
      'es': '',
      'pt': '',
    },
    'oz99834x': {
      'en': 'Task Name',
      'es': '',
      'pt': '',
    },
    'yles6vmk': {
      'en': 'Assigned To',
      'es': '',
      'pt': '',
    },
    '38awr0mh': {
      'en': 'Due Date',
      'es': '',
      'pt': '',
    },
    '1geh9p7s': {
      'en': 'Status',
      'es': '',
      'pt': '',
    },
    '7kvtitet': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    '7vrusaje': {
      'en': 'Randy Rodriguez',
      'es': '',
      'pt': '',
    },
    'hd7yvlxt': {
      'en': 'randy@domainname.com',
      'es': '',
      'pt': '',
    },
    'klut3jbh': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'ib91lzxq': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    'wfmc19ot': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    'afywtpxe': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'vw5dxb37': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'ozbcavoe': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    '4losisno': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'vb7w7eog': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    '151ou6fk': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'z96t4xat': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'xtlh4017': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'f74fz911': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'hvb7vyad': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    '429bf1i4': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'kmaf8c0t': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'l23xhiuo': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'sajfcie0': {
      'en': 'In Progress',
      'es': '',
      'pt': '',
    },
    '067d7bnr': {
      'en': 'Product Testing',
      'es': '',
      'pt': '',
    },
    'o6iiek89': {
      'en': 'Emily Rambo',
      'es': '',
      'pt': '',
    },
    'utv4fka1': {
      'en': 'emily@domain.com',
      'es': '',
      'pt': '',
    },
    'tt4t1rfk': {
      'en': 'June 5th',
      'es': '',
      'pt': '',
    },
    'kfm0j6yg': {
      'en': 'Pending',
      'es': '',
      'pt': '',
    },
    'vgnm8czi': {
      'en': '__',
      'es': '__',
      'pt': '__',
    },
  },
  // modal_success
  {
    'o4z6h2al': {
      'en': 'Send Contract Confirmation',
      'es': 'Enviar confirmación de contrato',
      'pt': 'Enviar confirmação de contrato',
    },
    'wb1i7hws': {
      'en': 'A new contract has been generated for:',
      'es': 'Se ha generado un nuevo contrato para:',
      'pt': 'Um novo contrato foi gerado para:',
    },
    'xlmpa9un': {
      'en': 'Randy Alcorn',
      'es': 'Randy Alcorn',
      'pt': 'Randy Alcorn',
    },
    'nmyocgg5': {
      'en': 'Head of Procurement',
      'es': 'Jefe de Adquisiciones',
      'pt': 'Chefe de Compras',
    },
    'hdo1wtaa': {
      'en': 'ACME Co.',
      'es': 'ACME Co.',
      'pt': 'ACME Co.',
    },
    '08yl0dn3': {
      'en': 'Next Steps',
      'es': 'Próximos pasos',
      'pt': 'Próximos passos',
    },
    'mi8x8ydt': {
      'en':
          'Send the information below. And we will send an email with details to the customer and allow you to manage it in your dashboard.',
      'es':
          'Envía la información a continuación. Y enviaremos un correo electrónico con detalles al cliente y le permitiremos administrarlo en su panel de control.',
      'pt':
          'Envie as informações abaixo. E enviaremos um e-mail com detalhes ao cliente e permitiremos que você gerencie em seu painel.',
    },
    'vfjtm79t': {
      'en': 'Send Information',
      'es': 'Enviar información',
      'pt': 'Envie informação',
    },
    '7y3f7as6': {
      'en': 'Never Mind',
      'es': 'No importa',
      'pt': 'Deixa para lá',
    },
  },
  // modal_Message
  {
    'v6vbzgkz': {
      'en': 'Congratulations!',
      'es': '¡Felicidades!',
      'pt': 'Parabéns!',
    },
    's6wbnbnb': {
      'en':
          'Now that a contract has been generated for this customer please contact them with the date you will send the signed agreement.',
      'es':
          'Ahora que se ha generado un contrato para este cliente, comuníquese con él para indicarle la fecha en que enviará el acuerdo firmado.',
      'pt':
          'Agora que um contrato foi gerado para este cliente, entre em contato com ele informando a data em que enviará o contrato assinado.',
    },
    'urbhjqld': {
      'en': 'Okay',
      'es': 'Bueno',
      'pt': 'OK',
    },
    'i4lkja0r': {
      'en': 'Continue',
      'es': 'Continuar',
      'pt': 'Continuar',
    },
  },
  // modal_Welcome
  {
    '2mg9y1m1': {
      'en': 'Congratulations!',
      'es': '¡Felicidades!',
      'pt': 'Parabéns!',
    },
    '0xbj68r6': {
      'en': 'A new contract has been generated for:',
      'es': 'Se ha generado un nuevo contrato para:',
      'pt': 'Um novo contrato foi gerado para:',
    },
    'zihrlutq': {
      'en': 'Continue',
      'es': 'Continuar',
      'pt': 'Continuar',
    },
  },
  // createComment
  {
    'wu7zsnw9': {
      'en': 'Create Note',
      'es': 'Crear nota',
      'pt': 'Criar nota',
    },
    'h35qsqls': {
      'en': 'Find members by searching below',
      'es': 'Encuentre miembros buscando a continuación',
      'pt': 'Encontre membros pesquisando abaixo',
    },
    'tayyduii': {
      'en': 'Ricky Rodriguez',
      'es': 'Ricky Rodríguez',
      'pt': 'Ricky Rodriguez',
    },
    'rcef1x9r': {
      'en': 'Enter your note here...',
      'es': 'Introduce tu nota aquí...',
      'pt': 'Digite sua nota aqui...',
    },
    '9v8e6cz5': {
      'en': 'Create Note',
      'es': 'Crear nota',
      'pt': 'Criar nota',
    },
  },
  // mobileNav
  {
    'ck1tal2n': {
      'en': 'Dashboard',
      'es': 'Panel',
      'pt': 'Painel',
    },
    'i2d5pmfg': {
      'en': 'My Team',
      'es': 'Mi equipo',
      'pt': 'Meu time',
    },
    'at6e9fup': {
      'en': 'Customers',
      'es': 'Clientes',
      'pt': 'Clientes',
    },
    'w76jpp8r': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'vnrxmuln': {
      'en': 'Profile',
      'es': 'Perfil',
      'pt': 'Perfil',
    },
  },
  // webNav
  {
    '3xp537ju': {
      'en': 'Search',
      'es': 'Buscar',
      'pt': 'Procurar',
    },
    'jrw1f1q0': {
      'en': 'Dashboard',
      'es': 'Panel',
      'pt': 'Painel',
    },
    'tbnb3472': {
      'en': 'Customers',
      'es': 'Clientes',
      'pt': 'Clientes',
    },
    '6ungvq12': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'w3fjcpok': {
      'en': 'Messages',
      'es': 'Mensajes',
      'pt': 'Mensagens',
    },
    'wx629swm': {
      'en': 'Profile',
      'es': 'Perfil',
      'pt': 'Perfil',
    },
  },
  // commandPalette
  {
    'p5exoxw1': {
      'en': 'Search platform...',
      'es': 'Plataforma de búsqueda...',
      'pt': 'Plataforma de pesquisa...',
    },
    'djwwauej': {
      'en': 'Search',
      'es': 'Buscar',
      'pt': 'Procurar',
    },
    'msnhfrsd': {
      'en': 'Quick Links',
      'es': 'enlaces rápidos',
      'pt': 'Links Rápidos',
    },
    'q7w48rsn': {
      'en': 'Add Quiz',
      'es': 'Agregar cuestionario',
      'pt': 'Adicionar questionário',
    },
    '6jac8jof': {
      'en': 'Find Customer',
      'es': 'Encontrar cliente',
      'pt': 'Encontre o cliente',
    },
    '2y3rg9ll': {
      'en': 'New Project',
      'es': 'Nuevo proyecto',
      'pt': 'Novo projeto',
    },
    'nog04qs1': {
      'en': 'New Customer',
      'es': 'Nuevo cliente',
      'pt': 'Novo cliente',
    },
  },
  // editProfilePhoto
  {
    'hrtlbrem': {
      'en': 'Change Photo',
      'es': 'Cambiar foto',
      'pt': 'Mudar foto',
    },
    'lm9t5o81': {
      'en':
          'Upload a new photo below in order to change your avatar seen by others.',
      'es':
          'Sube una nueva foto a continuación para cambiar tu avatar visto por otros.',
      'pt':
          'Carregue uma nova foto abaixo para alterar seu avatar visto por outras pessoas.',
    },
    '102sp48z': {
      'en': 'Upload Image',
      'es': 'Cargar imagen',
      'pt': 'Enviar Imagem',
    },
    'dpxwp3cm': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
      'pt': 'Salvar alterações',
    },
  },
  // user_Details_main
  {
    '4u14g7mi': {
      'en': 'Customer Name',
      'es': 'Nombre del cliente',
      'pt': 'nome do cliente',
    },
    'z9sbm2fl': {
      'en': 'Randy Alcorn',
      'es': 'Randy Alcorn',
      'pt': 'Randy Alcorn',
    },
    'vqwx0gno': {
      'en': 'High Profile',
      'es': 'De alto perfil',
      'pt': 'Alto perfil',
    },
    'skqf04o7': {
      'en': 'Title',
      'es': 'Título',
      'pt': 'Título',
    },
    'ox337fvi': {
      'en': 'Head of Procurement',
      'es': 'Jefe de Adquisiciones',
      'pt': 'Chefe de Compras',
    },
    'esbhueit': {
      'en': 'Company',
      'es': 'Compañía',
      'pt': 'Empresa',
    },
    'aqdbhq4k': {
      'en': 'ACME Co.',
      'es': 'ACME Co.',
      'pt': 'ACME Co.',
    },
    'c5jxplxt': {
      'en': 'Notes',
      'es': 'Notas',
      'pt': 'Notas',
    },
    'eyujd4cm': {
      'en': 'Alexandria Smith',
      'es': 'Alejandría Smith',
      'pt': 'Alexandra Smith',
    },
    'sum14gzc': {
      'en': '1m ago',
      'es': 'hace 1m',
      'pt': '1 minuto atrás',
    },
    '690an3mi': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'pt':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidente ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comodo consequat.',
    },
    'eumoqpm5': {
      'en': '8',
      'es': '8',
      'pt': '8',
    },
    'mxy49i67': {
      'en': 'Notes',
      'es': 'Notas',
      'pt': 'Notas',
    },
    '3llaxvbi': {
      'en': 'Randy Alcorn',
      'es': 'Randy Alcorn',
      'pt': 'Randy Alcorn',
    },
    '458sbgmp': {
      'en':
          'I\'m not really sure about this section here aI think you should do soemthing cool!',
      'es':
          'No estoy muy seguro acerca de esta sección aquí. ¡Creo que deberías hacer algo interesante!',
      'pt':
          'Não tenho muita certeza sobre esta seção aqui, mas acho que você deveria fazer algo legal!',
    },
    '40k2fyh7': {
      'en': 'a min ago',
      'es': 'hace un minuto',
      'pt': 'um minuto atrás',
    },
    '4fq7fiks': {
      'en': 'Generate Quote',
      'es': 'Generar cotización',
      'pt': 'Gerar cotação',
    },
    'yucj4oym': {
      'en': 'View Company',
      'es': 'Ver empresa',
      'pt': 'Ver empresa',
    },
  },
  // dropdown_UserEdit
  {
    'c8ysdxiu': {
      'en': 'Options',
      'es': 'Opciones',
      'pt': 'Opções',
    },
    'd9ryt002': {
      'en': 'Edit',
      'es': 'Editar',
      'pt': 'Editar',
    },
    '54uadx3u': {
      'en': 'Assign',
      'es': 'Asignar',
      'pt': 'Atribuir',
    },
    'a8chgsdz': {
      'en': 'Share',
      'es': 'Compartir',
      'pt': 'Compartilhar',
    },
    'vvtmwqdd': {
      'en': 'Delete',
      'es': 'Borrar',
      'pt': 'Excluir',
    },
  },
  // modal_CreateProject
  {
    'mk56sn2k': {
      'en': 'Create Project',
      'es': 'Crear proyecto',
      'pt': 'Criar projeto',
    },
    'ngmd2srv': {
      'en': 'Please enter the information below to add a project.',
      'es':
          'Por favor ingrese la información a continuación para agregar un proyecto.',
      'pt':
          'Por favor, insira as informações abaixo para adicionar um projeto.',
    },
    '0ishitvf': {
      'en': 'Add Photo',
      'es': 'Añadir foto',
      'pt': 'Adicionar foto',
    },
    'jsmw3pf1': {
      'en': 'Project Name',
      'es': 'Nombre del proyecto',
      'pt': 'Nome do Projeto',
    },
    '0ifh4wkh': {
      'en': 'Description here...',
      'es': 'Descripción aquí...',
      'pt': 'Descrição aqui...',
    },
    'kkg16lkv': {
      'en': 'Create Project',
      'es': 'Crear proyecto',
      'pt': 'Criar projeto',
    },
    'q21n8hug': {
      'en': 'Please enter a project name...',
      'es': 'Por favor ingrese un nombre de proyecto...',
      'pt': 'Por favor insira um nome de projeto...',
    },
    '8f209h4d': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    't1of39qe': {
      'en': 'Please enter a short description...',
      'es': 'Por favor ingrese una breve descripción...',
      'pt': 'Por favor insira uma breve descrição...',
    },
    '7wmhh5kj': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Escolha uma opção no menu suspenso',
    },
  },
  // projectDetails_alt
  {
    '9uv90bqj': {
      'en': 'ACME Co.',
      'es': 'ACME Co.',
      'pt': 'ACME Co.',
    },
    'w5jvmkkd': {
      'en': 'Contracts for New Opportunities',
      'es': 'Contratos para nuevas oportunidades',
      'pt': 'Contratos para Novas Oportunidades',
    },
    'xqxnjkc0': {
      'en': 'Assigned To',
      'es': 'Asignado a',
      'pt': 'Atribuído a',
    },
    'f0vhbgw6': {
      'en': 'Randy Rudolph',
      'es': 'Randy Rudolph',
      'pt': 'Randy Rodolfo',
    },
    '6n5z0jvm': {
      'en': 'name@domain.com',
      'es': 'nombre@dominio.com',
      'pt': 'nome@domínio.com',
    },
    'dd9b0xdh': {
      'en': 'Next Action',
      'es': 'Proxima accion',
      'pt': 'Próxima ação',
    },
    'tkgfyhmn': {
      'en': 'Tuesday, 10:00am',
      'es': 'Martes, 10:00 a.m.',
      'pt': 'Terça-feira, 10h00',
    },
    '7wor1mst': {
      'en': 'In Progress',
      'es': 'En curso',
      'pt': 'Em andamento',
    },
    '6jall88x': {
      'en': 'Activity',
      'es': 'Actividad',
      'pt': 'Atividade',
    },
    'ovq7t8iq': {
      'en': 'FlutterFlow CRM App:',
      'es': 'Aplicación FlutterFlow CRM:',
      'pt': 'Aplicativo FlutterFlow CRM:',
    },
    'j9ncocoz': {
      'en': ' Begin Work',
      'es': 'comenzar a trabajar',
      'pt': 'Comece o trabalho',
    },
    'fccggead': {
      'en': 'SOW Change Order',
      'es': 'Orden de cambio de SOW',
      'pt': 'Pedido de alteração SOW',
    },
    '6bbiq9bp': {
      'en': 'FlutterFlow CRM App',
      'es': 'Aplicación FlutterFlow CRM',
      'pt': 'Aplicativo FlutterFlow CRM',
    },
    '0sx85jn1': {
      'en': 'Jul 8, at 4:31pm',
      'es': '8 de julio a las 16:31',
      'pt': '8 de julho, às 16h31',
    },
    'o7j4cuuz': {
      'en': 'Jeremiah Goldsten ',
      'es': 'Jeremías Goldsten',
      'pt': 'Jeremias Goldsten',
    },
    'b1v6cjl2': {
      'en': 'accepted a request',
      'es': 'aceptó una solicitud',
      'pt': 'aceitou um pedido',
    },
    '5ek4g7bc': {
      'en': 'SOW Change Order',
      'es': 'Orden de cambio de SOW',
      'pt': 'Pedido de alteração SOW',
    },
    '9g1t934n': {
      'en': 'FlutterFlow CRM App',
      'es': 'Aplicación FlutterFlow CRM',
      'pt': 'Aplicativo FlutterFlow CRM',
    },
    'fooroh0q': {
      'en':
          '\"Notifications and reminders informing users about upcoming classes and training schedules will be sent to them via email, SMS or notifications within the application.\"',
      'es':
          '\"Las notificaciones y recordatorios que informarán a los usuarios sobre las próximas clases y horarios de capacitación se les enviarán por correo electrónico, SMS o notificaciones dentro de la aplicación\".',
      'pt':
          '“Notificações e lembretes informando aos usuários sobre as próximas aulas e horários de treinamento serão enviados a eles por e-mail, SMS ou notificações dentro do aplicativo.”',
    },
    'weqlca8k': {
      'en': 'Jul 8, at 4:30pm',
      'es': '8 de julio a las 16:30',
      'pt': '8 de julho, às 16h30',
    },
    'w1ryn345': {
      'en': 'Randy Rudolph ',
      'es': 'Randy Rudolph',
      'pt': 'Randy Rodolfo',
    },
    'x9n8k4qz': {
      'en': 'sent a SOW Change Order for ',
      'es': 'envió una orden de cambio SOW para',
      'pt': 'enviou um pedido de alteração SOW para',
    },
    'ils0ngls': {
      'en': 'FlutterFlow CRM APP',
      'es': 'Aplicación FlutterFlow CRM',
      'pt': 'APLICATIVO FlutterFlow CRM',
    },
    '3anj10p2': {
      'en': 'SOW Change Order',
      'es': 'Orden de cambio de SOW',
      'pt': 'Pedido de alteração SOW',
    },
    '8zp49wm4': {
      'en': 'FlutterFlow CRM App',
      'es': 'Aplicación FlutterFlow CRM',
      'pt': 'Aplicativo FlutterFlow CRM',
    },
    'w0v6189l': {
      'en':
          '\"Please review the updates to this document and get back with me.\"',
      'es':
          '\"Revise las actualizaciones de este documento y comuníquese conmigo\".',
      'pt':
          '\"Por favor, revise as atualizações deste documento e volte comigo.\"',
    },
    'afs4v2oo': {
      'en': 'Jul 8, at 2:20pm',
      'es': '8 de julio a las 14:20',
      'pt': '8 de julho, às 14h20',
    },
    'p9uamaqv': {
      'en': 'Contracts',
      'es': 'Contratos',
      'pt': 'Contratos',
    },
    'kau0tmbs': {
      'en': 'Updates to Existing App',
      'es': 'Actualizaciones de la aplicación existente',
      'pt': 'Atualizações para aplicativos existentes',
    },
    'm0t4g5za': {
      'en':
          'Additional Details around this contract and who is working on it in this card!',
      'es':
          '¡Detalles adicionales sobre este contrato y quién está trabajando en él en esta tarjeta!',
      'pt':
          'Detalhes adicionais sobre este contrato e quem está trabalhando nele neste cartão!',
    },
    'pq1mbld3': {
      'en': 'Contract Details',
      'es': 'Detalles del contrato',
      'pt': 'Detalhes do contrato',
    },
    '0rnsror5': {
      'en': '\$210,000',
      'es': '\$210,000',
      'pt': 'US\$ 210.000',
    },
    'g9kjxkho': {
      'en': 'Mark as Complete',
      'es': 'Marcar como completo',
      'pt': 'Marcar como concluído',
    },
    'crjlpltg': {
      'en': 'New FlutterFlow App',
      'es': 'Nueva aplicación FlutterFlow',
      'pt': 'Novo aplicativo FlutterFlow',
    },
    'ariorxjh': {
      'en':
          'The user can browse through our extensive catalog of fitness classes by filtering based on class type, location, time, and instructor. Each class will have detailed descriptions of the program, instructors, timings, availability, and rates.',
      'es':
          'El usuario puede navegar a través de nuestro extenso catálogo de clases de fitness filtrando según el tipo de clase, la ubicación, el horario y el instructor. Cada clase tendrá descripciones detalladas del programa, instructores, horarios, disponibilidad y tarifas.',
      'pt':
          'O usuário pode navegar por nosso extenso catálogo de aulas de ginástica filtrando com base no tipo de aula, local, horário e instrutor. Cada aula terá descrições detalhadas do programa, instrutores, horários, disponibilidade e taxas.',
    },
    'hlq4sypp': {
      'en': 'Contract Details',
      'es': 'Detalles del contrato',
      'pt': 'Detalhes do contrato',
    },
    '0xclxmka': {
      'en': '\$67,000',
      'es': '\$67,000',
      'pt': 'US\$ 67.000',
    },
    '76flbloo': {
      'en': 'Mark as Complete',
      'es': 'Marcar como completo',
      'pt': 'Marcar como concluído',
    },
    '4o8dzoau': {
      'en': 'Project Details',
      'es': 'detalles del proyecto',
      'pt': 'Detalhes do Projeto',
    },
  },
  // modal_create_Company
  {
    'yi0wllgs': {
      'en': 'Create Company Profile',
      'es': 'Crear perfil de empresa',
      'pt': 'Criar perfil da empresa',
    },
    'utnm0da7': {
      'en':
          'Upload images about your company and fill out the information below.',
      'es':
          'Sube imágenes sobre tu empresa y completa la información a continuación.',
      'pt':
          'Faça upload de imagens sobre sua empresa e preencha os dados abaixo.',
    },
    'r8fj7u3w': {
      'en': 'Company Name',
      'es': 'nombre de empresa',
      'pt': 'nome da empresa',
    },
    'ya19zc1r': {
      'en': 'Company City',
      'es': 'Ciudad de la empresa',
      'pt': 'Cidade da Empresa',
    },
    '58spyt9l': {
      'en': 'Website',
      'es': 'Sitio web',
      'pt': 'Local na rede Internet',
    },
    'q1e7ernu': {
      'en': 'Enter in your website without \"https://\"...',
      'es': 'Entra en tu sitio web sin \"https://\"...',
      'pt': 'Entre no seu site sem \"https://\"...',
    },
    '3b7rv3ii': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'fu492ikp': {
      'en': 'Create Company',
      'es': 'Crear empresa',
      'pt': 'Criar empresa',
    },
  },
  // modal_inviteUser
  {
    '5u8uagtf': {
      'en': 'Edit User Details',
      'es': 'Editar detalles de usuario',
      'pt': 'Editar detalhes do usuário',
    },
    '5z3vlyne': {
      'en': 'Edit the details of the user below.',
      'es': 'Edite los detalles del usuario a continuación.',
      'pt': 'Edite os detalhes do usuário abaixo.',
    },
    'shiu5o3o': {
      'en': 'Randy Peterson',
      'es': 'Randy Peterson',
      'pt': 'Randy Peterson',
    },
    'n2otqspb': {
      'en': 'name@domainname.com',
      'es': 'nombre@nombrededominio.com',
      'pt': 'nome@nomedodomínio.com',
    },
    'keszhycz': {
      'en': 'User Name',
      'es': 'Nombre de usuario',
      'pt': 'Nome de usuário',
    },
    'fm27oh7x': {
      'en': 'Bio',
      'es': 'Biografía',
      'pt': 'Biografia',
    },
    'ja3t9ajp': {
      'en': 'Admin',
      'es': 'Administración',
      'pt': 'Administrador',
    },
    'nnjz9rd0': {
      'en': 'Manager',
      'es': 'Gerente',
      'pt': 'Gerente',
    },
    '171wegse': {
      'en': 'Editor',
      'es': 'Editor',
      'pt': 'editor',
    },
    'aoh1o30c': {
      'en': 'Viewer',
      'es': 'Espectador',
      'pt': 'Visualizador',
    },
    'y991fnwv': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'pt': 'Por favor selecione...',
    },
    'caa89516': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'pt': 'Procure um item...',
    },
    '1fcw8591': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'sekfikj5': {
      'en': 'Send Invites',
      'es': 'Enviar invitaciones',
      'pt': 'Enviar convites',
    },
  },
  // modal_enterPin
  {
    'o4yq2v3n': {
      'en': 'Enter your PIN below',
      'es': 'Ingrese su PIN a continuación',
      'pt': 'Digite seu PIN abaixo',
    },
    'yoqsuu92': {
      'en': 'Your project has been created, now invite your team to continue.',
      'es': 'Tu proyecto ha sido creado, ahora invita a tu equipo a continuar.',
      'pt': 'Seu projeto foi criado, agora convide sua equipe para continuar.',
    },
    '5vpk1yyw': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'r23bhryy': {
      'en': 'Verify Code',
      'es': 'Código de verificación',
      'pt': 'Código de verificação',
    },
  },
  // modal_shareProject
  {
    'c15vsald': {
      'en': 'Share your project',
      'es': 'Comparte tu proyecto',
      'pt': 'Compartilhe seu projeto',
    },
    'tlfhtk63': {
      'en': 'Your project has been created, now invite your team to continue.',
      'es': 'Tu proyecto ha sido creado, ahora invita a tu equipo a continuar.',
      'pt': 'Seu projeto foi criado, agora convide sua equipe para continuar.',
    },
    'nlawzvwu': {
      'en': 'Randy Peterson',
      'es': 'Randy Peterson',
      'pt': 'Randy Peterson',
    },
    'q1znd0a9': {
      'en': 'name@domainname.com',
      'es': 'nombre@nombrededominio.com',
      'pt': 'nome@nomedodomínio.com',
    },
    'qclwso93': {
      'en': 'Randy Peterson',
      'es': 'Randy Peterson',
      'pt': 'Randy Peterson',
    },
    'zh1i4vkp': {
      'en': 'name@domainname.com',
      'es': 'nombre@nombrededominio.com',
      'pt': 'nome@nomedodomínio.com',
    },
    'mz2leksu': {
      'en': 'Randy Peterson',
      'es': 'Randy Peterson',
      'pt': 'Randy Peterson',
    },
    'w70por4e': {
      'en': 'name@domainname.com',
      'es': 'nombre@nombrededominio.com',
      'pt': 'nome@nomedodomínio.com',
    },
    '97dfv2ni': {
      'en': 'Add User',
      'es': 'Agregar usuario',
      'pt': 'Adicionar usuário',
    },
    '9lk8lqh1': {
      'en': 'Project Link',
      'es': 'Enlace del proyecto',
      'pt': 'Link do projeto',
    },
    'qyahsq7s': {
      'en': 'https://project.flutterflow.io/?quizRef=T7c8mXvkYFFCWjqyhxKe',
      'es': 'https://project.flutterflow.io/?quizRef=T7c8mXvkYFFCWjqyhxKe',
      'pt': 'https://project.flutterflow.io/?quizRef=T7c8mXvkYFFCWjqyhxKe',
    },
    'fp20zdsk': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'v7sb74qf': {
      'en': 'Send Invites',
      'es': 'Enviar invitaciones',
      'pt': 'Enviar convites',
    },
  },
  // Modal_Add_usersList
  {
    'ponxxfhj': {
      'en': 'Invite your Team',
      'es': 'Invita a tu equipo',
      'pt': 'Convide sua equipe',
    },
    '5kml9uy0': {
      'en': 'Your project has been created, now invite your team to continue.',
      'es': 'Tu proyecto ha sido creado, ahora invita a tu equipo a continuar.',
      'pt': 'Seu projeto foi criado, agora convide sua equipe para continuar.',
    },
    'cobrzccb': {
      'en': 'Email address...',
      'es': 'Dirección de correo electrónico...',
      'pt': 'Endereço de email...',
    },
    'zu2qo9my': {
      'en': 'email@domainname.com',
      'es': 'correo electrónico@nombrededominio.com',
      'pt': 'e-mail@nomedodomínio.com',
    },
    'hru1l6vi': {
      'en': 'email@domainname.com',
      'es': 'correo electrónico@nombrededominio.com',
      'pt': 'e-mail@nomedodomínio.com',
    },
    'peo3lwaq': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'db6lpb4k': {
      'en': 'Send Invites',
      'es': 'Enviar invitaciones',
      'pt': 'Enviar convites',
    },
  },
  // modal_profile_Details
  {
    '4ai5khng': {
      'en': 'Profile Details',
      'es': 'detalles del perfil',
      'pt': 'Detalhes de perfil',
    },
    '2u3wdo07': {
      'en': 'Below are your profile details',
      'es': 'A continuación se muestran los detalles de su perfil.',
      'pt': 'Abaixo estão os detalhes do seu perfil',
    },
    'rle7t3kd': {
      'en': 'Randy Peterson',
      'es': 'Randy Peterson',
      'pt': 'Randy Peterson',
    },
    'rvgffcl2': {
      'en': 'name@domainname.com',
      'es': 'nombre@nombrededominio.com',
      'pt': 'nome@nomedodomínio.com',
    },
    '4e7p3a0w': {
      'en': 'Manage your account',
      'es': 'Gestiona tu cuenta',
      'pt': 'Gerencie sua conta',
    },
    'g0nvlyfh': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
      'pt': 'Editar Perfil',
    },
    'd3gufyal': {
      'en': 'Reset Password',
      'es': 'Restablecer la contraseña',
      'pt': 'Redefinir senha',
    },
    '67up1add': {
      'en': 'Light Mode',
      'es': 'Modo de luz',
      'pt': 'Modo claro',
    },
    'efdzm127': {
      'en': 'Dark Mode',
      'es': 'Modo oscuro',
      'pt': 'Modo escuro',
    },
    '1adearn6': {
      'en': 'Get in Touch',
      'es': 'Ponerse en contacto',
      'pt': 'Entrar em contato',
    },
    'ciqzw0rw': {
      'en': 'Help & Support',
      'es': 'Servicio de asistencia',
      'pt': 'Ajuda e suporte',
    },
    'nk8xfgz7': {
      'en': 'Share [App Name]',
      'es': 'Compartir [Nombre de la aplicación]',
      'pt': 'Compartilhe [nome do aplicativo]',
    },
    'huangpgg': {
      'en': 'Close',
      'es': 'Cerca',
      'pt': 'Fechar',
    },
  },
  // modal_profile_Edit
  {
    'pkdhazzg': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
      'pt': 'Editar Perfil',
    },
    'j0xuuk8x': {
      'en': 'Below are your profile details',
      'es': 'A continuación se muestran los detalles de su perfil.',
      'pt': 'Abaixo estão os detalhes do seu perfil',
    },
    'x5p4bcbn': {
      'en': 'Change Photo',
      'es': 'Cambiar foto',
      'pt': 'Mudar foto',
    },
    'dh7wm4he': {
      'en': 'Your Name',
      'es': 'Su nombre',
      'pt': 'Seu nome',
    },
    'hsvocm8a': {
      'en': 'Short Description',
      'es': 'Breve descripción',
      'pt': 'Pequena descrição',
    },
    'vm2xpc0q': {
      'en': 'Admin',
      'es': 'Administración',
      'pt': 'Administrador',
    },
    'y3dvlwfy': {
      'en': 'Admin',
      'es': 'Administración',
      'pt': 'Administrador',
    },
    '1x4hf5zu': {
      'en': 'Manager',
      'es': 'Gerente',
      'pt': 'Gerente',
    },
    'aidpvg2a': {
      'en': 'Editor',
      'es': 'Editor',
      'pt': 'editor',
    },
    'dpidk3se': {
      'en': 'Viewer',
      'es': 'Espectador',
      'pt': 'Visualizador',
    },
    'zss1z1tq': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'pt': 'Por favor selecione...',
    },
    '50blrrzw': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'pt': 'Procure um item...',
    },
    '5882l8dj': {
      'en': 'The email associated with this account is:',
      'es': 'El correo electrónico asociado a esta cuenta es:',
      'pt': 'O e-mail associado a esta conta é:',
    },
    'bxfxqrcj': {
      'en': 'casper@ghostbusters.com',
      'es': 'casper@cazafantasmas.com',
      'pt': 'casper@ghostbusters.com',
    },
    'qid2e28n': {
      'en': 'Created On:',
      'es': 'Creado en:',
      'pt': 'Criado em:',
    },
    '70hcubz1': {
      'en': 'July 12th, 2023',
      'es': '12 de julio de 2023',
      'pt': '12 de julho de 2023',
    },
    'm8l109fl': {
      'en': 'Last Active:',
      'es': 'Último Activo:',
      'pt': 'Ativo pela última vez:',
    },
    'l5voyw5y': {
      'en': 'Just Now',
      'es': 'En este momento',
      'pt': 'Agora mesmo',
    },
    'l5smwzux': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'tqut5hxm': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
      'pt': 'Salvar alterações',
    },
  },
  // TopNav1
  {
    'ja8cgba9': {
      'en': 'Home',
      'es': '',
      'pt': '',
    },
    'rinnf3n9': {
      'en': 'Chats',
      'es': '',
      'pt': '',
    },
    'ekj93dnh': {
      'en': 'Projects',
      'es': '',
      'pt': '',
    },
    'wvsxdjaf': {
      'en': 'Andrew D.',
      'es': '',
      'pt': '',
    },
    'ckp7kl3v': {
      'en': '@andrewd',
      'es': '',
      'pt': '',
    },
  },
  // Miscellaneous
  {
    '0nwoj0kc': {
      'en': 'Email address',
      'es': 'Dirección de correo electrónico',
      'pt': 'Endereço de email',
    },
    'upni203i': {
      'en': 'Password',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    'x5hsigqw': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    '9wy77t9v': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    'woezzutp': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    '2bj20mi4': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    'oztjr3ws': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    'hc87g50d': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    '8ct6cr3a': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    'e368pegn': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    'yv65a6i5': {
      'en': 'Button',
      'es': 'Botón',
      'pt': 'Botão',
    },
    '4r7kaahz': {
      'en': 'Calling',
      'es': 'Vocación',
      'pt': 'Chamando',
    },
    '9zk4wopm': {
      'en': 'Not Called',
      'es': 'No llamado',
      'pt': 'Não chamado',
    },
    'xn2fkope': {
      'en': 'Pending Review',
      'es': 'Revisión pendiente',
      'pt': 'Revisão pendente',
    },
    'jv85czds': {
      'en': 'Closed',
      'es': 'Cerrado',
      'pt': 'Fechado',
    },
    'swt4x372': {
      'en': 'Completed',
      'es': 'Terminado',
      'pt': 'Concluído',
    },
    '5w6ne1dl': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'pt': 'Por favor selecione...',
    },
    'uhfmgei0': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'pt': 'Procure um item...',
    },
    'lted0txl': {
      'en': 'All',
      'es': 'Todo',
      'pt': 'Todos',
    },
    'm6iqz668': {
      'en': 'Pending',
      'es': 'Pendiente',
      'pt': 'Pendente',
    },
    'x2pvxk5r': {
      'en': 'Completed',
      'es': 'Terminado',
      'pt': 'Concluído',
    },
    'txjoh349': {
      'en': 'Calling',
      'es': 'Vocación',
      'pt': 'Chamando',
    },
    'qube3xir': {
      'en': 'All',
      'es': 'Todo',
      'pt': 'Todos',
    },
    'mxalfkji': {
      'en': '50%',
      'es': '50%',
      'pt': '50%',
    },
    'z6o24u9q': {
      'en': 'Notifications',
      'es': 'Notificaciones',
      'pt': 'Notificações',
    },
    'poegde7v': {
      'en': 'Notifications',
      'es': 'Notificaciones',
      'pt': 'Notificações',
    },
    'v3vjad01': {
      'en': 'Turn on notifications',
      'es': 'Activar las notificaciones',
      'pt': 'Ative as notificações',
    },
    'bqjgqich': {
      'en': 'Male',
      'es': 'Masculino',
      'pt': 'Macho',
    },
    'rzl2h9ar': {
      'en': 'Female',
      'es': 'Femenino',
      'pt': 'Fêmea',
    },
    'qtchqf19': {
      'en': 'Other',
      'es': 'Otro',
      'pt': 'Outro',
    },
    '82a75t5n': {
      'en': 'Design',
      'es': 'Diseño',
      'pt': 'Projeto',
    },
    'w82xuklg': {
      'en': 'Marketing',
      'es': 'Marketing',
      'pt': 'Marketing',
    },
    '5uiyxwtk': {
      'en': 'Development',
      'es': 'Desarrollo',
      'pt': 'Desenvolvimento',
    },
    '3wjkerx7': {
      'en': 'Management',
      'es': 'Gestión',
      'pt': 'Gerenciamento',
    },
    'p6rgfj1v': {
      'en': 'Operations',
      'es': 'Operaciones',
      'pt': 'Operações',
    },
    'c8uww550': {
      'en': 'Customer Service',
      'es': 'Servicio al Cliente',
      'pt': 'Atendimento ao Cliente',
    },
    '2rhm2suy': {
      'en': 'Design',
      'es': 'Diseño',
      'pt': 'Projeto',
    },
    'hxsxj681': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'e7agr7ys': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '65e2tfs2': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'ddazihx4': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'db03cpjj': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'fdb9078p': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '80ouzj9q': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '6rzhptp9': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'ce8c4ty0': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'sobkcsba': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'pl4w62l6': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'kcvqa08x': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'dqrzd6sq': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'dpqtohyf': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'v01vf71s': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'gcv6def1': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'um9es99m': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'o4enbz4j': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '8z4tvfh7': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '2ybzla8x': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'd1wdf5i1': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'f4rdu9en': {
      'en': '',
      'es': '',
      'pt': '',
    },
    '2py80kgi': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'p6lsrh2a': {
      'en': '',
      'es': '',
      'pt': '',
    },
    'ne8cclp9': {
      'en': '',
      'es': '',
      'pt': '',
    },
  },
].reduce((a, b) => a..addAll(b));
