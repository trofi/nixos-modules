# The problem: default NixOS locales do not support non-UTF-8 locales.
#
# The solution: install all locales provided by glic.
{ ... }:
{
  i18n.defaultLocale = "C.UTF-8";
  i18n.supportedLocales = [ "all" ];
}
